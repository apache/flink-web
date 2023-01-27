---
title: 贡献文档
bookCollapseSection: false
weight: 20
---

# 贡献文档

良好的文档对任何类型的软件都至关重要。这对于复杂的软件系统尤其如此，例如 Apache Flink 这样的分布式数据处理引擎。Apache Flink 社区旨在提供简明、精确和完整的文档，并欢迎任何改进 Apache Flink 文档的贡献。

## 获取文档资源

Apache Flink 的文档和代码保存在相同的 [git](http://git-scm.com/) 仓库中。这样做是为了确保代码和文档可以轻松保持同步。

贡献文档的最简单方法是在 [GitHub 上 Flink 的镜像仓库](https://github.com/apache/flink) 页面，通过单击右上角的 fork 按钮讲 Flink 克隆到你自己的 GitHub 帐户中。如果你没有 GitHub 帐户，可以免费创建一个帐户。

接下来，将 fork 的代码克隆到本地计算机。

```
git clone https://github.com/<your-user-name>/flink.git
```

文档位于 Flink 代码库的 docs/ 子目录中。

## 在开始贡献文档之前…

…请确保已经有一个相对应的 [Jira](https://issues.apache.org/jira/browse/FLINK) issue 存在了。我们要求所有文档更改都需要关联一个 Jira issue，除了一些微不足道的修复，如拼写错误。

同时，先阅读一下 [文档样式指南]({{< ref "docs/how-to-contribute/documentation-style-guide" >}}) 能够很好的帮助你写出易懂、连贯和全面的文档。

## 更新或扩展文档

Flink 文档是用 [Markdown](http://daringfireball.net/projects/markdown/) 编写的。Markdown 是一种轻量级标记语言，可以通过工具转化成 HTML。

为了更新或扩展文档，你必须修改 Markdown (.md) 文件。请通过在预览模式下启动构建脚本来验证你的更改。

```
cd docs
./build_docs.sh -p
```

该脚本会将 Markdown 文件编译成静态 HTML 页面并在本地启动一个 Web 服务器。在浏览器中打开 `http://localhost:1313/` ，查看包含更改文档页面。当你修改并保存 Markdown 文件，然后刷新浏览器，修改过的文档将自动被重新编译和更新。

如果有任何疑问，请在开发者邮件列表随时提问。

## 中文文档翻译

Flink 社区正在同时维护英文和中文文档。所以如果你想要更新或扩展文档，英文和中文文档都需要更新。如果你不熟悉中文，请创建一个用于中文文档翻译的 JIRA 并附上 `chinese-translation` 的组件名，并与当前JIRA关联起来。如果你熟悉中文，我们鼓励在一个 pull request 中同时更新两边的文档。

注意：Flink 社区目前正在翻译中文文档，有部分文档可能还未翻译。如果你正在更新的文档还未翻译，可以简单地将英文改动复制到中文文档中。

The Chinese documents are located in the `content.zh/docs` folder. You can update or extend the Chinese file in the `content.zh/docs` folder according to the English documents changes.

## 提交你的贡献

Flink 项目通过 [GitHub Mirror](https://github.com/apache/flink) 的 [Pull Requests](https://help.github.com/articles/using-pull-requests) 方式接受文档的贡献。Pull request 是一种提供补丁的简单方法，它提供了一个指向包含更改的代码分支的链接。

请按照以下步骤准备和提交 pull request。

1. 将更改提交到本地 git 仓库。提交消息应该以 `[FLINK-XXXX]` 开头，对应了相关联的 Jira issue。

2. 将你提交的贡献推送到 GitHub 上你 fork 的 Flink 仓库中。

   ```
   git push origin myBranch
   ```

3. 打开你的 fork 仓库网页 (`https://github.com/<your-user-name>/flink`) 并使用 “Create Pull Request” 按钮开始创建 pull request。确保 base fork 是 `apache/flink master`，并且 head fork 是包含更改的分支。再为 pull request 添加一个有意义的描述并创建它。

也可以将补丁（patch）附加到 [Jira]({{< param FlinkIssuesUrl >}}) issue 上。
