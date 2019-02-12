---
title:  "贡献文档"
---

良好的文档对任何类型的软件都至关重要。 对于复杂的软件系统尤其如此，例如 Apache Flink 等分布式数据处理引擎。 Apache Flink 社区旨在提供简明，精确和完整的文档，并欢迎任何改进 Apache Flink 文档的贡献。

{% toc %}

## 获取文档资源

Apache Flink 的文档作为代码库保存在相同的 [git](http://git-scm.com/) 存储库中。 这样做是为了确保代码和文档可以轻松保持同步。

提供文档的最简单方法是通过单击右上角的fork按钮将[Flink 的 GitHub 上的镜像存储库](https://github.com/apache/flink)分支到您自己的 GitHub 帐户中。 如果您没有 GitHub 帐户，可以免费创建一个帐户。

接下来，将 Fork 克隆到本地计算机。

```
git clone https://github.com/<your-user-name>/flink.git
```

该文档位于Flink代码库的`docs/`子目录中。

## 在开始处理文档之前......

…请确保存在与您的贡献相对应的 [Jira](https://issues.apache.org/jira/browse/FLINK) 问题。我们要求所有文档更改都引用Jira问题，除了一些微不足道的修正，如拼写错误。

## 更新或扩展文档

Flink 文档是用 [Markdown](http://daringfireball.net/projects/markdown/) 编写的。Markdown 是一种轻量级标记语言，可以翻译成HTML 。

为了更新或扩展文档，您必须修改 Markdown (`.md`) 文件。请通过在预览模式下启动构建脚本来验证您的更改。

```
cd docs
./build_docs.sh -p
```

该脚本将 Markdown 文件编译为静态 HTML 页面并启动本地 Web 服务器。 在`http://localhost:4000`打开浏览器，查看包含更改的已编译文档。 当您修改并保存 Markdown 文件并刷新浏览器时，将自动重新编译和更新所提供的文档。

如果您对开发人员邮件列表有任何疑问，请随时提出。

## 提交你的贡献

Flink 项目通过 [GitHub Mirror](https://github.com/apache/flink) 接受文档贡献为 [Pull Requests](https://help.github.com/articles/using-pull-requests) 。 拉取请求是一种通过提供指向包含更改的代码分支的指针来提供补丁的简单方法。

按照以下步骤准备和提交拉取请求。

1. 将更改提交到本地git存储库。 提交消息应该以 `[FLINK-XXXX]` 开头指向相应的Jira问题。

2. 将您提交的贡献推送到GitHub上的Flink存储库的分支。

  ```
  git push origin myBranch
  ```

3. 转到存储库fork的网站（`https://github.com/<your-user-name>/flink`）并使用 “Create Pull Request” 按钮开始创建拉取请求。 确保基础分支是 `apache/flink master` ，并且 head fork 选择具有更改的分支。 为pull请求提供有意义的描述并提交。

也可以将补丁附加到 [Jira]({{site. flink_issue _url}}) 问题上。