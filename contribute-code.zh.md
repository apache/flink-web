---
title:  "贡献代码"
---

Apache Flink 的维护、改进和扩展都来自于志愿者的代码贡献。Apache Flink 社区鼓励任何人贡献源代码。为了确保贡献者和审阅者愉快地贡献高质量的代码，请遵循本文档中介绍的贡献流程。

本文档包含了所有关于 Apache Flink 贡献代码的要点。它描述了准备，测试和提交贡献的流程，阐释了 Flink 代码库的编码指南和代码风格，并提供了设置开发环境的说明。

**重要**：在开始编写代码之前，请仔细阅读本文档。遵循下面描述的流程和指南非常重要。否则，你的 pull request 可能不被接受或可能需要大量返工。特别的，在提交实现**新功能**的 pull request 之前，你需要创建一个 Jira issue 并与社区就是否需要此功能达成共识。



{% toc %}

## 代码贡献流程

### 在你编码之前...

...请确保有与你的贡献相对应的 Jira 问题。这是 Flink 社区遵循所有代码贡献的一般规则，包括错误修复、改进或新功能，但 *琐碎* 的热修复除外。如果你想修复发现的错误，或者想要为 Flink 添加新功能或改进，在开始实现之前请按照 [如何提交错误报告]({{ site.baseurl }}/zh/how-to-contribute.html#file-a-bug-report) 和 [如何提出改进或新功能]({{ site.baseurl }}/zh/how-to-contribute.html#propose-an-improvement-or-a-new-feature) 指南在 [Flink Jira](http://issues.apache.org/jira/browse/FLINK) 中提交一个 issue。

如果 Jira issue 的描述表明其解决方案将触及代码库的敏感部分，或者问题足够复杂，或者需要添加大量新代码，Flink 社区可能会要求提供设计文档（大多数贡献不需要设计文档）。设计文档的目的是为了确保解决问题的总体方案是正确的，并得到社区一致同意的。需要设计文档的 Jira issue 使用 **`requires-design-doc`** 标签进行标记，任何社区成员都可以在认为有必要设计文档的 Jira issue 上贴上此标签。良好的描述有助于确定 Jira issue 是否需要设计文档，设计文档必须添加或附加到 Jira issue 或添加一个链接到 Jira issue 页面。设计文档应涵盖以下方面：

- 解决方案的概述。
- API 更改列表（更改后的接口、新的和弃用的配置参数、更改后的行为 ...）。
- 要改动的主要模块和类。
- 方案的已知局限性。

任何人都可以添加设计文档，包括问题的汇报者和修复者。

在设计文档被社区以[延迟决策](http://www.apache.org/foundation/glossary.html#LazyConsensus)接受之前，需要设计文档的 Jira issue 的代码贡献将不会被合并到 Flink 的代码库中。请在开始编写代码之前检查是否需要设计文档。


### 编码时...

...请遵守以下规则：

- Jira 问题中记录的任何讨论或要求都需要考虑。
- 尽可能遵循设计文档（如果有设计文档）。如果你的实现偏离设计文档提出的解决方案太多，请更新设计文档并达成共识。微小的变化是可以的，但是在提交代码贡献时应该指出。
- 严格遵循[编码指南]({{site.base}}/zh/contribute-code.html#coding-guidelines)和[代码样式]({{ site.base }}/zh/contribute-code.html#code-style)。
- 不要将不相关的代码混合到一个代码贡献中。

**请随时提出问题**，可以发送邮件到[dev邮件列表]({{site.base}}/community.html #fmail-list)或在 Jira issue 下留言。

以下说明将帮助你[配置开发环境]({{site.base}}/zh/contrib-code.html＃setup-a-development-environment)。


### 验证代码的合规性

在提交你的贡献之前验证更改的合规性非常重要。这包括：

- 确保代码构建。
- 验证所有现有测试和新测试都通过。
- 检查是否违反了代码样式。
- 确保不包含无关的或不必要的格式更改。

你可以通过调用以下代码来构建代码，运行测试并检查（部分）代码样式：

```
mvn clean verify
```

请注意，Flink 代码库中的一些测试是不稳定的，可能会失败。Flink 社区正在努力改进这些测试，但有时这是不可能的，例如，当测试包括外部依赖时。我们在 Jira 中追踪了所有已知的不稳定测试并贴上了**“test-stability”**标签。如果你遇到似乎与你的更改无关的测试失败，请检查（并扩展）[已知的不稳定测试](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20AND%20labels%20%3D%20test-stability%20ORDER%20BY%20priority%20DESC) 列表。

请注意，我们还会为 Java、Scala 和 Hadoop 的不同版本组合来运行编译构建（build profiles），以验证你的代码贡献。我们鼓励每个贡献者都使用*持续集成*服务，无论何时推送更改，它都会自动测试仓库中的代码。[最佳实践]({{site.base}}/zh/contribution-code.html#best-practices)指南介绍了如何将 [Travis](https://travis-ci.org/) 与你的 GitHub 仓库集成。

除了自动化测试之外，请检查更改的差异并删除所有不相关的更改，例如不必要的重新格式化。




### 准备并提交你的代码贡献

要使代码更易于合并，请将其 rebase 到主仓库的 master 分支的最新版本之上。另外还请遵守 [commit message指南]( {{ site.base }}/zh/contribute-code.html#coding-guidelines )，清理你的提交历史记录，并将你的提交压缩到一个适当的集合中。请在 rebase 和压缩之后再次验证你的代码贡献。

Flink 项目通过 [GitHub Mirror](https://github.com/apache/flink) 以 [Pull Requests](https://help.github.com/articles/using-pull-requests) 的形式接受代码贡献。Pull request 是一种提供补丁的简单方法，它提供了一个指向包含更改的代码分支的链接。

要提交 pull request，请将你的贡献推回到 Flink 仓库的分支中。

```
git push origin myBranch
```

打开你的 fork 仓库网页（`https://github.com/<your-user-name>/flink`）并使用*“Create Pull Request”*按钮开始创建 pull request。 确保 base fork 是`apache/flink master`，并且 head fork 是包含更改的分支。再为 pull request 添加一个有意义的描述并创建它。

也可以将补丁附加到 [Jira]({{site.FLINK_ISSUES_URL}}) issue 页面。

-----

## 编码指南

### Pull request 和 commit message
{:.no_toc}

- **单 PR 单修改**：请不要将各种不相关的更改组合在单个 PR 中。相反，创建多个单独的 PR 请求，每个 PR 关联一个 Jira issue。这确保了 PR 是与*主题相关的*，可以更容易地合并，并且通常只会与特定主题相关的 merge 冲突。

- **没有WIP PR **： 我们将 PR 视为引用的代码 *就是* 将合并到当前 *稳定* master 分支中的请求。因此，pull request 不应该是“正在进行中”（Working In Process, WIP）。当你确信代码可以合并到当前 master 分支中，再创建 pull request。如果你想对代码先进行一些讨论，可以贴一个你的工作分支的链接。

- **commit message**：PR 必须有相关联的 Jira issue；如果不存在，请先创建一个 Jira issue。最新的提交消息应该引用该 issue。一个提交消息示例是 **[FLINK-633] Fix NullPointerException for empty UDF parameters**。这样，pull request 就已经描述了了它想做什么，例如，用什么方法修复了什么 bug。

- **追加 review commits**：当你的 pull request 收到有关更改和改进的评论后，请为这些更改追加 commits。*请不要 rebase 和压缩 commits。*这能让人们更清楚的审查你的新的更新，否则，审查者 它允许人们独立地审查清理工作。否则，审阅者必须再次从头到尾审查一遍 diff。

- **不要有 merge commits**：请不要创建任何包含 merge commits 的 PR。如果想要将你的更改更新到最新的 master 分支上，请使用`git pull --rebase origin master` 命令。

### 异常和错误信息
{:.no_toc}

- **吞下异常**：不要吞下异常并打印堆栈跟踪，而是检查类似的类是如何处理异常的。

- **有意义的错误信息**：提供有意义的错误信息消息，试着想象为什么要抛出异常（用户做错了什么），给出的信息要能帮助用户解决问题。

### 测试
{:.no_toc}

- **测试需要通过**。测试未通过或编译未成功的 pull request 将不会有任何进一步的审查。我们建议你将个人 GitHub 帐户与 [Travis CI](http://travis-ci.org/)（像 Flink GitHub 仓库一样）连接。无论何时将更新推入 *你的* GitHub 仓库，Travis 都会针对所有测试环境运行测试。请注意之前的[关于不稳定测试的说明]({{site.base}}/zh/contribute-code.html#verifying-the-compliance-of-your-code)。

- **需要测试新功能**。所有新加的功能都需要测试覆盖，*严格要求*。非常容易在之后的合并中不小心移除或破坏了这个特性。如果特性没有受到测试的保护，则不会捕获到这一点。任何未被测试覆盖的东西都被认为是不完善的（cosmetic）。

- **使用适当的测试机制**. 请使用单元测试来测试独立的功能，例如方法。单元测试应该在几秒内执行完成，而且应该是首选测试方法。单元测试类的名称必须以 `*Test `结尾。使用集成测试来实现长时间运行的测试。Flink 提供了测试工具来启动 Flink 实例并运行作业的端到端测试。这些测试比较重，并且会显著延长构建时间。因此，应谨慎添加它们。端到端测试类的名称必须以 `*ITCa   se` 结尾。

### 文档
{:.no_toc}

- **文档更新**。许多更改也会影响文档（Javadoc 和 `docs/` 目录中的用户文档）。这些 pull request 和补丁中需要相应地更新文档，否则这些更改无法被合并。有关如何更新文档的信息，请参阅[文档贡献]({{site.base}}/zh/contribute-documentation.html)指南。
- **公共方法的 Javadocs**。所有的公共方法和类都需要有 Javadoc。请编写有意义的文档。好的文档是简洁和信息丰富的。如果你更改了方法的签名或行为，请务必更新 Javadoc。

### 代码格式化
{:.no_toc}

- **不要格式化**。请将源文件的代码格式化保持在最低限度。如果你(或你的 IDE 自动)删除或替换空白、重新格式化代码或注释，那么 diff 就不可读了。另外，更改相同文件的其他补丁将会无法合并。请将 IDE 配置为不会自动重新格式化代码。带有过多或不必要的代码格式化的 pull request 可能会被拒绝。



-----

## 代码风格

### 许可证
- **Apache license headers。** 确保你的文件头部有 Apache 许可证。当你构建代码时，RAT 插件会检查这一点。

### 导入
- **在包声明之前和之后添加空行。**
- **不要有未使用的导入。**
- **不要有多余的导入。**
- **不要使用通配符导入。**在添加代码时，甚至在重构过程中，它们都可能导致有问题。
- **导入顺序。** 导入必须按字母顺序排列，分成以下几块，每个块之间用空行分隔:
	- &lt;imports from org.apache.flink.*&gt;
	- &lt;imports from org.apache.flink.shaded.*&gt;
	- &lt;imports from other libraries&gt;
	- &lt;imports from javax.*&gt;
	- &lt;imports from java.*&gt;
	- &lt;imports from scala.*&gt;
	- &lt;static imports&gt;

### 命名
- **包名必须以字母开头，并且不能包含大写字母或特殊字符。**
- **非私有静态final字段必须是大写的，单词之间用下划线分隔。** (`MY_STATIC_VARIABLE`)
- **非静态字段/方法必须使用小写开头的驼峰法。** (`myNonStaticField`)

### 空格
- **制表符 vs 空格。** 我们使用制表符缩进，而不是空格。我们在这个问题上并没有信仰偏好，只是碰巧在项目初始时使用了制表符，而不要混用空格和制表符是很重要的 (合并/差异冲突)。
- **末尾不要有空格。**
- **运算符和关键字两边添加空格** 运算符(`+`, `=`, `>`, ...)和关键字 (`if`, `for`, `catch`, ...) 在它们之前和之后必须有一个空格，前提是它们不在行首或行尾。

### 大括号
- **左花括号('{')不能放在新行上。**
- **右花括号('}')必须始终放在行首。**
- **块。** 在 `if`, `for`, `while`, `do`, ... 之后的所有语句都必须用花括号封装在一个块中(即使这个块包含一条语句)。

  ```java
  for (…) {
   …
  }
  ```

    如果你想知道原因，请回忆一下苹果SSL库中著名的[*goto bug*](https://www.imperialviolet.org/2014/02/22/applebug.html)。


### Javadocs

- **所有公共/受保护的方法和类必须有一个Javadoc。**

- ** Javadoc的第一句话必须以句号结束。**

- **段落必须用新行隔开，并以&lt;p&gt;开头。**


### 修饰符

- **没有多余修饰符。例如，接口方法中的 public 修饰符。

- **遵循 JLS3 修饰符顺序。**修饰符必须按照以下顺序排列:public、protected、private、abstract、static、final、transient、volatile、synchronized、native、strictfp。


### 文件

- **所有文件必须以`\n`结尾。**

- **文件长度不能超过3000行。**


### 杂项

- **数组必须定义为 Java-style。**例如，`public String[] array`。
- **使用 Flink Preconditions。**为了增加一致性，请始终使用`org.apache.flink.Preconditions`的`checkNotNull`和`checkArgument`方法，Apache Commons Validate或 Google Guava。
- **不要使用原生的泛型类型。**不要使用原生的泛型类型，除非是必须需要（某些时候签名匹配、数组是必需的）。
- **Suppress warnings。**如果无法避免的警告(如“unchecked”或“serial”)，则添加注解以抑制警告。
- **注释。**在代码中添加注释。这段代码是在做什么？添加 Javadoc 或者继承它们，而不是在方法里加注释。不要自动生成注释，并避免不必要的注释，如:

  ​```java
i++; // 增加1
```

-----

## 最佳实践

- Travis: Flink 已经预先配置了 [Travis CI](http://docs.travis-ci.com/) 。它可以很容易地为你 fork 的仓库启用（它使用 GitHub 进行身份验证，因此你不需要额外的帐户）。只需将 *Travis CI* hook 添加到你的仓库(*Settings --> Integrations & services --> Add service*)，并在 [Travis](https://travis-ci.org/profile) 上启用 `flink` 仓库的测试。

-----

## 设置开发环境

### 开发和构建 Flink 的先决条件

* 类 unix 环境（我们使用 Linux、Mac OS X、以及 Cygwin）
* git
* Maven（至少 3.0.4 版本）
* Java 7 或 8

### 克隆仓库
{:.no_toc}

Apache Flink 的源代码存储在 [git](http://git-scm.com/) 仓库中，[GitHub](https://github.com/apache/flink) 上有该仓库的镜像。在 GitHub 上交流（exchange）代码的常见方法是将仓库 fork 到个人的 GitHub 帐户中。为此，你需要有一个 [GitHub](https://github.com) 帐户，如果没有，可以免费创建一个帐户。Fork 一个仓库意味着 GitHub 为你创建了一个该仓库的副本。可以通过点击 [仓库页面](https://github.com/apache/flink) 右上角的 *Fork* 按钮来完成的。一旦你在个人帐户中拥有了 Flink 仓库的 fork，你就可以将该仓库克隆到你的本地计算机上。

```
git clone https://github.com/<your-user-name>/flink.git
```

代码将被下载到一个名为 `flink` 的目录中。


### 代理设置

如果你在一个防火墙背后，可能需要为 Maven 和 IDE 配置代理。

例如，WikipediaEditsSourceTest 通过 IRC 进行通信，需要通过 [SOCKS 代理服务器](http://docs.oracle.com/javase/8/docs/technotes/guides/net/proxies.html)。

### 安装一个 IDE 并导入源代码
{:.no_toc}

Flink 提交者使用 IntelliJ IDEA 和 Eclipse IDE 开发 Flink 源码。


IDE 的最低要求是:

- 支持 Java 和 Scala（也要支持混合项目）
- 支持 Maven （能用于 Java 和 Scala）

#### IntelliJ IDEA

IntelliJ IDE 支持了开箱即用的 Maven，并且提供了 Scala 开发的插件。

- IntelliJ 下载: [https://www.jetbrains.com/idea/](https://www.jetbrains.com/idea/)
- IntelliJ Scala 插件: [http://plugins.jetbrains.com/plugin/?id=1347](http://plugins.jetbrains.com/plugin/?id=1347)

查看我们的 [安装配置 IntelliJ]({{site.docs-stable}}/flinkDev/ide_setup.html#intellij-idea) 指南以获得详细信息。

#### Eclipse Scala IDE

对于 Eclipse 用户，我们建议使用基于 Eclipse Kepler 的 Scala IDE 3.0.3。这是一个稍微老一点的版本，
我们发现它是对 Flink 这样的复杂项目最有效的版本。

有关最新 Scala IDE 版本的详细信息和指南，请参阅 [如何安装配置Eclipse]({{site.docs-stable}}/flinkDev/ide_setup.html#eclipse) 文档。

**注意:**在执行如下设置之前，请确保在命令行运行构建一次 （`mvn clean install -DskipTests`；见下文）.

1. 下载 Scala IDE (首选)或将插件安装到 Eclipse Kepler。请查阅
   [如何安装配置Eclipse]({{site.docs-stable}}/flinkDev/ide_setup.html#eclipse) 下载链接和说明。
2. 添加 “macroparadise” 编译器插件到Scala编译器中。
   打开 "Window" -> "Preferences" -> "Scala" -> "Compiler" -> "Advanced" 并将 *macroparadise* jar 包路径填到 “Xplugin” 字段中（通常是 "/home/*-your-user-*/.m2/repository/org/scalamacros/paradise_2.10.4/2.0.1/paradise_2.10.4-2.0.1.jar"）。
   注意:如果你没有jar文件，那么你可能没有运行命令行构建。
3. 导入 Flink Maven 项目 ("File" -> "Import" -> "Maven" -> "Existing Maven Projects")
4. 在导入期间，Eclipse 将要求自动安装额外的 Maven 构建助手插件。
5. 关闭“flink-java8”项目。因为 Eclipse Kepler 不支持 Java 8，所以你不能开发这个项目。

#### 导入源代码

Apache Flink 使用 Apache Maven 作为构建工具。大多数 IDE 都能够导入 Maven 项目。

### 构建代码
{:.no_toc}

要从源代码构建 Flink ，打开终端，导航到 Flink 源代码的根目录，调用:

```
mvn clean package
```

这将构建 Flink 并运行所有测试。Flink 将安装到 `build-target` 中。

要构建 Flink 而不执行测试，你可以调用:

```
mvn -DskipTests clean package
```


-----


## Committer 如何使用 Git

只有 ASF 的基础架构团队可以管理访问 GitHub 镜像。因此，comitters 必须将更改推送到 ASF 的 git 仓库。

### 主仓库
{:.no_toc}

**ASF writable**: https://gitbox.apache.org/repos/asf/flink.git

**ASF read-only**: https://github.com/apache/flink.git

注意: Flink 不使用 Oracle JDK 6 构建。它可以使用 Oracle JDK 6 运行。


如果你想为 Hadoop 1 构建，可以通过`mvn clean package -DskipTests -Dhadoop.profile=1`来生效 build profile。

