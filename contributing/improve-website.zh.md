---
title:  "改进网站"
---

[Apache Flink 官网](http://flink.apache.org) 介绍了 Apache Flink 及其社区。包括如下多种用途：

- 向来访者介绍 Apache Flink 及其特性。
- 鼓励来访者下载并使用 Flink。
- 鼓励来访者与社区进行互动。

我们欢迎任何改进官网的贡献。本文档包含了所有改进 Flink 官网所需要的信息。

{% toc %}

## 获取官网源码

Apache Flink 官网的源码托管在专用的 [git](http://git-scm.com/) 仓库中，并在 Github 中有一个镜像 [https://github.com/apache/flink-web](https://github.com/apache/flink-web)。

向官网贡献的最简单方式是通过单击右上角的 fork 按钮，将 [Github 上官网的镜像] (https://github.com/apache/flink-web) 镜像到自己的仓库中。如果没有 Github 帐户，你可以免费创建一个。

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

Flink 的官网是用 [Markdown](http://daringfireball.net/projects/markdown/) 所编写。Markdown 是一种轻量级标记语言，可以翻译为 HTML。我们使用 [Jekyll](http://jekyllrb.com/) 生成静态 HTML 文件。

官网仓库中的目录和文件组织如下：

- 所有文件以 `.md` 结尾。这些文件会被转换为静态 HTML 文件。
- 常规目录（不以下划线（`_`）开头）也包含以 `.md` 结尾的文件。目录结构最终会反映在生成的 HTML 文件和发布的网站上。
- `_posts` 目录下包含了所有的博客文章。每个 Markdown 文件是一篇博客。贡献新的博客，请添加一个新的文件。
- `_includes/` 目录包含可导入的文件，例如导航栏或页脚。
- `docs/` 目录包含不同版本的 Flink 文档。在 `docs/` 目录下包含了所有已经发布的版本文档，以及最新的预览版文档。构建脚本负责维护这个目录。
- `content/` 目录包含所有 Jekyll 生成的静态 HTML 文件。谨记一定要把文件放到该目录下，因为 Apache Infrastructure 会从该目录拉取 HTML 内容。（对于提交者：当推送对该网站仓库的更改时，也请推送 `content/` 目录的更新）。

## 更新文档

可以通过修改已有文档，或新增资源--比如 CSS 文件等方式对网站进行更新。想验证你的修改，可以执行如下命令：

```
./build.sh -p
```

该脚本会把所有 Markdown 文件转换为 HTML 文件，并启动一个本地 web 服务器。打开浏览器并访问 `http://localhost:4000` 查看你的修改。当你重新修改并保存文件后，刷新浏览器可以看到最新的内容。

或者你可以使用 Docker 进行网站的构建（不增加主机环境）：

```
docker run --rm --volume="$PWD:/srv/flink-web" --expose=4000 -p 4000:4000 -it ruby:2.5 bash -c 'cd /srv/flink-web && ./build.sh -p'
```

如果有任何疑问，欢迎在开发者邮件列表中咨询。

## 提交你的贡献

Flink 项目通过 [GitHub Mirror](https://github.com/apache/flink-web) 以提交 [Pull Requests](https://help.github.com/articles/using-pull-requests) 方式接受网站贡献。Pull requests 是一种通过向特定代码分支提交补丁的简单方法。

请按以下步骤操作准备并提交 pull request。

1. 将你的更改提交到本地 git 仓库。 **请确保你的提交不包含自动生成的文件（`content/`目录中的任何文件）。** 如果不是重大重构，请将代码压缩到一个提交中。
2. 请将提交推送到 GitHub 上你自己仓库的一个特定分支。

	```
	git push origin myBranch
	```
3. 打开你镜像的仓库(`https://github.com/<your-user-name>/flink-web`) 并使用 "Create Pull Request" 按钮开始创建 pull request 取请求。 确保基础分支是`apache/flink-web asf-site` ，并且 head fork 选择带有更改内容的分支。 为 pull request 提供有意义的描述并提交。

## Committer 章节

**本节仅适用于提交者。**

### ASF 网站的 git 仓库
{:.no_toc}

**ASF writable**: https://gitbox.apache.org/repos/asf/flink-web.git

有关如何设置 ASF git 仓库凭据的详细信息可以参考 [链接](https://gitbox.apache.org/)。

### 合并 pull request
{:.no_toc}

默认所有的修改仅在源文件上完成（对`content/`目录中自动生成的文件没有修改）。 在推送网站更改之前，请运行构建脚本。

```
./build.sh
```

将更改添加到`content/` 目录作为附加提交，并将更改推送到 ASF 基本仓库。

### 更新文档目录结构
{:.no_toc}

构建脚本还负责维护`docs/`目录。 设置 `-u` 标志以更新文档。 这包括获取 Flink git 仓库中不同版本的文档。
