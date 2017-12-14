---
title: "How To Contribute"
---

<hr />

Apache Flink is developed by an open and friendly community. Everybody is cordially welcome to join the community and contribute to Apache Flink. There are several ways to interact with the community and to contribute to Flink including asking questions, filing bug reports, proposing new features, joining discussions on the mailing lists, contributing code or documentation, improving the website, or testing release candidates.

{% toc %}

## Ask questions!

The Apache Flink community is eager to help and to answer your questions. We have a [user mailing list]({{ site.baseurl }}/community.html#mailing-lists ), hang out in an [IRC channel]({{ site.baseurl }}/community.html#irc), and watch Stack Overflow on the [[apache-flink]](http://stackoverflow.com/questions/tagged/apache-flink) tag.

-----

## File a bug report

Please let us know if you experienced a problem with Flink and file a bug report. Open [Flink's Jira](http://issues.apache.org/jira/browse/FLINK), log in if necessary, and click on the red **Create** button at the top. Please give detailed information about the problem you encountered and, if possible, add a description that helps to reproduce the problem. Thank you very much.

-----

## Propose an improvement or a new feature

Our community is constantly looking for feedback to improve Apache Flink. If you have an idea how to improve Flink or have a new feature in mind that would be beneficial for Flink users, please open an issue in [Flink's Jira](http://issues.apache.org/jira/browse/FLINK). The improvement or new feature should be described in appropriate detail and include the scope and its requirements if possible. Detailed information is important for a few reasons:

- It ensures your requirements are met when the improvement or feature is implemented.
- It helps to estimate the effort and to design a solution that addresses your needs.
- It allow for constructive discussions that might arise around this issue.

Detailed information is also required, if you plan to contribute the improvement or feature you proposed yourself. Please read the [Contribute code]({{ site.base }}/contribute-code.html) guide in this case as well.


We recommend to first reach consensus with the community on whether a new feature is required and how to implement a new feature, before starting with the implementation. Some features might be out of scope of the project, and it's best to discover this early.

For very big features that change Flink in a fundamental way we have another process in place:
[Flink Improvement Proposals](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals). If you are interested you can propose a new feature there or follow the
discussions on existing proposals.

-----

## Help others and join the discussions

Most communication in the Apache Flink community happens on two mailing lists:

- The user mailing list `user@flink.apache.org` is the place where users of Apache Flink ask questions and seek help or advice. Joining the user list and helping other users is a very good way to contribute to Flink's community. Furthermore, there is the [[apache-flink]](http://stackoverflow.com/questions/tagged/apache-flink) tag on Stack Overflow if you'd like to help Flink users (and harvest some points) there.
- The development mailing list `dev@flink.apache.org` is the place where Flink developers exchange ideas and discuss new features, upcoming releases, and the development process in general. If you are interested in contributing code to Flink, you should join this mailing list.

You are very welcome to [subscribe to both mailing lists]({{ site.baseurl }}/community.html#mailing-lists). In addition to the user list, there is also a [Flink IRC]({{ site.baseurl }}/community.html#irc) channel that you can join to talk to other users and contributors.

-----

## Test a release candidate

Apache Flink is continuously improved by its active community. Every few weeks, we release a new version of Apache Flink with bug fixes, improvements, and new features. The process of releasing a new version consists of the following steps:

1. Building a new release candidate and starting a vote (usually for 72 hours).
2. Testing the release candidate and voting (`+1` if no issues were found, `-1` if the release candidate has issues).
3. Going back to step 1 if the release candidate had issues. Otherwise we publish the release.

Our wiki contains a page that summarizes the [test procedure for a release](https://cwiki.apache.org/confluence/display/FLINK/Releasing). Release testing is a big effort if done by a small group of people but can be easily scaled out to more people. The Flink community encourages everybody to participate in the testing of a release candidate. By testing a release candidate, you can ensure that the next Flink release is working properly for your setup and help to improve the quality of releases.

-----

## Contribute code

Apache Flink is maintained, improved, and extended by code contributions of volunteers. The Apache Flink community encourages anybody to contribute source code. In order to ensure a pleasant contribution experience for contributors and reviewers and to preserve the high quality of the code base, we follow a contribution process that is explained in our [Contribute code]( {{ site.base }}/contribute-code.html) guide. The guide also includes instructions on how to setup a development environment, our coding guidelines and code style, and explains how to submit a code contribution.

**Please read the [Contribute code]( {{ site.base }}/contribute-code.html) guide before you start to work on a code contribution.**

Please do also read the [Submit a Contributor License Agreement]({{ site.baseurl }}/how-to-contribute.html#submit-a-contributor-license-agreement) Section.

### Looking for an issue to work on?
{:.no_toc}

We maintain a list of all known bugs, proposed improvements, and suggested features in [Flink's Jira](https://issues.apache.org/jira/browse/FLINK/?selectedTab=com.atlassian.jira.jira-projects-plugin:issues-panel). Issues that we believe are good tasks for new contributors are tagged with a special "starter" tag. Those tasks are supposed to be rather easy to solve and will help you to become familiar with the project and the contribution process.

Please have a look at the list of [starter issues](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20AND%20labels%20%3D%20starter%20ORDER%20BY%20priority%20DESC), if you are looking for an issue to work on. You can of course also choose [any other issue](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20ORDER%20BY%20priority%20DESC) to work on. Feel free to ask questions about issues that you would be interested in working on.

-----

## Contribute documentation

Good documentation is crucial for any kind of software. This is especially true for sophisticated software systems such as distributed data processing engines like Apache Flink. The Apache Flink community aims to provide concise, precise, and complete documentation and welcomes any contribution to improve Apache Flink's documentation.

- Please report missing, incorrect, or outdated documentation as a [Jira issue](http://issues.apache.org/jira/browse/FLINK).
- Flink's documentation is written in Markdown and located in the `docs` folder in [Flink's source code repository]({{ site.baseurl }}/community.html#main-source-repositories). See the [Contribute documentation]({{ site.base }}/contribute-documentation.html) guidelines for detailed instructions for how to update and improve the documentation and to contribute your changes.

-----

## Improve the website

The [Apache Flink website](http://flink.apache.org) presents Apache Flink and its community. It serves several purposes including:

- Informing visitors about Apache Flink and its features.
- Encouraging visitors to download and use Flink.
- Encouraging visitors to engage with the community.

We welcome any contribution to improve our website.

- Please open a [Jira issue](http://issues.apache.org/jira/browse/FLINK) if you think our website could be improved.
- Please follow the [Improve the website]({{ site.baseurl }}/improve-website.html) guidelines if you would like to update and improve the website.

-----

## More ways to contribute…

There are many more ways to contribute to the Flink community. For example you can:

- Give a talk about Flink and tell others how you use it.
- Organize a local Meetup or user group.
- Talk to people about Flink.
- …

-----

## Submit a Contributor License Agreement

Please submit a contributor license agreement to the Apache Software Foundation (ASF) if you would like to contribute to Apache Flink. The following quote from [http://www.apache.org/licenses](http://www.apache.org/licenses/#clas) gives more information about the ICLA and CCLA and why they are necessary.

> The ASF desires that all contributors of ideas, code, or documentation to the Apache projects complete, sign, and submit (via postal mail, fax or email) an [Individual Contributor License Agreement](http://www.apache.org/licenses/icla.txt) (CLA) [ [PDF form](http://www.apache.org/licenses/icla.pdf) ]. The purpose of this agreement is to clearly define the terms under which intellectual property has been contributed to the ASF and thereby allow us to defend the project should there be a legal dispute regarding the software at some future time. A signed CLA is required to be on file before an individual is given commit rights to an ASF project.
>
> For a corporation that has assigned employees to work on an Apache project, a [Corporate CLA](http://www.apache.org/licenses/cla-corporate.txt) (CCLA) is available for contributing intellectual property via the corporation, that may have been assigned as part of an employment agreement. Note that a Corporate CLA does not remove the need for every developer to sign their own CLA as an individual, to cover any of their contributions which are not owned by the corporation signing the CCLA.
>
>  ...

-----

## How to become a committer

Committers are community members that have write access to the project's repositories, i.e., they can modify the code, documentation, and website by themselves and also accept other contributions.

There is no strict protocol for becoming a committer. Candidates for new committers are typically people that are active contributors and community members.

Being an active community member means participating on mailing list discussions, helping to answer questions, verifying release candidates, being respectful towards others, and following the meritocratic principles of community management. Since the "Apache Way" has a strong focus on the project community, this part is *very* important.

Of course, contributing code and documentation to the project is important as well. A good way to start is contributing improvements, new features, or bug fixes. You need to show that you take responsibility for the code that you contribute, add tests and documentation, and help maintaining it.

Candidates for new committers are suggested by current committers or PMC members, and voted upon by the PMC.

If you would like to become a committer, you should engage with the community and start contributing to Apache Flink in any of the above ways. You might also want to talk to other committers and ask for their advice and guidance.
