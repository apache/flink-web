---
authors:
- morsapaes: null
  name: Marta Paes
  twitter: morsapaes
categories: news
date: "2020-05-04T06:00:00Z"
excerpt: The Flink community is thrilled to share that the project is applying again
  to Google Season of Docs (GSoD) this year! If you’re unfamiliar with the program,
  GSoD is a great initiative organized by Google Open Source to pair technical writers
  with mentors to work on documentation for open source projects. Does working shoulder
  to shoulder with the Flink community on documentation sound exciting? We’d love
  to hear from you!
title: Applying to Google Season of Docs 2020
---

The Flink community is thrilled to share that the project is applying again to [Google Season of Docs](https://developers.google.com/season-of-docs/) (GSoD) this year! If you’re unfamiliar with the program, GSoD is a great initiative organized by [Google Open Source](https://opensource.google.com/) to pair technical writers with mentors to work on documentation for open source projects. The [first edition](https://developers.google.com/season-of-docs/docs/2019/participants) supported over 40 projects, including some other cool Apache Software Foundation (ASF) members like Apache Airflow and Apache Cassandra.

# Why Apply?

As one of the most active projects in the ASF, Flink is experiencing a boom in contributions and some major changes to its codebase. And, while the project has also seen a significant increase in activity when it comes to writing, reviewing and translating documentation, it’s hard to keep up with the pace.

<center>
	<img src="{{< siteurl >}}/img/blog/2020-05-04-season-of-docs/2020-04-30-season-of-docs_1.png" width="650px" alt="GitHub 1"/>
</center>

<div style="line-height:60%;">
    <br>
</div>

Since last year, the community has been working on [FLIP-42](https://cwiki.apache.org/confluence/display/FLINK/FLIP-42%3A+Rework+Flink+Documentation) to improve the documentation experience and bring a more accessible information architecture to Flink. After [some discussion](https://www.mail-archive.com/dev@flink.apache.org/msg36987.html), we agreed that GSoD would be a valuable opportunity to double down on this effort and collaborate with someone who is passionate about technical writing...and Flink!

# How can you contribute?

If working shoulder to shoulder with the Flink community on documentation sounds exciting, we’d love to hear from you! You can read more about our idea for this year’s project below and, depending on whether it is accepted, [apply](https://developers.google.com/season-of-docs/docs/tech-writer-guide) as a technical writer. If you have any questions or just want to know more about the project idea, ping us at [dev@flink.apache.org](https://flink.apache.org/community.html#mailing-lists)!

<div class="alert alert-info">
	Please <a href="mailto:dev-subscribe@flink.apache.org">subscribe</a> to the Apache Flink mailing list before reaching out.
	If you are not subscribed then responses to your message will not go through.
	You can always <a href="mailto:dev-unsubscribe@flink.apache.org">unsubscribe</a> at any time. 
</div>

## Project: Improve the Table API & SQL Documentation

[Apache Flink](https://flink.apache.org/) is a stateful stream processor supporting a broad set of use cases and featuring APIs at different levels of abstraction that allow users to trade off expressiveness and usability, as well as work with their language of choice (Java/Scala, SQL or Python). The Table API & SQL are Flink’s high-level relational abstractions and focus on data analytics use cases. A core principle is that either API can be used to process static (batch) and continuous (streaming) data with the same syntax and yielding the same results.

As the Flink community works on extending the scope of the Table API & SQL, a lot of new features are being added and some underlying structures are also being refactored. At the same time, the documentation for these APIs is growing onto a somewhat unruly structure and has potential for improvement in some areas. 

The project has two main workstreams: restructuring and extending the Table API & SQL documentation. These can be worked on by one person as a bigger effort or assigned to different technical writers.

**1) Restructure the Table API & SQL Documentation**

Reworking the current documentation structure would allow to:

* Lower the entry barrier to Flink for non-programmatic (i.e. SQL) users.
* Make the available features more easily discoverable.
* Improve the flow and logical correlation of topics.

[FLIP-60](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=127405685) contains a detailed proposal on how to reorganize the existing documentation, which can be used as a starting point.


**2) Extend the Table API & SQL Documentation**

Some areas of the documentation have insufficient detail or are not [accessible](https://flink.apache.org/contributing/docs-style.html#general-guiding-principles) for new Flink users. Examples of topics and sections that require attention are: planners, built-in functions, connectors, overview and concepts sections. There is a lot of work to be done and the technical writer could choose what areas to focus on — these improvements could then be added to the documentation rework umbrella issue ([FLINK-12639](https://issues.apache.org/jira/browse/FLINK-12639)).

### Project Mentors 

* [Aljoscha Krettek](https://twitter.com/aljoscha) (Apache Flink and Apache Beam PMC Member)
* [Seth Wiesman](https://twitter.com/sjwiesman) (Apache Flink Committer)

### Related Resources

* FLIP-60: [https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=127405685](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=127405685)

* Table API & SQL Documentation: [{{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/table/]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/table/)

* How to Contribute Documentation: [https://flink.apache.org/contributing/contribute-documentation.html](https://flink.apache.org/contributing/contribute-documentation.html)

* Documentation Style Guide: [https://flink.apache.org/contributing/docs-style.html](https://flink.apache.org/contributing/docs-style.html)

We look forward to receiving feedback on this GSoD application and also to continue improving the documentation experience for Flink users. Join us!
