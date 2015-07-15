---
title:  "How To Contribute"
---

The Flink project welcomes all sort of contributions in the form of code (improvements, features, bugfixes), tests, documentation, and community participation (discussions & questions).

{% toc %}

## Easy Issues for Starters

We maintain all known issues and feature drafts in the [Flink JIRA project](https://issues.apache.org/jira/issues/?jql=project+%3D+FLINK).

We also try to maintain a [list of simple "starter issues"](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20AND%20labels%20%3D%20starter%20ORDER%20BY%20priority%20DESC) that we believe are good tasks for new contributors. Those tasks are meant to allow people to get into the project and become familiar with the process of contributing. Feel free to ask questions about issues that you would be interested in working on.

In addition, you can find a list of ideas for projects and improvements in the [projects Wiki page](https://cwiki.apache.org/confluence/display/FLINK/Project+Ideas).

## Contributing Code & Documentation

This section gives you a brief introduction in how to contribute code and documentation to Flink. We maintain both the code and the documentation in the same repository, so the process is essentially the same for both. We use [git](http://git-scm.com/) for the code and documentation version control. The documentation is located in the `docs/` subdirectory of the git repository.

The Flink project accepts code contributions through the [GitHub Mirror](https://github.com/apache/flink), in the form of [Pull Requests](https://help.github.com/articles/using-pull-requests). Pull requests are basically a simpler way of offering a patch, by providing a pointer to a code branch that contains the change.

It is also possible to attach a patch to a [JIRA]({{site.FLINK_ISSUES_URL}}) issue.


### Setting up the Infrastructure and Creating a Pull Request

1. The first step is to create yourself a copy of the Flink code base. We suggest to fork the [Flink GitHub Mirror Repository](https://github.com/apache/flink) into your own [GitHub](https://github.com) account. You need to register on GitHub for that, if you have no account so far.

2. Next, clone your repository fork to your local machine.

   ```
git clone https://github.com/<your-user-name>/flink.git
```

3. It is typically helpful to switch to a *topic branch* for the changes. To create a dedicated branch based on the current master, use the following command:

   ```
git checkout -b myBranch master
```

4. Now you can create your changes, compile the code, and validate the changes. Here are some pointers on how to [build the code](https://github.com/apache/flink/#building-apache-flink-from-source).
In addition to that, we recommend setting up Eclipse (or IntelliJ) using the "Import Maven Project" feature:

      * Select "Import" from the "File" menu.
      * Expand the "Maven" node, select "Existing Maven Projects", and click the "Next" button.
      * Select the root directory by clicking on the "Browse" button and navigate to the top folder of the cloned Flink git repository.
      * Ensure that all projects are selected and click the "Finish" button.<br/><br/><!-- newline hack -->

      If you want to work on the Scala code you will need the following plugins:

    **Eclipse 4.x**:

      * scala-ide: `http://download.scala-ide.org/sdk/e38/scala210/stable/site`
      * m2eclipse-scala: `http://alchim31.free.fr/m2e-scala/update-site`
      * build-helper-maven-plugin: `https://repository.sonatype.org/content/repositories/forge-sites/m2e-extras/0.15.0/N/0.15.0.201206251206/`<br/><br/><!-- newline hack -->

    **Eclipse 3.7**:

      * scala-ide: `http://download.scala-ide.org/sdk/e37/scala210/stable/site`
      * m2eclipse-scala: `http://alchim31.free.fr/m2e-scala/update-site`
      * build-helper-maven-plugin: `https://repository.sonatype.org/content/repositories/forge-sites/m2e-extras/0.14.0/N/0.14.0.201109282148/`<br/><br/><!-- newline hack -->

      If you don't have the plugins your project will have build errors, but you can just close the Scala projects and ignore them.

5. After you have finalized your contribution, verify the compliance with the contribution guidelines (see below), and make the commit. To make the changes easily mergeable, please rebase them to the latest version of the main repository's master branch. Assuming you created a topic branch (step 3), you can follow this sequence of commands to do that:
switch to the master branch, update it to the latest revision, switch back to your topic branch, and rebase it on top of the master branch.

   ```
git checkout master
git pull https://github.com/apache/flink.git master
git checkout myBranch
git rebase master
```
Have a look [here](https://help.github.com/articles/using-git-rebase) for more information about rebasing commits.


6. Push the contribution back into your fork of the Flink repository.

   ```
git push origin myBranch
```
Go the website of your repository fork (`https://github.com/<your-user-name>/flink`) and use the "Create Pull Request" button to start creating a pull request. Make sure that the base fork is `apache/flink master` and the head fork selects the branch with your changes. Give the pull request a meaningful description and send it.


### Verifying the Compliance of your Code

Before sending a patch or pull request, please verify that it complies with the guidelines of the project. While we try to keep the set of guidelines small and easy, it is important to follow those rules in order to guarantee good code quality, to allow efficient reviews, and to allow committers to easily merge your changes.

Please have a look at the [coding guidelines]({{ site.baseurl }}/coding-guidelines.html) for a guide to the format of code and pull requests.

Most important of all, verify that your changes are correct and do not break existing functionality. Run the existing tests by calling `mvn verify` in the root directory of the repository, and make sure that the tests succeed. We encourage every contributor to use a *continuous integration* service that will automatically test the code in your repository whenever you push a change. Flink is pre-configured for [Travis CI](http://docs.travis-ci.com/), which can be easily enabled for your private repository fork (it uses GitHub for authentication, so you don't need an additional account). Simply add the *Travis CI* hook to your repository (*settings --> webhooks & services --> add service*) and enable tests for the "flink" repository on [Travis](https://travis-ci.org/profile).

When contributing documentation, please review the rendered HTML versions of the documents you changed. You can look at the HTML pages by using the rendering script in preview mode.

```
cd docs
./build_docs.sh -p
```
Now, open your browser at `http://localhost:4000` and check out the pages you changed.

## Contribute changes to the Website

The website of Apache Flink is hosted in a separate Git repository. We suggest making a fork of the [flink-web GitHub mirror repository](https://github.com/apache/flink-web).

To make changes to the website, you have to checkout its source code first. The website resides in the `asf-site` branch of the repository:

```
git clone -b asf-site https://github.com/<your-user-name>/flink-web.git
cd flink-web
```

The `flink-web` directory contains the files that we use to build the website. We use [Jekyll](http://jekyllrb.com/) to generate static HTML files for the website.

### Files and Directories in the website git repository

The files and directories in the website git repository have the following roles:

- all files ending with `.md` are [Markdown](http://daringfireball.net/projects/markdown/) files. Those are the input for the HTML files.
- regular directories (not starting with an underscore (`_`)) contain also `.md` files. The directory structure is also represented in the generated HTML files.
- the `_posts` directory contains one Markdown file for each blog post on the website. To contribute a post, just add a new file there.
- the `_includes/` directory contains includeable files such as the navigation bar or the footer.
- the `docs/` directory contains copies of the documentation of Flink for different releases. There is a directory inside `docs/` for each stable release and the latest SNAPSHOT version. The build script is taking care of the maintenance of this directory.
- the `content/` directory contains the generated HTML files from Jekyll. It is important to place the files in this directory since the Apache Infrastructure to host the Flink website is pulling the HTML content from his directory. (For committers: When pushing changes to the website repository, push also the updates in the `content/` directory!)
- see the section below for the `build.sh` script.


### The `build.sh` script

The `build.sh` script creates HTML files from the input Markdown files. Use the `-p` flag to let Jekyll serve a **p**review of the website on `http://localhost:4000/`.

The build script also takes care of maintaining the `docs/` directory. Set the `-u` flag to **u**pdate documentation. This includes fetching the Flink git repository and copying different versions of the documentation.

## How to become a committer

There is no strict protocol for becoming a committer. Candidates for new committers are typically people that are active contributors and community members.

Being an active community member means participating on mailing list discussions, helping to answer questions, being respectful towards others, and following the meritocratic principles of community management. Since the "Apache Way" has a strong focus on the project community, this part is very important.

Of course, contributing code to the project is important as well. A good way to start is contributing improvements, new features, or bugfixes. You need to show that you take responsibility for the code that you contribute, add tests/documentation, and help maintaining it.

Finally, candidates for new committers are suggested by current committers, mentors, or PMC members, and voted upon by the PMC.


### How to use git as a committer

Only the infrastructure team of the ASF has administrative access to the GitHub mirror. Therefore, comitters have to push changes to the git repository at the ASF.

#### Main source repositories

**ASF writable**: `https://git-wip-us.apache.org/repos/asf/flink.git`

**ASF read-only**: `git://git.apache.org/repos/asf/flink.git`

**ASF read-only**: `https://github.com/apache/flink.git`

Note: Flink does not build with Oracle JDK 6. It runs with Oracle JDK 6.

If you want to build for Hadoop 1, activate the build profile via `mvn clean package -DskipTests -Dhadoop.profile=1`.

#### Website repositories

**ASF writable**: `https://git-wip-us.apache.org/repos/asf/flink-web.git`

**ASF read-only**: `git://git.apache.org/repos/asf/flink-web.git`

**ASF read-only**: `https://github.com/apache/flink-web.git`

Details on how to set the credentials for the ASF git repostiory are [linked here](https://git-wip-us.apache.org/).
To merge pull requests from our Flink GitHub mirror, there is a script in the source `./tools/merge_pull_request.sh.template`. Rename it to `merge_pull_request.sh` with the appropriate settings and use it for merging.

## Snapshots (Nightly Builds)

Apache Flink `{{ site.FLINK_VERSION_LATEST }}` is our latest development version.

You can download a packaged version of our nightly builds, which include
the most recent development code. You can use them if you need a feature
before its release. Only builds that pass all tests are published here.

- **Hadoop 1**: <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_1_LATEST }}" class="ga-track" id="download-hadoop1-nightly">{{ site.FLINK_DOWNLOAD_URL_HADOOP_1_LATEST | split:'/' | last }}</a>
- **Hadoop 2 and YARN**: <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_LATEST }}" class="ga-track" id="download-hadoop2-nightly">{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_LATEST | split:'/' | last }}</a>

Add the **Apache Snapshot repository** to your Maven `pom.xml`:

```xml
<repositories>
  <repository>
    <id>apache.snapshots</id>
    <name>Apache Development Snapshot Repository</name>
    <url>https://repository.apache.org/content/repositories/snapshots/</url>
    <releases><enabled>false</enabled></releases>
    <snapshots><enabled>true</enabled></snapshots>
  </repository>
</repositories>
```

You can now include Apache Flink as a Maven dependency (see above) with version `{{ site.FLINK_VERSION_LATEST }}` (or `{{ site.FLINK_VERSION_HADOOP_1_LATEST}}` for compatibility with old Hadoop 1.x versions).
