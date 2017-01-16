---
title:  "Contribute Documentation"
---

Good documentation is crucial for any kind of software. This is especially true for sophisticated software systems such as distributed data processing engines like Apache Flink. The Apache Flink community aims to provide concise, precise, and complete documentation and welcomes any contribution to improve Apache Flink's documentation.

{% toc %}

## Obtain the documentation sources

Apache Flink's documentation is maintained in the same [git](http://git-scm.com/) repository as the code base. This is done to ensure that code and documentation can be easily kept in sync. 

The easiest way to contribute documentation is to fork [Flink's mirrored repository on Github](https://github.com/apache/flink) into your own Github account by clicking on the fork button at the top right. If you have no Github account, you can create one for free.

Next, clone your fork to your local machine.
  
```
git clone https://github.com/<your-user-name>/flink.git
```

The documentation is located in the `docs/` subdirectory of the Flink code base.

## Before you start working on the documentation ...

... please make sure there exists a [JIRA](https://issues.apache.org/jira/browse/FLINK) issue that corresponds to your contribution. We require all documentation changes to refer to a JIRA issue, except for trivial fixes such as typos. 

## Update or extend the documentation

The Flink documentation is written in [Markdown](http://daringfireball.net/projects/markdown/). Markdown is a lightweight markup language which can be translated to HTML.

In order to update or extend the documentation you have to modify the Markdown (`.md`) files. Please verify your changes by starting the build script in preview mode.

```
cd docs
./build_docs.sh -p
```

The script compiles the Markdown files into static HTML pages and starts a local webserver. Open your browser at `http://localhost:4000` to view the compiled documentation including your changes. The served documentation is automatically re-compiled and updated when you modify and save Markdown files and refresh your browser.

Please feel free to ask any questions you have on the developer mailing list.

## Submit your contribution

The Flink project accepts documentation contributions through the [GitHub Mirror](https://github.com/apache/flink) as [Pull Requests](https://help.github.com/articles/using-pull-requests). Pull requests are a simple way of offering a patch by providing a pointer to a code branch that contains the changes.

To prepare and submit a pull request follow these steps.

1. Commit your changes to your local git repository. The commit message should point to the corresponding JIRA issue by starting with `[FLINK-XXXX]`. 

2. Push your committed contribution to your fork of the Flink repository at Github.

	```
	git push origin myBranch
	```

3. Go the website of your repository fork (`https://github.com/<your-user-name>/flink`) and use the "Create Pull Request" button to start creating a pull request. Make sure that the base fork is `apache/flink master` and the head fork selects the branch with your changes. Give the pull request a meaningful description and submit it.

It is also possible to attach a patch to a [JIRA]({{site.FLINK_ISSUES_URL}}) issue.








