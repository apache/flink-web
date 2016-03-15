---
title: "Community"
---

There are many ways to get help from the Apache Flink community. The [mailing lists](#mailing-lists) are the primary place where all Flink committers are present. If you want to talk with the Flink committers and users in a chat, there is a [IRC channel](#irc). Some committers are also monitoring [Stack Overflow](http://stackoverflow.com/questions/tagged/flink). Please remember to tag your questions with the *[flink](http://stackoverflow.com/questions/tagged/flink)* tag. Bugs and feature requests can either be discussed on *dev mailing list* or on [JIRA]({{ site.jire }}). Those interested in contributing to Flink should check out the [contribution guide](how-to-contribute.html).

{% toc %}

## Mailing Lists

<table class="table table-striped">
  <thead>
    <th class="text-center">Name</th>
    <th class="text-center">Subscribe</th>
    <th class="text-center">Digest</th>
    <th class="text-center">Unsubscribe</th>
    <th class="text-center">Post</th>
    <th class="text-center">Archive</th>
  </thead>
  <tr>
    <td>
      <strong>news</strong>@flink.apache.org<br>
      <small>News and announcements from the Flink community.</small>
    </td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:news-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:news-digest-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:news-unsubscribe@flink.apache.org">Unsubscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <i>Read only list</i></td>
    <td class="text-center">
      <a href="http://mail-archives.apache.org/mod_mbox/flink-news/">Archives</a> <br>
    </td>
  </tr>
  <tr>
    <td>
      <strong>user</strong>@flink.apache.org<br>
      <small>User support and questions mailing list</small>
    </td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:user-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:user-digest-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:user-unsubscribe@flink.apache.org">Unsubscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:user@flink.apache.org">Post</a></td>
    <td class="text-center">
      <a href="http://mail-archives.apache.org/mod_mbox/flink-user/">Archives</a> <br>
      <a href="http://apache-flink-user-mailing-list-archive.2336050.n4.nabble.com/">Nabble Archive</a>
    </td>
  </tr>
  <tr>
    <td>
      <strong>dev</strong>@flink.apache.org<br>
      <small>Development related discussions</small>
    </td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:dev-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:dev-digest-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:dev-unsubscribe@flink.apache.org">Unsubscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:dev@flink.apache.org">Post</a></td>
    <td class="text-center">
      <a href="http://mail-archives.apache.org/mod_mbox/flink-dev/">Archives</a> <br>
      <a href="http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/">Nabble Archive</a>
    </td>
  </tr>
  <tr>
    <td>
      <strong>issues</strong>@flink.apache.org
      <br>
      <small>Mirror of all JIRA activity</small>
    </td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:issues-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:issues-digest-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:issues-unsubscribe@flink.apache.org">Unsubscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i><i>Read only list</i></td>
    <td class="text-center"><a href="http://mail-archives.apache.org/mod_mbox/flink-issues/">Archives</a></td>
  </tr>
  <tr>
    <td>
      <strong>commits</strong>@flink.apache.org
      <br>
      <small>All commits to our repositories</small>
    </td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:commits-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:commits-digest-subscribe@flink.apache.org">Subscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <a href="mailto:commits-unsubscribe@flink.apache.org">Unsubscribe</a></td>
    <td class="text-center"><i class="fa fa-pencil-square-o"></i> <i>Read only list</i></td>
    <td class="text-center"><a href="http://mail-archives.apache.org/mod_mbox/flink-commits/">Archives</a></td>
  </tr>
</table>

## IRC

There is an IRC channel called #flink dedicated to Apache Flink at irc.freenode.org. There is also a [web-based IRC client](http://webchat.freenode.net/?channels=flink) available.

The IRC channel can be used for online discussions about Apache Flink as community, but developers should be careful to move or duplicate all the official or useful discussions to the issue tracking system or dev mailing list.

## Stack Overflow

Committers are watching [Stack Overflow](http://stackoverflow.com/questions/tagged/flink) for the [flink](http://stackoverflow.com/questions/tagged/flink) tag.

Make sure to tag your questions there accordingly to get answers from the Flink community.

## Issue Tracker

We use JIRA to track all code related issues: [{{ site.jira }}]({{ site.jira }}).

All issue activity is also mirrored to the issues mailing list.

## Source Code

### Main source repositories

- **ASF writable**: [https://git-wip-us.apache.org/repos/asf/flink.git](https://git-wip-us.apache.org/repos/asf/flink.git)
- **ASF read-only**: git://git.apache.org/repos/asf/flink.git
- **GitHub mirror**: [https://github.com/apache/flink.git](https://github.com/apache/flink.git)

Note: Flink does not build with Oracle JDK 6. It runs with Oracle JDK 6.

### Website repositories

- **ASF writable**: [https://git-wip-us.apache.org/repos/asf/flink-web.git](https://git-wip-us.apache.org/repos/asf/flink-web.git)
- **ASF read-only**: git://git.apache.org/repos/asf/flink-web.git
- **GitHub mirror**:  [https://github.com/apache/flink-web.git](https://github.com/apache/flink-web.git)


# Third party packages

This is a list of third party packages (ie, libraries, system extensions, or examples) built on Flink.
The Flink community only collects links to those packages but does not maintain them.
Thus, they do not belong to the Apache Flink project and the community cannot give any support for them.
**Your project is missing?**
Let us know per [user/dev mailing list](#mailing-lists).

<table class="flink-packages" width="100%">
  <style>
  table.flink-packages {
    table-layout: fixed;
    border-color: transparent;
    border-spacing: 5px;
    border-collapse: separate;
  }
  td.flink-package-empty{
    height: 12em;
    vertical-align: bottom;
    border-color: transparent;
    background-color: transparent;
  }
  td.flink-package {
    height: 12em;
    vertical-align: bottom;
    border-color: transparent;
    background-color: #B9BFC7;
    color: #E5EAFA;
  }
  td.flink-package-external {
    height: 12em;
    vertical-align: bottom;
    border-color: transparent;
    background-color: #F5A030;
  }
  td.flink-package > div {
    transform: rotate(-90deg);
    font-size: 12pt;
    white-space: nowrap;
  }
  td.flink-package-external > div {
    transform: rotate(-90deg);
    font-size: 16pt;
    white-space: nowrap;
  }
  td.flink-component {
    font-size: 16pt;
    text-align: center;
    border-color: transparent;
    color: #E5EAFA;
  }
  </style>
  <tr>
   <td class="flink-package"><div><span>&nbsp;Flink ML</span></div></td>
   <td class="flink-package"><div><span>&nbsp;Table API</span></div></td>
   <td class="flink-package"><div><span>&nbsp;Gelly (Graph)</span></div></td>
   <td class="flink-package"><div><span>&nbsp;MapReduce</span></div></td>
   <td class="flink-package"><div><span>&nbsp;Python</span></div></td>
   <td class="flink-package-external"><div><span>&nbsp;<a href="#apache-zeppelin">Apache Zeppelin</a></span></div></td>
   <td class="flink-package-external"><div><span>&nbsp;<a href="#apache-mahout">Apache Mahout</a></span></div></td>
   <td class="flink-package-external"><div><span>&nbsp;<a href="#cascading">Cascading</a></span></div></td>
   <td class="flink-package-external"><div><span>&nbsp;<a href="#dataflow">Dataflow</a></span></div></td>
   <td class="flink-package-external"><div><span>&nbsp;<a href="#gradoop">Gradoop</a></span></div></td>
   <td class="flink-package-external"><div><span>&nbsp;<a href="#bigpetstore">BigPetStore</a></span></div></td>
   <td class="flink-package-external"><div><span>&nbsp;<a href="#fastr">FastR</a></span></div></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package"><div><span>&nbsp;Table API</span></div></td>
   <td class="flink-package"><div><span>&nbsp;Storm</span></div></td>
   <td class="flink-package-external"><div><span>&nbsp;<a href="#apache-samoa">Apache SAMOA</a></span></div></td>
   <td class="flink-package-external"><div><span>&nbsp;<a href="#dataflow">Dataflow</a></span></div></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
   <td class="flink-package-empty"></td>
  </tr>

  <tr bgcolor="#B9BFC7">
   <td class="flink-component" colspan="15">DataSet API</td>
   <td class="flink-component" colspan="15">DataStream API</td>
  </tr>

  <tr bgcolor="#B9BFC7">
   <td class="flink-component" colspan="30">Flink Runtime</td>
  </tr>

  <tr bgcolor="#B9BFC7">
   <td class="flink-component" colspan="6" width="20%">Local</td>
   <td class="flink-component" colspan="6" width="20%">Remote</td>
   <td class="flink-component" colspan="6" width="20%">Embedded</td>
   <td class="flink-component" colspan="6" width="20%">YARN</td>
   <td class="flink-component" colspan="6" width="20%">Tez</td>
  </tr>
</table>

## Apache Zeppelin

[Apache Zeppelin (incubator)](https://zeppelin.incubator.apache.org/) is a web-based notebook that enables interactive data analytics and can be used with 
[Flink as an execution engine](https://zeppelin.incubator.apache.org/docs/interpreter/flink.html) (next to others engines).
See also Jim Dowling's [Flink Forward talk](http://www.slideshare.net/FlinkForward/jim-dowling-interactive-flink-analytics-with-hopsworks-and-zeppelin) about Zeppelin on Flink.

## Apache Mahout 

[Apache Mahout](https://mahout.apache.org/) in a machine learning library that will feature Flink as an execution engine soon.
Check out Sebastian Schelter's [Flink Forward talk](http://www.slideshare.net/FlinkForward/sebastian-schelter-distributed-machine-learing-with-the-samsara-dsl) about Mahout-Samsara DSL.

## Cascading 

[Cascading](http://www.cascading.org/cascading-flink/) enables an user to build complex workflows easily on Flink and other execution engines.
[Cascading on Flink](https://github.com/dataArtisans/cascading-flink) is build by [dataArtisans](http://data-artisans.com/) and [Concurrent](http://www.concurrentinc.com).
See Fabian Hueske's [Flink Forward talk](http://www.slideshare.net/FlinkForward/fabian-hueske-training-cascading-on-flink) for more details.

## Google Dataflow

Currently, Google Dataflow programs can be executed in batch mode on top of Flink via [FlinkPipelineRunner](https://github.com/dataArtisans/flink-dataflow).
Executing streaming programs is WIP by [dataArtisans](http://data-artisans.com/).
Maximilian Michels' [Flink Forward talk](http://www.slideshare.net/FlinkForward/maximilian-michels-google-cloud-dataflow-on-top-of-apache-flink) gives a good introduction.

## GRADOOP

[GRADOOP](http://dbs.uni-leipzig.de/en/research/projects/gradoop) enables scalable graph analytics on top of Flink and is developed at Leipzig University. Check out [Martin Junghanns’ Flink Forward talk](http://www.slideshare.net/FlinkForward/martin-junghans-gradoop-scalable-graph-analytics-with-apache-flink).

## BigPetStore

[BigPetStore](https://github.com/apache/bigtop/tree/master/bigtop-bigpetstore) is a benchmarking suite including a data generator and will be available for Flin k soon.
See Suneel Marthi's [Flink Forward talk](http://www.slideshare.net/FlinkForward/suneel-marthi-bigpetstore-flink-a-comprehensive-blueprint-for-apache-flink?ref=http://flink-forward.org/?session=tbd-3) as preview.

## FastR

[FastR](https://bitbucket.org/allr/fastr-flink) in an implemenation of the R language in Java. [FastR Flink](https://bitbucket.org/allr/fastr-flink/src/3535a9b7c7f208508d6afbcdaf1de7d04fa2bf79/README_FASTR_FLINK.md?at=default&fileviewer=file-view-default) exeutes R workload on top of Flink.

## Apache SAMOA

[Apache SAMOA (incubating)](https://samoa.incubator.apache.org/) a streaming ML library featuring Flink an execution engine soon. Albert Bifet introduced SAMOA on Flink at his [Flink Forward talk](http://www.slideshare.net/FlinkForward/albert-bifet-apache-samoa-mining-big-data-streams-with-apache-flink?ref=http://flink-forward.org/?session=apache-samoa-mining-big-data-streams-with-apache-flink).

## Python Examples on Flink

A [collection of examples](https://github.com/wdm0006/flink-python-examples) using Apache Flink's Python API.

## WordCount Example in Clojure

Small [WordCount example](https://github.com/mjsax/flink-external/tree/master/flink-clojure) on how to write a Flink program in Clojure.


# People

<table class="table table-striped">
  <thead>
    <th class="text-center"></th>
    <th class="text-center">Name</th>
    <th class="text-center">Role</th>
    <th class="text-center">Apache ID</th>
  </thead>
  <tr>
    <td class="text-center"><img src="https://avatars2.githubusercontent.com/u/5990983?s=50"></td>
    <td class="text-center">Márton Balassi</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">mbalassi</td>
  </tr>
    <tr>
        <td class="text-center"><img src="https://avatars2.githubusercontent.com/u/858078?v=3&s=50"></td>
        <td class="text-center">Paris Carbone</td>
        <td class="text-center">Committer</td>
        <td class="text-center">senorcarbone</td>
    </tr>
  <tr>
    <td class="text-center" width="10%"><img src="https://avatars3.githubusercontent.com/u/1756620?s=50"></a></td>
    <td class="text-center">Ufuk Celebi</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">uce</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars2.githubusercontent.com/u/1727146?s=50"></td>
    <td class="text-center">Stephan Ewen</td>
    <td class="text-center">PMC, Committer, VP</td>
    <td class="text-center">sewen</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars1.githubusercontent.com/u/5880972?s=50"></td>
    <td class="text-center">Gyula Fóra</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">gyfora</td>
  </tr>
  <tr>
    <td class="text-center"></td>
    <td class="text-center">Alan Gates</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">gates</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars0.githubusercontent.com/u/2388347?s=50"></td>
    <td class="text-center">Fabian Hueske</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">fhueske</td>
  </tr>
    <tr>
    <td class="text-center"><img src="https://avatars3.githubusercontent.com/u/498957?v=3&s=50"></td>
    <td class="text-center">Vasia Kalavri</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">vasia</td>
  </tr>
  </tr>
    <tr>
    <td class="text-center"><img src="https://avatars0.githubusercontent.com/u/68551?s=50"></td>
    <td class="text-center">Aljoscha Krettek</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">aljoscha</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars2.githubusercontent.com/u/2550549?s=50"></td>
    <td class="text-center">Andra Lungu</td>
    <td class="text-center">Committer</td>
    <td class="text-center">andra</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars0.githubusercontent.com/u/89049?s=50"></td>
    <td class="text-center">Robert Metzger</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">rmetzger</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars2.githubusercontent.com/u/837221?s=50"></td>
    <td class="text-center">Maximilian Michels</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">mxm</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars2.githubusercontent.com/u/1941681?s=50"></td>
    <td class="text-center">Chiwan Park</td>
    <td class="text-center">Committer</td>
    <td class="text-center">chiwanpark</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars1.githubusercontent.com/u/5756858?s=50"></td>
    <td class="text-center">Till Rohrmann</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">trohrmann</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars0.githubusercontent.com/u/105434?s=50"></td>
    <td class="text-center">Henry Saputra</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">hsaputra</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars0.githubusercontent.com/u/8959638?s=50"></td>
    <td class="text-center">Matthias J. Sax</td>
    <td class="text-center">Committer</td>
    <td class="text-center">mjsax</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars1.githubusercontent.com/u/409707?s=50"></td>
    <td class="text-center">Sebastian Schelter</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">ssc</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars2.githubusercontent.com/u/1925554?s=50"></td>
    <td class="text-center">Kostas Tzoumas</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">ktzoumas</td>
  </tr>
  <tr>
    <td class="text-center"></td>
    <td class="text-center">Timo Walther</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">twalthr</td>
  </tr> 
  <tr>
    <td class="text-center"><img src="https://avatars1.githubusercontent.com/u/1826769?s=50"></td>
    <td class="text-center">Daniel Warneke</td>
    <td class="text-center">PMC, Committer</td>
    <td class="text-center">warneke</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars1.githubusercontent.com/u/4425616?s=50"></td>
    <td class="text-center">ChengXiang Li</td>
    <td class="text-center">Committer</td>
    <td class="text-center">chengxiang</td>
  </tr>
  <tr>
    <td class="text-center"><img src="https://avatars1.githubusercontent.com/u/569655?s=50"></td>
    <td class="text-center">Greg Hogan</td>
    <td class="text-center">Committer</td>
    <td class="text-center">greg</td>
  </tr>
</table>

You can reach committers directly at `<apache-id>@apache.org`. A list of all contributors can be found [here]({{ site.FLINK_CONTRIBUTORS_URL }}).

## Former mentors

The following people were very kind to mentor the project while in incubation.

<table class="table table-striped">
  <thead>
    <th class="text-center"></th>
    <th class="text-center">Name</th>
    <th class="text-center">Role</th>
    <th class="text-center">Apache ID</th>
  </thead>
  <tr>
    <td class="text-center"></td>
    <td class="text-center">Ashutosh Chauhan</td>
    <td class="text-center">Former PPMC, Mentor</td>
    <td class="text-center">hashutosh</td>
  </tr>
  <tr>
    <td class="text-center"></td>
    <td class="text-center">Ted Dunning</td>
    <td class="text-center">Former PPMC, Mentor</td>
    <td class="text-center">tdunning</td>
  </tr>
  <tr>
    <td class="text-center"></td>
    <td class="text-center">Alan Gates</td>
    <td class="text-center">Former PPMC, Mentor</td>
    <td class="text-center">gates</td>
  </tr>
  </tr>
    <tr>
    <td class="text-center"></td>
    <td class="text-center">Owen O'Malley</td>
    <td class="text-center">Former PPMC, Mentor</td>
    <td class="text-center">omalley</td>
  </tr>
  <tr>
    <td class="text-center"></td>
    <td class="text-center">Sean Owen</td>
    <td class="text-center">Former PPMC, Mentor</td>
    <td class="text-center">srowen</td>
  </tr>
  <tr>
    <td class="text-center"></td>
    <td class="text-center">Henry Saputra</td>
    <td class="text-center">Former PPMC, Mentor</td>
    <td class="text-center">hsaputra</td>
  </tr>
</table>
