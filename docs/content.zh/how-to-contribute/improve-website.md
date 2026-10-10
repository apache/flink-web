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

Flink 官网使用 [Markdown](http://daringfireball.net/projects/markdown/) 语言。Markdown 是一种轻量级标记语言，可以转换为 HTML。我们使用 [Hugo](https://gohugo.io/) 从 Markdown 生成静态 HTML 文件。

`flink-web` git 仓库中的文件和目录具有以下作用：

- 所有以 `.md` 结尾的文件都是 Markdown 文件。这些文件将被转换为静态 HTML 文件。
- `docs` 目录包含所有文档、主题和其他用于渲染和生成网站的内容。
- `docs/content/docs` 文件夹包含所有英文内容。`docs/content.zh/docs` 文件夹包含所有中文内容。
- `docs/content/posts` 文件夹包含所有博客文章。
- `content/` 目录包含 Hugo 生成的 HTML 文件。鉴于托管 Flink 官网的 Apache Infrastructure 从该目录中拉取 HTML 网页内容，因此将生成文件放置在此目录中这一步至关重要。（ Committer 注意：在向 git 仓库推送更改的同时，需要同时更新 `content/` 目录中的内容！）

## 更新文档

可以通过修改已有文档，或新增资源–比如 CSS 文件等方式对网站进行更新。想验证你的修改，可以执行如下命令：

```
./build.sh
```

该脚本将 Markdown 文件编译为 HTML 并启动本地 Web 服务器。在浏览器中打开 `http://localhost:1313` 以查看包括修改后的网站。中文版本位于 `http://localhost:1313/zh/` 。当您做出修改、保存任何文件并刷新浏览器时，网站内容会自动重新编译和更新。

如果要在文档或者博客文章中添加 Flink 官方文档的外链引用，请使用以下语法：

```markdown
{{</* docs_link file="relative_path/" name="Title"*/>}}
```

例如：

```markdown
{{</* docs_link file="flink-docs-stable/docs/dev/datastream/side_output/" name="Side Output"*/>}}
```

如果有任何疑问，欢迎在开发者邮件列表中咨询。

## 提交你的贡献

Flink 项目通过 [GitHub Mirror](https://github.com/apache/flink-web) 以提交 [Pull Requests](https://help.github.com/articles/using-pull-requests) 方式接受网站贡献。Pull requests 是一种通过向特定代码分支提交补丁的简单方法。

请按以下步骤操作准备并提交 pull request。

1. 将你的更改提交到本地 git 仓库。如果不是重大重构，请将代码压缩到一个提交中。

2. 请将提交推送到 GitHub 上你自己仓库的一个特定分支。

   ```
   git push origin myBranch
   ```

3. 打开你镜像的仓库 (`https://github.com/<your-user-name>/flink-web`) 并使用 “Create Pull Request” 按钮开始创建新的 pull request。确保基础分支是 `apache/flink-web asf-site` ，并且 head fork 选择带有更改内容的分支。 为 pull request 提供有意义的描述并提交。

## Committer 章节

**本章节仅适用于 Committer。**

### ASF 网站的 git 仓库

**ASF writable**: https://gitbox.apache.org/repos/asf/flink-web.git

有关如何设置 ASF git 仓库凭据的详细信息可以参考 [链接](https://gitbox.apache.org/)。

### 合并 pull request

默认所有的修改仅在源文件上完成（对 `content/` 目录中自动生成的文件没有修改）。
