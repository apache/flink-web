---
title: Contribute to the Website
bookCollapseSection: false
weight: 22
---

# Improving the Website

The [Apache Flink website](http://flink.apache.org) presents Apache Flink and its community. It serves several purposes including:

- Informing visitors about Apache Flink and its features.
- Encouraging visitors to download and use Flink.
- Encouraging visitors to engage with the community.

We welcome any contribution to improve our website. This document contains all information that is necessary to improve Flink's website.

## Obtain the website sources

The website of Apache Flink is hosted in a dedicated [git](http://git-scm.com/) repository which is mirrored to GitHub at [https://github.com/apache/flink-web](https://github.com/apache/flink-web).

The easiest way to contribute website updates is to fork [the mirrored website repository on GitHub](https://github.com/apache/flink-web) into your own GitHub account by clicking on the fork button at the top right. If you have no GitHub account, you can create one for free.

Next, clone your fork to your local machine.

```
git clone https://github.com/<your-user-name>/flink-web.git
```

The `flink-web` directory contains the cloned repository. The website resides in the `asf-site` branch of the repository. Run the following commands to enter the directory and switch to the `asf-site` branch.

```
cd flink-web
git checkout asf-site
```

## Directory structure and files

Flink's website is written in [Markdown](http://daringfireball.net/projects/markdown/). Markdown is a lightweight markup language which can be translated to HTML. We use [Hugo](https://gohugo.io/) to generate static HTML files from Markdown.

The files and directories in the website git repository have the following roles:

- All files ending with `.md` are Markdown files. These files are translated into static HTML files.
- The `docs` directory contains all documentation, themes and other content that's needed to render and/or generate the website.
- The `docs/content/docs` folder contains all English content. The `docs/content.zh/docs` contains all Chinese content.
- The `docs/content/posts` contains all blog posts. 
- The `content/` directory contains the generated HTML files from Hugo. It is important to place the files in this directory since the Apache Infrastructure to host the Flink website is pulling the HTML content from his directory. (For committers: When pushing changes to the website git, push also the updates in the `content/` directory!)

## Update or extend the documentation

You can update and extend the website by modifying or adding Markdown files or any other resources such as CSS files. To verify your changes start the build script in preview mode.

```
./build.sh
```

The script compiles the Markdown files into HTML and starts a local webserver. Open your browser at `http://localhost:1313` to view the website including your changes. The Chinese translation is located at `http://localhost:1313/zh/`. The served website is automatically re-compiled and updated when you modify and save any file and refresh your browser.

Please feel free to ask any questions you have on the developer mailing list.

## Submit your contribution

The Flink project accepts website contributions through the [GitHub Mirror](https://github.com/apache/flink-web) as [Pull Requests](https://help.github.com/articles/using-pull-requests). Pull requests are a simple way of offering a patch by providing a pointer to a code branch that contains the changes.

To prepare and submit a pull request follow these steps.

1. Commit your changes to your local git repository. Unless your contribution is a major rework of the website, please squash it into a single commit.

2. Push the commit to a dedicated branch of your fork of the Flink repository at GitHub.

   ```
   git push origin myBranch
   ```

3. Go the website of your repository fork (`https://github.com/<your-user-name>/flink-web`) and use the "Create Pull Request" button to start creating a pull request. Make sure that the base fork is `apache/flink-web asf-site` and the head fork selects the branch with your changes. Give the pull request a meaningful description and submit it.

## Committer section

**This section is only relevant for committers.**

### ASF website git repositories

**ASF writable**: https://gitbox.apache.org/repos/asf/flink-web.git

Details on how to set the credentials for the ASF git repository are [linked here](https://gitbox.apache.org/).

### Merging a pull request

Contributions are expected to be done on the source files only (no modifications on the compiled files in the `content/` directory.). Before pushing a website change, please run the build script

```
./build.sh
```

add the changes to the `content/` directory as an additional commit and push the changes to the ASF base repository.
