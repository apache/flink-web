---
layout: post 
title:  "Tidying up snapshots"
date: 2022-04-01T00:00:00.000Z 
authors:
- dwysakowicz:
  name: "Dawid Wysakowicz"
  twitter: "dwysakowicz"

excerpt: TODO

---

{% toc %}

It's hard to argue Flink has become a well established project in the streaming ecosystem. Being a
rather mature project requires a slight shift of priorities from thinking purely about new features
towards caring more about stability and operational simplicity. Flink community tries to address
some known friction points over the last couple of releases. This includes improvements to the
snapshotting process.

Flink 1.13 was the first release we announced [unaligned checkpoints]({{site.DOCS_BASE_URL}}flink-docs-release-1.15/docs/concepts/stateful-stream-processing/#unaligned-checkpointing) to be production-ready and
encourage people to use them if their jobs are backpressured to a point where it causes issues for
checkpoints. It was also the release where we [unified the binary format of savepoints](/news/2021/05/03/release-1.13.0.html#switching-state-backend-with-savepoints) across all
different state backends, which allows for stateful switching of those. More on that a bit later.

The next release, 1.14 also brought additional improvements. As an alternative and as a complement
to unaligned checkpoints we introduced a feature, we called ["buffer debloating"](/news/2021/09/29/release-1.14.0.html#buffer-debloating). It is build
around the concept of automatically adjusting the amount of in-flight data that needs to be aligned
while snapshotting. Another long-standing problem, we fixed, was that from 1.14 onwards it is
possible to [continue checkpointing even if there are finished tasks](/news/2021/09/29/release-1.14.0.html#checkpointing-and-bounded-streams) in ones jobgraph.

The latest 1.15 release is no different, that we still want to pay attention to what makes it hard
to operate Flink's cluster. In that release we tackled the problem that savepoints can be expensive
to take and restore from if taken for a very large state stored in the RocksDB state backend. In
order to circumvent the issue we had seen users leveraging the externalized, incremental checkpoints
instead of savepoints in order to benefit from the native RocksDB format. To make it more
straightforward, we incorporated that approach and made it possible to take savepoints in that
native state backend specific format, while still maintaining some savepoints characteristics, which
makes it possible to relocate such a savepoint.

Another issue we've seen with externalized checkpoints is that it has not been clear who owns the
checkpoint files. This is especially problematic when it comes to incremental RocksDB checkpoints
where you can easily end up in a situation you do not know which checkpoints depend on which files
and thus not being able to clean those files up. To solve this issue we added explicit restore
modes:
CLAIM, NO_CLAIM and LEGACY (for backwards compatibility) which clearly define if Flink should take
care of cleaning up the snapshot or should it remain in users responsibility.

# Restore mode

The `Restore Mode` determines who takes ownership of the files that make up a savepoint or an
externalized checkpoints after restoring it. Snapshots, which are either checkpoints or savepoints
in this context, can be owned either by a user or Flink itself. If a snapshot is owned by a user,
Flink will not delete its files. What is even more important, Flink can not depend on the existence
of the files from such a snapshot, as it might be deleted outside of Flink's control.

To begin with let's see how did it look so far and what problems it may pose. We left the old
behaviour which is available if you pick the `LEGACY` mode.

## LEGACY mode

The legacy is mode is how Flink worked until 1.15. In this mode Flink will never delete the initial
checkpoint. Unfortunately, at the same time, it is not clear if a user can ever delete it as well. 
The problem here, is that Flink might immediately build an incremental checkpoint on top of the
restored one. Therefore, subsequent checkpoints depend on the restored checkpoint. Overall, the
ownership is not well-defined in this mode.

<div style="text-align: center">
  <img src="{{ site.baseurl }}/img/blog/2022-04-xx-tidying-snapshots/restore-mode-legacy.svg" alt="LEGACY restore mode" width="70%">
</div>

To fix the issue of a files that no one can reliably claim ownership we introduced the `NO_CLAIM`
mode as the new default.

## NO_CLAIM (default) mode

In the *NO_CLAIM* mode Flink will not assume ownership of the snapshot. It will leave the files in
user's control and never delete any of the files. In this mode you can start multiple jobs from the
same snapshot.

In order to make sure Flink does not depend on any of the files from that snapshot, it will force
the first (successful) checkpoint to be a full checkpoint as opposed to an incremental one. This
only makes a difference for `state.backend: rocksdb`, because all other state backends always take
full checkpoints.

Once the first full checkpoint completes, all subsequent checkpoints will be taken as
usual/configured. Consequently, once a checkpoint succeeds you can manually delete the original
snapshot. You can not do this earlier, because without any completed checkpoints Flink will - upon
failure - try to recover from the initial snapshot.

<div style="text-align: center">
  <img src="{{ site.baseurl }}/img/blog/2022-04-xx-tidying-snapshots/restore-mode-no_claim.svg" alt="NO_CLAIM restore mode" width="70%" >
</div>

If you do not want to sacrifice any performance while taking the first checkpoint, we suggest
looking into the `CLAIM` mode.

## CLAIM mode

The other available mode is the *CLAIM* mode. In this mode Flink claims ownership of the snapshot
and essentially treats it like a checkpoint: it controls the lifecycle and might delete it if it is
not needed for recovery anymore. Hence, it is not safe to manually delete the snapshot or to start
two jobs from the same snapshot. Flink keeps around a configured number of checkpoints.

<div style="text-align: center">
  <img src="{{ site.baseurl }}/img/blog/2022-04-xx-tidying-snapshots/restore-mode-claim.svg" alt="CLAIM restore mode" width="70%">
</div>

Each restore mode serves a specific purpose. Still, we believe the default *NO_CLAIM* mode is a good
tradeoff in most situations, as it provides clear ownership with a small price for the first
checkpoint after the restore.

You can pass the restore mode as:

```
$ bin/flink run -s :savepointPath -restoreMode :mode -n [:runArgs]
```

# Savepoint format

The other, already mentioned improvement, is the possibility to trigger savepoints in state backends
native format. This has been introduced to match two characteristics, one of both savepoints and
checkpoints:

- being self-contained, relocatable, and owned by users
- lightweight and thus fast to take and recover from

In order to provide the two features in a single concept we provided a way for Flink to create a
savepoint in a binary format of the used state backend. This brings a significant difference
primarily in combination with the `state.backend: rocksdb` and incremental snapshots.

That state backend can leverage RocksDB native on-disk data structures which are usually referred to
as SST files. Incremental checkpoints leveraged those files. Basically incremental snapshots are
collections of those SST files with some additional metadata, which can be rather quickly reloaded
into the working directory of RocksDB upon restore.

Native savepoints can use the same mechanism of uploading the SST files instead of dumping the
entire state into a canonical Flink format. There is one additional benefit over simply using the
externalized incremental checkpoints that native savepoints are still relocatable and self-contained
in a single directory. In case of checkpoints that does not hold, because a single SST file can be
used by multiple checkpoints, and thus is put into a common shared directory. That is why they are
called incremental.

You can choose the savepoint format when triggering the savepoint:

```
# take an intermediate savepoint
$ bin/flink savepoint --type [native/canonical] :jobId [:targetDirectory]

# stop the job with a savepoint
$ bin/flink stop --type [native/canonical] --savepointPath [:targetDirectory] :jobId
```

## Capabilities and limitations

Unfortunately it is not possible to provide the same guarantees for all types of snapshots:
canonical or native savepoints and aligned or unaligned checkpoints. The main difference between
checkpoints and savepoints is still that savepoints are triggered and owned by users. Flink does not
create them automatically, nor ever depends on their existence. The main purpose is still a planned,
manual backup, whereas checkpoints are used for recovery. In database terms, savepoints are similar
to backups, whereas checkpoints to recovery logs.

Having additional dimensions of properties in each of the two main snapshots category does not make
it easier, therefore we try to list what you can achieve with every type of snapshot

The following table gives an overview of capabilities and limitations for the various types of
savepoints and checkpoints.

- ✓ - Flink fully support this type of the snapshot
- x - Flink doesn't support this type of the snapshot

| Operation                       | Canonical Savepoint | Native Savepoint | Aligned Checkpoint | Unaligned Checkpoint |
|:--------------------------------|:--------------------|:-----------------|:-------------------|:---------------------|
| State backend change            | ✓                   | x                | x                  | x                    |
| State Processor API(writing)    | ✓                   | x                | x                  | x                    |
| State Processor API(reading)    | ✓                   | ✓                | ✓                  | x                    |
| Self-contained and relocatable  | ✓                   | ✓                | x                  | x                    |
| Schema evolution                | ✓                   | ✓                | ✓                  | ✓                    |
| Arbitrary job upgrade           | ✓                   | ✓                | ✓                  | x                    |
| Non-arbitrary job upgrade       | ✓                   | ✓                | ✓                  | x                    |
| Flink minor version upgrade     | ✓                   | ✓                | ✓                  | x                    |
| Flink bug/patch version upgrade | ✓                   | ✓                | ✓                  | ✓                    |
| Rescaling                       | ✓                   | ✓                | ✓                  | ✓                    |

- State backend change - you can restore from the snapshot with a different state.backend than the
  one for which the snapshot was taken
- State Processor API (writing) - The ability to create new snapshot via State Processor API.
- State Processor API (reading) - The ability to read state from the existing snapshot via State
  Processor API.
- Self-contained and relocatable - One snapshot directory contains everything it needs for recovery.
  You can move the directory around.
- Schema evolution - Changing the data type of the *state* in your UDFs.
- Arbitrary job upgrade - Restoring the snapshot with the different partitioning type(rescale,
  rebalance, map, etc.)
  or with a different record type for the existing operator. In other words you can add arbitrary
  operators anywhere in your job graph.
- Non-arbitrary job upgrade - In contrary to the above, you still should be able to add new
  operators, but certain limitations apply. You can not change partitioning for existing operators
  or the data type of records being exchanged.
- Flink minor version upgrade - Restoring a snapshot which was taken for an older minor version of
  Flink (1.x → 1.y).
- Flink bug/patch version upgrade - Restoring a snapshot which was taken for an older patch version
  of Flink (1.14.x → 1.14.y).
- Rescaling - Restoring the snapshot with a different parallelism than was used during the snapshot
  creation.

# Summary

We hope the changes we introduced over the last releases make it easier to operate Flink in respect
to checkpointing. We are eager to hear from you if they solve problems you've experienced yourself.
At the same time if you still struggle with an issue or you had to work around some obstacles, let
us know. Maybe we will be able to incorporate your approach or find a different solution together.
