---
title:  "贡献代码"
---

Apache Flink 通过志愿者贡献的代码得到维护，改进和扩展。 Apache Flink 社区鼓励任何人贡献源代码。为了确保贡献者和审阅者愉快地贡献高质量的代码，我们将遵循本文档中解释的贡献流程。

本文档包含了所有关于 Apache Flink 贡献代码的要点。它描述了准备，测试和提交贡献的流程，阐释了 Flink 代码库的编码指南和代码风格，并提供了设置开发环境的说明。

**重要**：在开始编写代码之前，请仔细阅读本文档。遵循下面描述的流程和指南非常重要。否则，您的 pull request(PR) 可能不被接受或可能需要大量返工。特别是，在提交实现**新功能**的 PR 之前，您需要提交 Jira 票证并与社区就是否需要此功能达成共识。



{% toc %}

## 代码贡献流程

### 在你编码之前…

...请确保有与您的贡献相对应的 Jira 问题。 这是 Flink 社区遵循所有代码贡献的一般规则*，包括错误修复，改进或新功能，但* *细小* 热修复除外。 如果您想修复发现的错误，或者想要为 Flink 添加新功能或改进，在开始实施之前请按照提交[错误报告]({{ site.baseurl }}/zh/how-to-contribute.html#file-a-bug-report) 或 [建议改进或新功能]({{ site.baseurl }}/zh/how-to-contribute.html#propose-an-improvement-or-a-new-feature)指南来在 [Flink Jira](http://issues.apache.org/jira/browse/FLINK) 中提交一个 issue。

如果 Jira 问题的描述表明其解析将触及代码库的敏感部分，或者问题足够复杂或需要添加大量新代码，Flink 社区可能会要求设计文档。（大多数贡献不应要求设计文档）设计文档的目的是确保解决问题的总体方法是明智的，并得到社区的一致同意。 需要设计文档的 Jira 问题使用 **`requires-design-doc`**标签进行标记， 任何社区成员都可以在认为有必要设计文档的 Jira 问题上标上此标签。 良好的描述有助于确定 Jira 问题是否需要设计文档，设计文件必须添加或附加到 Jira 问题或从 Jira 问题的链接，并涵盖以下方面：

- 通常方法的概述。
- API 更改列表（已更改的接口，新的和已弃用的配置参数，已更改的行为，......）。
- 要触及的主要组件和类。
- 提出的方法的已知的局限性。

任何人都可以添加设计文档，包括问题的记录者或修复者。

在设计文档被社区以[懒惰共识](http://www.apache.org/foundation/glossary.html#LazyConsensus)接受之前，需要设计文档的 Jira 问题的贡献将不会添加到 Flink 的代码库中。请在开始编写代码之前检查是否需要设计文档。


### 编码时...

...请遵守以下规则：

- Jira 问题中记录的任何讨论或要求都需要考虑。
- 遵循设计文档（如果需要设计文档）尽可能接近。 如果您的实施偏离设计文档提出的解决方案太多，请更新设计文档并达成共识。 微小的变化是可以的，但是在提交文稿时应该指出。
- 严格遵循[编码指南]( {{site.base}}/contribute-code.html#coding-guidelines)和[代码样式]({{ site.base }}/contribute-code.html#code-style)。
- 不要将不相关的问题混合到一个贡献中。

**请随时提出问题，**发送邮件到[dev邮件列表]({{site.base}}/community.html #fmail-list)或评论 Jira 问题。

以下说明将帮助您[设置开发环境]({{site.base}}/contrib-code.html＃setup-a-development-environment)。


### 验证代码的规范性

在提交您的贡献之前验证更改的合规性非常重要。 这包括：

- 确保代码构建。
- 验证所有现有测试和新测试都通过。
- 检查是否违反了代码样式。
- 确保不包含无关的或不必要的格式更改。

您可以通过调用以下代码来构建代码，运行测试并检查（部分）代码样式：

```
mvn clean verify
```

请注意，Flink 代码库中的一些测试是不稳定的，可能会失败。 Flink 社区正在努力改进这些测试，但有时这是不可能的，例如，当测试包括外部依赖时。 我们维护所有已知在 Jira 中不稳定的测试并附加**“test-stability”**标签。 如果您遇到似乎与您的更改无关的测试失败，请检查（并扩展）[已知的片状测试](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20AND%20labels%20%3D%20test-stability%20ORDER%20BY%20priority%20DESC) 列表。

请注意，我们为 Java，Scala 和 Hadoop 版本的不同组合运行其他构建配置文件，以验证您的贡献。 我们鼓励每个贡献者使用*持续集成*服务，无论何时推送更改，它都会自动测试仓库中的代码。 [最佳做法]({{site.base}} / contribution-code.html＃best-practices)指南介绍了如何将 [Travis](https://travis-ci.org/) 与您的 GitHub 仓库集成。

除了自动化测试之外，请检查更改的差异并删除所有不相关的更改，例如不必要的重新格式化。




### 准备并提交您的贡献

要使更改易于合并，请将其重新建立为主仓库主分支的最新版本。还请遵守[提交消息指南]( {{ site.base }}/contribute-code.html#coding-guidelines )，清理您的提交历史记录，并将您的提交压缩到一个适当的集合中。请在重新建立基础和提交压缩之后再次验证您的贡献。

Flink 项目通过 [GitHub Mirror](https://github.com/apache/flink) 接受代码贡献，形式为 [Pull Requests](https://help.github.com/articles/using-pull-requests) 。 Pull请求是一种提供补丁的简单方法，它通过提供指向包含更改的代码分支的指针。

要提交 pull request，请将您的贡献推回到 Flink 仓库的分支中。

```
git push origin myBranch
```

转到仓库 fork 的网站（`https://github.com/ <your-user-name> / flink`）并使用*“Create Pull Request”*按钮开始创建拉取请求。 确保基础分支是`apache/flink master`，并且 head fork 选择具有更改的分支。 给拉取请求一个有意义的描述并发送它。

也可以将补丁附加到 [Jira]({{site.FLINK_ISSUES_URL}}) 问题。

-----

## 编码指南

### 拉取请求和提交消息
{:.no_toc}

- **单独修改每个PR**：请不要将各种不相关的更改组合在单个 PR 中。相反，打开多个单独的 PR 请求，其中每个 PR 引用一个 Jira 问题。这确保了 PR 是与*主题相关的*，可以更容易地合并，并且通常只会导致特定于主题的合并冲突。

- **没有WIP  PR **： 我们将 PR 视为将引用的代码 *as is* 合并到当前 * stable * master 分支中的请求。 因此，拉取请求不应该是“正在进行中”。 如果您确信可以将其合并到当前主分支中而没有问题，请打开拉取请求。 如果您希望对代码发表评论，请发布指向您工作分支的链接。

- **提交信息**：PR 必须与 Jira 问题相关;如果您想进行的更改不存在问题，则创建一个问题。最新的提交消息应该引用该问题。一个提交消息示例是 **[FLINK-633] 修复空 UDF 参数的 NullPointerException **。这样，PR 就会自动给出它所做事情的描述，例如，它用什么方法修复了什么 bug。

- **附加审核提交**：当您收到有关请求更改的 PR 的注释时，请为这些更改添加提交。 *不要变形和压扁它们，*它允许人们独立地审查清理工作。 否则，审阅者必须再次完成整个差异集。

- **没有合并提交**：请不要打开包含合并提交的 PR 。 如果要在打开拉取请求之前更新对最新主服务器的更改，请使用`git pull --rebase origin master`。

### 例外和错误消息
{:.no_toc}

- **吞下异常**：不要吞下异常并打印堆栈跟踪。 而是检查类似类如何处理异常。

- **有意义的错误消息**.：提供有意义的异常消息 试着想象为什么可以抛出异常（用户做错了什么）并给出一条消息，帮助用户解决问题。

### 测试
{:.no_toc}

- **测试需要通过**. 测试未通过或未编译的任何拉取请求将不会进行任何进一步的审查。 我们建议您将个人 GitHub 帐户与 [Travis CI](http://travis-ci.org/)（如Flink GitHub仓库）连接。 无论何时将某些东西推入 *your* GitHub 仓库，Travis 都会针对所有测试环境运行测试。 请注意之前的[关于片状测试的评论]({{site.base}} / contrib-code.html＃verify -the-compliance-of-your-code)。

- **需要测试新功能**. 所有新特性都需要测试支持，*严格*。稍后的合并很容易意外地抛出或破坏某个特性。如果特性没有受到测试的保护，则不会捕获到这一点。任何未被测试覆盖的东西都被认为是表面的。

- **使用适当的测试机制**. 请使用单元测试来测试隔离的功能，例如方法。 单元测试应该在几秒内执行，并且应尽可能首选。 单元测试类的名称必须以 `* Test `结尾。 使用集成测试来实现长时间运行的测试。 Flink 为启动 Flink 实例并运行作业的端到端测试提供测试实用程序。 这些测试非常繁重，可以显着延长构建时间。 因此，应谨慎添加它们。 端到端测试类的名称必须以 `* ITCase` 结尾。

### 文档
{:.no_toc}

- **文档更新**。系统中的许多更改也会影响文档（Javadoc 和 `docs/` 目录中的用户文档）。 需要拉取请求和补丁来相应地更新文档; 否则无法接受更改源代码。 有关如何更新文档的信息，请参阅[帮助文档]({{site.base}} / contribution-documentation.html)指南。
- **用于公共方法的 Javadocs**。所有的公共方法和类都需要有 javadoc。请写有意义的文档。好的文档是简洁和信息丰富的。如果您更改了文档化方法的签名或行为，请务必更新 javadoc。

### 代码格式化
{:.no_toc}

- **不要格式化**。 请将源文件的重新格式化保持在最低限度。如果您(或您的 IDE 自动)删除或替换空白、重新格式化代码或注释，那么就无法读取差异。另外，影响相同文件的其他补丁也变得不可合并。请将 IDE 配置为不会自动重新格式化代码。带有过多或不必要的代码重新格式化的拉请求可能会被拒绝。



-----

## 代码风格

### 许可证
- **Apache 许可证标头。** 确保您的文件中有 Apache 许可头文件。当您构建代码时，RAT 插件会检查这一点。

### 导入
- **在包声明之前和之后空行。**
- **没有未使用的导入。**
- **没有多余的导入。**
- **不使用通配符导入。**在添加代码时，甚至在重构过程中，它们都可能导致有问题。
- **导入顺序。** 导入必须按字母顺序排列，分组为以下块，每个块之间用空行分隔:
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
- **制表符 vs 空格。** 我们使用制表符缩进，而不是空格。使用制表符还是空格不是严谨的;我们只是碰巧在行首使用了制表符，但是不要把他们混在一起使用(合并/差异冲突)。
- **末尾不要有空格。**
- **空格在运算符和关键字附近的使用** 运算符(' + '，' = '，' > '，…)和关键字(' if '， ' for '， ' catch '，…)在它们之前和之后必须有一个空格，前提是它们不在行首或行尾。

### 大括号
- **左花括号('{')不能放在新行上。**
- **右花括号('}')必须始终放在行首。**
- **块。** 在 if、for、while、do 之后的所有语句都必须用花括号封装在一个块中(即使这个块包含一条语句)。

  ```java
  for (…) {
   …
  }
  ```
```

	如果您想知道原因，请回忆一下苹果SSL库中著名的[*goto bug*](https://www.imperialviolet.org/2014/02/22/applebug.html)。


# # # Javadocs

- **所有公共/受保护的方法和类必须有一个Javadoc.**

- ** Javadoc的第一句话必须以句号结束

- **段落必须用新行隔开，并以<p>.**开头


# # #修饰符

- **没有多余修饰符。例如，接口方法中的公共修饰符。

- **遵循JLS3修改器顺序。**修饰符必须按照以下顺序排列:public、protected、private、abstract、static、final、transient、volatile、synchronized、native、strictfp。


# # #文件

- **所有文件必须以' \n ' .**结尾

- **文件长度不能超过3000行


# # # Misc

- **数组必须定义为java样式。例如，' public String[] array '。

- **使用Flink前提条件。**为了增加同质化，始终使用“org.apache.flink”。前置条件是' methods ' checkNotNull '和' checkArgument '，而不是Apache Commons Validate或谷歌Guava。

- **没有原始泛型类型。**不要使用原始泛型类型，除非是严格必需的(有时是签名匹配、数组必需的)。

- **抑制警告。如果无法避免警告(如“unchecked”或“serial”)，则添加注释以抑制警告。

- **评论。向代码中添加注释。它在做什么?添加javadoc或通过不向方法添加任何注释来继承它们。不要自动生成评论，并避免不必要的评论，如:


​```java

i++;//增加1
```

-----

## 最佳实践

- Travis: Flink 是为 [Travis CI](http://docs.travis-ci.com/) 预先配置的，它可以很容易地为您的个人仓库分支启用(它使用 GitHub 进行身份验证，因此您不需要额外的帐户)。只需将 *Travis CI* 钩子添加到您的仓库(*Settings—> integration & services—> add service*)，并在 [Travis](https://travis-ci.org/profile) 上启用对“flink”仓库的测试。

-----

## 设置开发环境

### 开发和构建 Flink 的要求

* 类 unix 环境 (We use Linux, Mac OS X, and Cygwin)
* git
* Maven (at least version 3.0.4)
* Java 7 or 8

### 克隆仓库
{:.no_toc}

Apache Flink 的源代码存储在  [git](http://git-scm.com/)  仓库中，该仓库镜像到  [GitHub](https://github.com/apache/flink) 。在 GitHub 上交换代码的常见方法是将仓库放到您的个人 GitHub 帐户中。为此，您需要有一个 [GitHub](https://github.com)   帐户或免费创建一个帐户。分叉仓库意味着 GitHub 为您创建了一个分叉仓库的副本。这是通过单击 [repository网站](https://github.com/apache/flink) 右上角的 *Fork* 按钮来完成的。一旦您在个人帐户中拥有了 Flink 仓库的一个分支，您就可以将该仓库克隆到您的本地计算机上。

```
git clone https://github.com/<your-user-name>/flink.git
```

代码被下载到一个名为 `flink` 的目录中。


### 代理设置

如果您打开了防火墙，可能需要为 Maven 和 IDE 提供代理设置。

例如，WikipediaEditsSourceTest 通过 IRC 进行通信，需要通过 [SOCKS 代理服务器](http://docs.oracle.com/javase/8/docs/technotes/guides/net/proxies.html)。

### 安装一个 IDE 并导入源代码
{:.no_toc}

Flink 提交者使用 IntelliJ IDEA 和 Eclipse IDE 开发 Flink 代码库。


IDE 的最低要求是:

- 支持 Java 和 Scala（也支持混合项目）
- 支持 Maven、Java 和 Scala

#### IntelliJ IDEA

IntelliJ IDE 支持 Maven 开箱即用，并为 Scala 开发提供了一个插件。

- IntelliJ 下载: [https://www.jetbrains.com/idea/](https://www.jetbrains.com/idea/)
- IntelliJ Scala 插件: [http://plugins.jetbrains.com/plugin/?id=1347](http://plugins.jetbrains.com/plugin/?id=1347)

查看我们的 [设置IntelliJ]({{site.doc -stable}}/flinkDev/ide_setup.html# IntelliJ -idea) 指南以获得详细信息。

#### Eclipse Scala IDE

对于 Eclipse 用户，我们建议使用基于 Eclipse Kepler 的 Scala IDE 3.0.3。这是一个稍微老一点的版本，

我们发现它是对 Flink 这样的复杂项目最有效的版本。


有关最新 Scala IDE 版本的详细信息和指南，请参阅

[如何设置Eclipse]({{site.doc -stable}}/flinkDev/ide_setup.html# Eclipse) 文档。

**注意:**在执行此设置之前，请确保从命令行运行构建一次
(`mvn clean install -DskipTests`; 见下文).

1. 下载 Scala IDE (首选)或将插件安装到 Eclipse Kepler。请看

   [如何设置Eclipse]({{site.doc -stable}}/flinkDev/ide_setup.html# Eclipse) 下载链接和说明。

2. 将“macroparadise”编译器插件添加到Scala编译器中。

   打开“Window”->“Preferences”->“Scala”->“Compiler”->“Advanced”并将路径放入“Xplugin”字段

   *macroparadise* jar 文件(通常是“/home/*-your-user-*/.m2/repository/org/scalamacros/paradis_2.10.4 /2.0.1/ paradis_2.10.4 -2.0.1.jar”)。

   注意:如果您没有jar文件，那么您可能没有运行命令行构建。

3. 导入 Flink Maven 项目(“File”->“Import”->“Maven”->“Existing Maven projects”)

4. 在导入期间，Eclipse 将要求自动安装额外的 Maven 构建助手插件。

5. 关闭“flink-java8”项目。由于 Eclipse Kepler 不支持 Java 8，所以不能开发这个项目。

#### 导入源代码

Apache Flink 使用 Apache Maven 作为构建工具。大多数 IDE 都能够导入 Maven 项目。


### 构建代码
{:.no_toc}

要从源代码构建 Flink ，打开终端，导航到 Flink 源代码的根目录，调用:

```
mvn clean package
```

这将构建 Flink 并运行所有测试。Flink 现在安装在 `build-target` 中。


要构建 Flink 而不执行测试您可以调用:

```
mvn -DskipTests clean package
```

-----


## 如何使用 Git 作为提交器

只有 ASF 的基础架构团队可以管理访问 GitHub 镜像。因此，comitters 必须将更改推送到 ASF 的 git 仓库。

### 主要来源库
{:.no_toc}

**ASF writable**: https://gitbox.apache.org/repos/asf/flink.git

**ASF read-only**: https://github.com/apache/flink.git

注意: Flink 不使用 Oracle JDK 6 构建。它使用 Oracle JDK 6 运行。


如果您想为 Hadoop 1 构建，可以通过`mvn clean package -DskipTests -Dhadoop.profile=1`激活构建概要文件。

