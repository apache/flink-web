---
title:  "改进网站"
---

The [Apache Flink website](http://flink.apache.org) presents Apache Flink and its community. It serves several purposes including:

- Informing visitors about Apache Flink and its features.
- Encouraging visitors to download and use Flink.
- Encouraging visitors to engage with the community.

We welcome any contribution to improve our website. This document contains all information that is necessary to improve Flink's website.

{% toc %}

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

Flink's website is written in [Markdown](http://daringfireball.net/projects/markdown/). Markdown is a lightweight markup language which can be translated to HTML. We use [Jekyll](http://jekyllrb.com/) to generate static HTML files from Markdown.

The files and directories in the website git repository have the following roles:

- All files ending with `.md` are Markdown files. These files are translated into static HTML files.
- Regular directories (not starting with an underscore (`_`)) contain also `.md` files. The directory structure is reflected in the generated HTML files and the published website.
- The `_posts` directory contains blog posts. Each blog post is written as one Markdown file. To contribute a post, add a new file there.
- The `_includes/` directory contains includeable files such as the navigation bar or the footer.
- The `docs/` directory contains copies of the documentation of Flink for different releases. There is a directory inside `docs/` for each stable release and the latest SNAPSHOT version. The build script is taking care of the maintenance of this directory.
- The `content/` directory contains the generated HTML files from Jekyll. It is important to place the files in this directory since the Apache Infrastructure to host the Flink website is pulling the HTML content from his directory. (For committers: When pushing changes to the website git, push also the updates in the `content/` directory!)

## Update or extend the documentation

You can update and extend the website by modifying or adding Markdown files or any other resources such as CSS files. To verify your changes start the build script in preview mode.

```
./build.sh -p
```

The script compiles the Markdown files into HTML and starts a local webserver. Open your browser at `http://localhost:4000` to view the website including your changes. The served website is automatically re-compiled and updated when you modify and save any file and refresh your browser.

Alternatively you can build the web site using Docker (without augmenting your host environment):

```
docker run --rm --volume="$PWD:/srv/flink-web" --expose=4000 -p 4000:4000 -it ruby:2.5 bash -c 'cd /srv/flink-web && ./build.sh -p'
```

Please feel free to ask any questions you have on the developer mailing list.

## Submit your contribution

The Flink project accepts website contributions through the [GitHub Mirror](https://github.com/apache/flink-web) as [Pull Requests](https://help.github.com/articles/using-pull-requests). Pull requests are a simple way of offering a patch by providing a pointer to a code branch that contains the changes.

To prepare and submit a pull request follow these steps.

1. Commit your changes to your local git repository. **Please Make sure that your commit does not include translated files (any files in the `content/` directory).** Unless your contribution is a major rework of the website, please squash it into a single commit.

2. Push the commit to a dedicated branch of your fork of the Flink repository at GitHub.

	```
	git push origin myBranch
	```

3. Go the website of your repository fork (`https://github.com/<your-user-name>/flink-web`) and use the "Create Pull Request" button to start creating a pull request. Make sure that the base fork is `apache/flink-web asf-site` and the head fork selects the branch with your changes. Give the pull request a meaningful description and submit it.

## Committer section

**This section is only relevant for committers.**

### ASF website git repositories
{:.no_toc}

**ASF writable**: https://gitbox.apache.org/repos/asf/flink-web.git

Details on how to set the credentials for the ASF git repository are [linked here](https://gitbox.apache.org/).

### Merging a pull request
{:.no_toc}

Contributions are expected to be done on the source files only (no modifications on the compiled files in the `content/` directory.). Before pushing a website change, please run the build script

```
./build.sh
```

add the changes to the `content/` directory as an additional commit and push the changes to the ASF base repository.

### Updating the documentation directory
{:.no_toc}

The build script does also take care of maintaining the `docs/` directory. Set the `-u` flag to update documentation. This includes fetching the Flink git repository and copying different versions of the documentation.
