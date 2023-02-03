---
title: 贡献网站
bookCollapseSection: false
weight: 22
---

# 改进网站

[Apache Flink 官网](http://flink.apache.org) 介绍了 Apache Flink 及其社区。包括如下多种用途：

- 向来访者介绍 Apache Flink 及其特性。
- 鼓励来访者下载并使用 Flink。
- 鼓励来访者与社区进行互动。

我们欢迎任何改进官网的贡献。本文档包含了所有改进 Flink 官网所需要的信息。

## 获取官网源码

Apache Flink 官网的源码托管在专用的 [git](http://git-scm.com/) 仓库中，并在 Github 中有一个镜像 [https://github.com/apache/flink-web](https://github.com/apache/flink-web).

向官网贡献的最简单方式是通过单击右上角的 fork 按钮，将 [Github 上官网的镜像](https://github.com/apache/flink-web) 镜像到自己的仓库中。如果没有 Github 帐户，你可以免费创建一个。

接下来，把你镜像的仓库克隆到本地机器上。

```
git clone https://github.com/<your-user-name>/flink-web.git
```

`flink-web` 目录包含了拷贝的仓库。官网的代码位于 `asf-site` 分支上。运行如下命令切换到 `asf-site` 分支

```
cd flink-web
git checkout asf-site
```

## 目录结构和文件

Flink 的官网是用 [Markdown](http://daringfireball.net/projects/markdown/). Markdown is a lightweight markup language which can be translated to HTML. We use [Hugo](https://gohugo.io/) to generate static HTML files from Markdown.

The files and directories in the website git repository have the following roles:

- All files ending with `.md` are Markdown files. These files are translated into static HTML files.
- The `docs` directory contains all documentation, themes and other content that's needed to render and/or generate the website.
- The `docs/content/docs` folder contains all English content. The `docs/content.zh/docs` contains all Chinese content.
- The `docs/content/posts` contains all blog posts. 
- The `content/` directory contains the generated HTML files from Hugo. It is important to place the files in this directory since the Apache Infrastructure to host the Flink website is pulling the HTML content from his directory. (For committers: When pushing changes to the website git, push also the updates in the `content/` directory!)

## 更新文档

可以通过修改已有文档，或新增资源–比如 CSS 文件等方式对网站进行更新。想验证你的修改，可以执行如下命令：

```
./build.sh
```

The script compiles the Markdown files into HTML and starts a local webserver. Open your browser at `http://localhost:1313` to view the website including your changes. The Chinese translation is located at `http://localhost:1313/zh/`. The served website is automatically re-compiled and updated when you modify and save any file and refresh your browser.

如果有任何疑问，欢迎在开发者邮件列表中咨询。

## 提交你的贡献

Flink 项目通过 [GitHub Mirror](https://github.com/apache/flink-web) 以提交 [Pull Requests](https://help.github.com/articles/using-pull-requests)方式接受网站贡献。Pull requests 是一种通过向特定代码分支提交补丁的简单方法。

请按以下步骤操作准备并提交 pull request。

1. 将你的更改提交到本地 git 仓库。如果不是重大重构，请将代码压缩到一个提交中。

2. 请将提交推送到 GitHub 上你自己仓库的一个特定分支。

   ```
   git push origin myBranch
   ```

3. 打开你镜像的仓库 (`https://github.com/<your-user-name>/flink-web`) 并使用 “Create Pull Request” 按钮开始创建 pull request 取请求。 确保基础分支是 `apache/flink-web asf-site` ，并且 head fork 选择带有更改内容的分支。 为 pull request 提供有意义的描述并提交。

## Committer 章节

**本节仅适用于提交者。**

### ASF 网站的 git 仓库

**ASF writable**: https://gitbox.apache.org/repos/asf/flink-web.git

有关如何设置 ASF git 仓库凭据的详细信息可以参考 [链接](https://gitbox.apache.org/)。

### 合并 pull request

默认所有的修改仅在源文件上完成（对content/目录中自动生成的文件没有修改）。 在推送网站更改之前，请运行构建脚本。

```
./build.sh
```

将更改添加到content/ 目录作为附加提交，并将更改推送到 ASF 基本仓库。

