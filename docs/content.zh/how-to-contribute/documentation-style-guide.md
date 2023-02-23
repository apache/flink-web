---
title: 文档样式指南
bookCollapseSection: false
weight: 21
---

# 文档样式指南

本指南概述了在编辑以及贡献 Flink 文档中必要的样式原则。目的是在你的贡献之旅中可以投入更好的社区精力去改进和扩展既有文档，并使其更 **易读**、**一致** 和 **全面**。

## 语言

Flink 同时维护了 **英文** 和 **中文** 两种文档，当你拓展或者更新文档时，需要在 pull request 中包含两种语言版本。如果你不熟悉中文，确保本次贡献补充了如下额外操作：

* 开一个翻译的
  [JIRA](https://issues.apache.org/jira/projects/FLINK/issues)
  请求单，并打上 chinese-translation 的标签；
* 在此请求单上添加到原始 JIRA 请求单的链接。

正在寻求有助于将现有文档翻译成中文的风格指南？请继续查阅 [这个翻译规范](https://cwiki.apache.org/confluence/display/FLINK/Flink+Translation+Specifications)。

## 语言风格

如下，你可以看到一些初步的原则，这些原则可以确保书写中的可读性和通俗易懂。如果想更深入、更细致的了解语言风格，也可以参考 [通用准则](#通用准则)。

### 语态和语气

* **使用主动语态。**[主动语态](https://medium.com/@DaphneWatson/technical-writing-active-vs-passive-voice-485dfaa4e498)简洁，并让内容更具有吸引力。如果你在句子的动词后添加 _by zombies_ 后仍然读的通，那么你用的就是被动语态。

  <div class="alert alert-info">
    <b>主动语态</b>
    <p>"You can run this example in your IDE or on the command line."</p>

    <p></p>

  <b>被动语态</b>
    <p>"This example can be run in your IDE or on the command line (by zombies)."</p>
  </div>


  <div class="alert alert-info"> 
    <b>关于语态：</b>
    <p>如上语态规范主要是写英文文档过程中注意，中文文档仍然以 <a href='https://cwiki.apache.org/confluence/display/FLINK/Flink+Translation+Specifications'>这个翻译规范</a> 为准 
  </div>


* **使用你，而不是我们。** 用 _我们_ 会让用户感到困惑以及傲慢，给人“我们是一个秘密组织的成员，而 _你_ 并没有获得会员邀请”的感觉。所以用 _你_ 来建议用户。

* **避免使用针对性别和文化的语言。**文档无需指定性别：技术写作应当 [性别中立](https://techwhirl.com/gender-neutral-technical-writing/)。还有，在你的文化和日常交流中被认为是理所应当的行话和惯例，在其他地方可能很不一样。幽默就是很典型的例子：在某个文化中很棒的笑话，但在其他文化中可能被广泛误解。

* **避免对操作做能力限定以及对难度提前下结论。**对于很艰难才能完成操作或者操作中很容易沮丧的用户，使用诸如 _快速_ 或者 _容易_ 是糟糕的文档体验。

* **避免使用大写单词**来突出或者强调陈述。使用例如 **加粗** 或者 _斜体_ 来突出关键词通常会更礼貌。如果一个不明显的声明需要突出以引起更多的注意，可以按照段落分组，段落以标签开头，配合对应的 HTML 标记来突出显示：
  * `<span class="label label-info">Note</span>`
  * `<span class="label label-warning">Warning</span>`
  * `<span class="label label-danger">Danger</span>`

### 使用 Flink 特定术语

使用清晰的术语定义，也可以对要表达的内容提供有帮助的资源链接来辅助说明，例如其他的文档页面或者 {{< docs_link file="flink-docs-stable/docs/concepts/glossary" name="Flink 术语表">}}。目前，术语表仍在编辑中，新术语可以开 pull-request 来提交。

## 代码仓库

Markdown 文件（.md）的文件名应该是能高度总结主题的短名称，文件名全部 **小写** 并用 **破折号（-）** 分隔单词。中文的文件名和英文一致，但以 **.zh.md** 结尾。

## 语法

The documentation website is generated using
[Hugo](https://gohugo.io/) and the pages are written in
[Markdown](https://daringfireball.net/projects/markdown/syntax), a lightweight
portable format for web publishing (but not limited to it).

### 拓展语法

Markdown 还可以混合使用 [GitHub 风格的
Markdown](https://guides.github.com/features/mastering-markdown/) 和纯 [HTML](http://www.simplehtmlguide.com/cheatsheet.php)。 例如，一些贡献者更喜欢使用 HTML 标签来表示图片，这种混合的方式就很方便。

<a name="front-matter"></a>

### 前言

除 Markdown 之外，每个文件还包含一个 YAML [前言区块](https://jekyllrb.com/docs/front-matter/)，用于设置页面变量以及元数据。前言必须在文件的最开始，由三条虚线之间的有效 YAML 集合来指定。

<div class="alert alert-warning">
  <h3>Apache 许可证</h3>

  <p>对于每一个文档， 前言后都应当紧随一个Apache 许可证声明。两种语言版本的声明都用英语表示，并按照如下实例完全复制。</p>
</div>

```
---
title: Concepts
layout: redirect
---
<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at
  http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
```

下面是 Flink 文档前言中常用的变量。

<font size="3">
<table width="100%" class="table table-bordered">
  <thead>
  <tr>
    <th></th>
    <th style="vertical-align : middle;"><center><b>变量名</b></center></th>
    <th style="vertical-align : middle;"><center><b>可能值</b></center></th>
    <th style="vertical-align : middle;"><center><b>描述</b></center></th>
  </tr>
  <tr>
    <td><b>布局</b></td>
    <td>layout</td>
    <td>{base,plain,redirect}</td>
    <td>要使用的布局文件。布局文件位于 <i>_layouts</i> 目录下。</td>
  </tr>
  <tr>
    <td><b>内容</b></td>
    <td>title</td>
    <td>%s</td>
    <td>此标题是页面最顶部 （1级） 的标题。</td>
  </tr>
  <tr>
	    <td rowspan="4" style="vertical-align : middle;"><b>导航</b></td>
	    <td>nav-id</td>
	    <td>%s</td>
	    <td>页面 ID。其他页面可以使用此 ID 作为他们的 nav-parent_id。</td>
	  </tr>
	  <tr>
	    <td>nav-parent_id</td>
	    <td>{root,%s}</td>
	    <td>页面父级 ID。最低导航级别为 root。</td>
	  </tr>
	  <tr>
	    <td>nav-pos</td>
	    <td>%d</td>
	    <td>在每个导航级别下页面的相对位置。</td>
	  </tr>
	  <tr>
	    <td>nav-title</td>
	    <td>%s</td>
	    <td>此标题用于重载默认的文本链接（标题）</td>
	  </tr>
 </thead>
</table>
</font>

文档范围的信息和配置位于 `_config.yml` 下，在前言中也是可用的，通过 site 变量使用。可以使用以下语法访问这些设置：

```liquid
{{ "{{ site.CONFIG_KEY " }}}}
```
当生成文档时，占位符会被替换成变量 `CONFIG_KEY` 的值。

## 格式化

以下各节列出了基本的格式准则，可以帮助你开始编写一致且易于浏览的文档。

### 标题

在 Markdown 中，标题是任意以井号（#）开头的行，井号的数量表示标题级别。标题永远是嵌套和连续的，不能因为样式原因跳过标题级别！

<font size="3">
<table width="100%" class="table table-bordered">
  <thead>
  <tr>
    <th style="vertical-align : middle;"><center><b>语法</b></center></th>
    <th style="vertical-align : middle;"><center><b>级别</b></center></th>
    <th style="vertical-align : middle;"><center><b>描述</b></center></th>
  </tr>
  <tr>
    <td># 标题</td>
    <td><center>1级</center></td>
    <td>页面标题在前言中定义，此级别标题 <b>不应该使用</b>。</td>
  </tr>
  <tr>
    <td>## 标题</td>
    <td><center>2级</center></td>
    <td>章节的起始级别。用于按照高级别的主题或者目标来组织内容。</td>
  </tr>
  <tr>
    <td>### 标题</td>
    <td><center>3级</center></td>
    <td rowspan="2" style="vertical-align : middle;">子章节。在每个章节中用于分隔次要信息或者任务。</td>
  </tr>
  <tr>
    <td>#### 标题</td>
    <td><center>4级</center></td>
  </tr>
</thead>
</table>
</font>

<div class="alert alert-warning">
  <h3>最佳实践</h3>

标题使用叙述语言的措辞。例如，一个动态表格的文档页面，“动态表格和连续查询”就比“背景”或者“技术信息”更有描述性。
</div>

### 目录

在文档构建过程中，**标题**（TOC) 从页面标题自动生成，通过如下行标记使用：

```liquid
{{ "{:toc" }}}
```

仔细考虑下大于 **3级** 的标题。在 TOC 中去除指定标题：

```liquid
{{ "# 排除在外的标题
{:.no_toc" }}}
```

<div class="alert alert-warning">
  <h3>最佳实践</h3>

为所涵盖的主题写一个简短的介绍，并放在 TOC 之前。一些上下文，例如关键信息的概述，对于确保文档的连贯、降低阅读门槛都大有帮助。
</div>

### 导航

在文档构建中，导航的属性通过每个页面中的 [前言变量](#front-matter)配置。

在比较长的文档页面中使用 _回到首页_ 是很有必要的，这样用户就可以直接跳转到顶部而不用手动向上滑动。在使用标记中，通过在构建文档时替换占位符为一个默认的链接来实现：

```liquid
{{ "{% top " }}%}
```

<div class="alert alert-warning">
  <h3>最佳实践</h3>

建议至少要在 2 级章节的结尾处添加回到首页链接。
</div>

### 标注

如果你需要在文档中添加边缘案例、紧密相关或者最好了解的信息，使用特殊的标注来高亮是一个（很）好的实践。

* 突出显示提示以及有助于理解的信息：

  ```html
  <div class="alert alert-info"> // Info Message </div>
  ```

* 发出陷阱危险信号，或提醒关注必须要遵循的重要信息：

  ```html
  <div class="alert alert-danger"> // Danger Message </div>
  ```

### 链接

添加文档链接是一种有效的方法--可以引导用户更好的理解正在讨论的主题，而不会有重写的风险。

* **指向页面中各节的链接。** 每个标题都会生成一个隐式标识符，以便在页面中直接跳转。此标识符是通过将标题设置为小写并将内部空格替换为连字符来生成的。

  * **标题：** ## Heading Title
  * **ID：** #heading-title
  <p></p>

  ```liquid 
  [Link Text](#heading-title) 
  ```

* **链接到 Flink 文档的其他页面。**

  {% raw %}
  ```liquid 
  [Link Text]({% link path/to/link-page.md %})
  ```
  {% endraw %}

* **指向外部页面的链接**

  ```liquid 
  [Link Text](external_url)
  ```

<div class="alert alert-warning">
  <h3>最佳实践</h3>

链使用可以提供操作或者目标信息的描述性链接名称。例如，避免使用“了解更多”或“单击此处”链接。
</div>

### 可视化内容

图形和其他可视化内容放置在根目录的 _fig_ 目录下，可以使用类似于链接的语法在文档页面中引用：

```liquid 
{{< img src="/fig/image_name.png" alt="Picture Text" width="200px" >}}
```

<div class="alert alert-warning">
  <h3>最佳实践</h3>

在适当或必要的情况下使用流程图、表格和图形进行额外说明，但切勿作为独立的信息来源。确保内容中的字体大小不影响阅读，并且整体分辨率足够。
</div>

### 代码

* **行内代码、** 使用包围的反引号（ **\`**）来高亮正常文本流中的小代码段或者语言结构类型的引用。

* **代码块。** 表示自包含示例、功能演练、最佳实践演示或其他有用场景的代码，应使用带有适当 [语法高亮]((https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers))显示的围栏代码块（fenced code block）进行包装。其中一种代码块实现方式如下：


  ````liquid
  ```java 
     // Java Code
  ```
  ````

指定多个编程语言时，每个代码块都应设置为选项卡样式:

  ```html
  <div class="codetabs" markdown="1">

	  <div data-lang="java" markdown="1"> 

	  ```java
	   // Java Code
	  ```

	  </div>

	  <div data-lang="scala" markdown="1">

	  ```scala
	   // Scala Code
	  ```

	  </div> 

  </div>
  ```

在学习和探索过程会经常使用代码块，留心这些最佳实践：

* **展示关键开发任务。** 对用户有意义的通用实现场景需要保留代码样例。对教程或者演示提供足够长度和复杂的示例代码。

* **确保代码是独立的。** 代码示例应该是自包含的，并且没有外部依赖项（异常情况除外，例如有关如何使用特定连接器的示例）。包括所有不使用通配符的导入语句，以便新手理解和学习正在使用哪些包。

* **避免捷径。** 例如，像处理实际代码一样处理异常和清理。

* **使用注释，但不要过度。** 提供说明，用于描述代码的主要功能和可能的注意事项，这些注意事项可能在阅读时并不明显。使用注释来阐明实现细节并描述预期输出。

* **代码块中的命令。**可以使用 `bash` 语法记录命令。当给文档添加命令的时候考虑如下内容：
  * **参数名称长一点。** 长一点的参数名能很好的帮助用户理解命令的目的。相对于短名称，用户应该更喜欢长名称。
  * **每个参数占据一行。**长名称可能会让命令难以阅读。每个参数占据一行能提升可读性。为了支持复制粘贴，需要在命令的每个中间行使用反斜杠 `\` 转义换行。
  * **缩进。**每个新参数行应缩进6个空格。
  * **用前缀 `$` 来标识命令的开始。**同一处代码块中的多行命令会影响可读性。在每个新命令前放美元符 `$` 有助于识别命令的开头。

  一个格式正确的命令如下：

```bash
$ ./bin/flink run-application \
--target kubernetes-application \
-Dkubernetes.cluster-id=my-first-application-cluster \
-Dkubernetes.container.image=custom-image-name \
local:///opt/flink/usrlib/my-flink-job.jar
```

## 通用准则

本风格指南的首要目标是为写出**易读**、**一致**、**客观**、**合乎逻辑**以及**全面**的文档奠定基础。

#### 易读的

Flink 社区是多元化和国际化的，所以在编写文档时需要放眼全球。不是每个人的母语都是英语，而且使用 Flink （以及一般的流处理）的经验也是从初学者到资深不等。因此要确保内容的技术准确性以及语言清晰度，以便所有的用户都能理解。

#### 一致的

坚持本样式指南中详细的基本准则，并用自己的最佳判断来统一拼写、大小写、连字符、粗体和斜体。正确的语法、标点符号和拼写是值得做的，但并不是必须的--贡献文档对任何语言熟练度都是开放的。

#### 客观的

句子应该简洁和提纲挈领。根据经验，如果一个句子少于 14 个单词，读者就会很容易理解 90% 的内容。但如果大于 25 个单词通常就会很难理解了，应尽可能修改和拆分。简明和众所周知的关键词能让用户轻松的定位到相关的文档。

#### 合乎逻辑的

请注意，大部分用户只会浏览大约 [28% 的在线内容](https://www.nngroup.com/articles/website-reading/) 。这突出表明了将相关的概念按照清晰的信息结构分组、内容聚焦以及使用描述性标题的重要性。将最相关的内容放在每个章节的头两个段落是很好的实践，这样能增加用户的“时间投入回报”。

#### 全面的

使用积极主动的语法以及准确、有关联性的样例，以确保内容可被检索到并且对所有用户都是友好可读的。文档也会被翻译成其他语言，所以使用简单的语法和熟悉的单词有助于减少翻译的工作量。