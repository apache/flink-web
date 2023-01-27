---
authors:
- dwysakowicz: null
  name: Dawid Wysakowicz
  twitter: dwysakowicz
- Daisy Tsang: null
  name: Daisy Tsang
date: "2022-05-06T00:00:00Z"
excerpt: This post will outline the journey of improving snapshotting in past releases
  and the upcoming improvements in Flink 1.15, which includes making it possible to
  take savepoints in the native state backend specific format as well as clarifying
  snapshots ownership.
title: 'Improvements to Flink operations: Snapshots Ownership and Savepoint Formats'
---

Flink has become a well established data streaming engine and a
mature project requires some shifting of priorities from thinking purely about new features 
towards improving stability and operational simplicity. In the last couple of releases, the Flink community has tried to address
some known friction points, which includes improvements to the
snapshotting process. Snapshotting takes a global, consistent image of the state of a Flink job and is integral to fault-tolerance and exacty-once processing. Snapshots include savepoints and checkpoints. 

This post will outline the journey of improving snapshotting in past releases and the upcoming improvements in Flink 1.15, which includes making it possible to take savepoints in the native state backend specific format as well as clarifying snapshots ownership. 

{% toc %}

# Past improvements to the snapshotting process 

Flink 1.13 was the first release where we announced [unaligned checkpoints]({{< param DocsBaseUrl >}}flink-docs-release-1.15/docs/concepts/stateful-stream-processing/#unaligned-checkpointing) to be production-ready. We
encouraged people to use them if their jobs are backpressured to a point where it causes issues for
checkpoints.  We also [unified the binary format of savepoints](/news/2021/05/03/release-1.13.0.html#switching-state-backend-with-savepoints) across all
different state backends, which enables stateful switching of savepoints.

Flink 1.14 also brought additional improvements. As an alternative and as a complement
to unaligned checkpoints, we introduced a feature called ["buffer debloating"](/news/2021/09/29/release-1.14.0.html#buffer-debloating). This is built
around the concept of automatically adjusting the amount of in-flight data that needs to be aligned
while snapshotting. We also fixed another long-standing problem and made it
possible to [continue checkpointing even if there are finished tasks](/news/2021/09/29/release-1.14.0.html#checkpointing-and-bounded-streams) in a JobGraph.




# New improvements to the snapshotting process 

You can expect more improvements in Flink 1.15! We continue to be invested in making it easy 
to operate Flink clusters and have tackled the following problems. :)

Savepoints can be expensive
to take and restore from if taken for a very large state stored in the RocksDB state backend. In
order to circumvent this issue, we have seen users leveraging the externalized incremental checkpoints
instead of savepoints in order to benefit from the native RocksDB format. However, checkpoints and savepoints
serve different operational purposes. Thus, we now made it possible to take savepoints in the
native state backend specific format, while still maintaining some characteristics of savepoints (i.e. making them relocatable). 

Another issue reported with externalized checkpoints is that it is not clear who owns the
checkpoint files (Flink or the user?). This is especially problematic when it comes to incremental RocksDB checkpoints
where you can easily end up in a situation where you do not know which checkpoints depend on which files
which makes it tough to clean those files up. To solve this issue, we added explicit restore
modes (CLAIM, NO_CLAIM, and LEGACY) which clearly define whether Flink should take
care of cleaning up the snapshots or whether it should remain the user's responsibility.
 .

## The new restore modes

The `Restore Mode` determines who takes ownership of the files that make up savepoints or
externalized checkpoints after they are restored. Snapshots, which are either checkpoints or savepoints
in this context, can be owned either by a user or Flink itself. If a snapshot is owned by a user,
Flink will not delete its files and will not depend on the existence
of such files since it might be deleted outside of Flink's control.

The restore modes are `CLAIM`, `NO_CLAIM`, and `LEGACY` (for backwards compatibility). You can pass the restore mode like this:

```
$ bin/flink run -s :savepointPath -restoreMode :mode -n [:runArgs]
```

While each restore mode serves a specific purpose, we believe the default *NO_CLAIM* mode is a good
tradeoff in most situations, as it provides clear ownership with a small price for the first
checkpoint after the restore.

Let's dig further into each of the modes.

### LEGACY mode

The legacy mode is how Flink dealt with snapshots until version 1.15. In this mode, Flink will never delete the initial
checkpoint. Unfortunately, at the same time, it is not clear if a user can ever delete it as well. 
The problem here is that Flink might immediately build an incremental checkpoint on top of the
restored one. Therefore, subsequent checkpoints depend on the restored checkpoint. Overall, the
ownership is not well defined in this mode.

<div style="text-align: center">
  <img src="{{< siteurl >}}/img/blog/2022-05-06-restore-modes/restore-mode-legacy.svg" alt="LEGACY restore mode" width="70%">
</div>


### NO_CLAIM (default) mode

To fix the issue of files that no one can reliably claim ownership of, we introduced the `NO_CLAIM`
mode as the new default. In this mode, Flink will not assume ownership of the snapshot and will leave the files in
the user's control and never delete any of the files.  You can start multiple jobs from the
same snapshot in this mode.

In order to make sure Flink does not depend on any of the files from that snapshot, it will force
the first (successful) checkpoint to be a full checkpoint as opposed to an incremental one. This
only makes a difference for `state.backend: rocksdb`, because all other state backends always take
full checkpoints.

Once the first full checkpoint completes, all subsequent checkpoints will be taken as
usual/configured. Consequently, once a checkpoint succeeds, you can manually delete the original
snapshot. You can not do this earlier, because without any completed checkpoints, Flink will - upon
failure - try to recover from the initial snapshot.

<div style="text-align: center">
  <img src="{{< siteurl >}}/img/blog/2022-05-06-restore-modes/restore-mode-no_claim.svg" alt="NO_CLAIM restore mode" width="70%" >
</div>

### CLAIM mode

If you do not want to sacrifice any performance while taking the first checkpoint, we suggest
looking into the `CLAIM` mode. In this mode, Flink claims ownership of the snapshot
and essentially treats it like a checkpoint: it controls the lifecycle and might delete it if it is
not needed for recovery anymore. Hence, it is not safe to manually delete the snapshot or to start
two jobs from the same snapshot. Flink keeps around a configured number of checkpoints.

<div style="text-align: center">
  <img src="{{< siteurl >}}/img/blog/2022-05-06-restore-modes/restore-mode-claim.svg" alt="CLAIM restore mode" width="70%">
</div>

## Savepoint format

You can now trigger savepoints in the native format of state backends.
This has been introduced to match two characteristics, one of both savepoints and
checkpoints:

- self-contained, relocatable, and owned by users
- lightweight (and thus fast to take and recover from)

In order to provide the two features in a single concept, we provided a way for Flink to create a
savepoint in a (native) binary format of the used state backend. This brings a significant difference
especially in combination with the `state.backend: rocksdb` setting and incremental snapshots.

That state backend can leverage RocksDB native on-disk data structures which are usually referred to
as SST files. Incremental checkpoints leveraged those files and are
collections of those SST files with some additional metadata, which can be quickly reloaded
into the working directory of RocksDB upon restore.

Native savepoints can use the same mechanism of uploading the SST files instead of dumping the
entire state into a canonical Flink format. There is one additional benefit over simply using the
externalized incremental checkpoints: native savepoints are still relocatable and self-contained
in a single directory. In case of checkpoints that do not hold, because a single SST file can be
used by multiple checkpoints, and thus is put into a common shared directory. That is why they are
called incremental.

You can choose the savepoint format when triggering the savepoint like this:

```
# take an intermediate savepoint
$ bin/flink savepoint --type [native/canonical] :jobId [:targetDirectory]

# stop the job with a savepoint
$ bin/flink stop --type [native/canonical] --savepointPath [:targetDirectory] :jobId
```

### Capabilities and limitations

Unfortunately it is not possible to provide the same guarantees for all types of snapshots 
(canonical or native savepoints and aligned or unaligned checkpoints). The main difference between
checkpoints and savepoints is that savepoints are still triggered and owned by users. Flink does not
create them automatically nor ever depends on their existence. Their main purpose is still for planned,
manual backups, whereas checkpoints are used for recovery. In database terms, savepoints are similar
to backups, whereas checkpoints are like recovery logs.

Having additional dimensions of properties in each of the two main snapshots category does not make
it easier, therefore we try to list what you can achieve with every type of snapshot.

The following table gives an overview of capabilities and limitations for the various types of
savepoints and checkpoints.

- ✓ - Flink fully supports this type of snapshot
- x - Flink doesn't support this type of snapshot

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
to snapshotting. We are eager to hear from you if any of the new features have helped you solve problems you've faced in the past.
At the same time, if you still struggle with an issue or you had to work around some obstacles, please let
us know! Maybe we will be able to incorporate your approach or find a different solution together.
