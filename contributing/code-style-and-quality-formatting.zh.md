---
title:  "Apache Flink 代码样式与质量指南 — 格式化"
---

{% include code-style-navbar.zh.md %}

{% toc %}



## Java 代码格式化样式

我们推荐使用 IDE 以便自动检查代码样式。 请遵循 [IDE 安装指南](https://ci.apache.org/projects/flink/flink-docs-master/flinkDev/ide_setup.html#checkstyle-for-java)。


### 许可证

* **Apache 许可文件头。** 确认文件里包含 Apache 许可文件头。 当构建代码时，使用RAT插件可以检查它。

### 导包

* **包声明前后要有空行。**
* **没有未使用的导入。**
* **没有多余的导入。**
* **没有包含通配符的导入。** 在添加代码，甚至重构代码的过程中，这样做都可能会导致问题发生。
* **导入顺序。** 导入必须按字母顺序排列，按如下导入代码块分类，每个导入代码块之间用空行隔开:
    * &lt;imports from org.apache.flink.*&gt;
    * &lt;imports from org.apache.flink.shaded.*&gt;
    * &lt;imports from other libraries&gt;
    * &lt;imports from javax.*&gt;
    * &lt;imports from java.*&gt;
    * &lt;imports from scala.*&gt;
    * &lt;static imports&gt;


### 命名

* **包名必须以字母开头，并且不能包含大写字母或特殊字符。**
 **非私有的静态 final 字段必须是大写，单词之间用下划线分隔。**(`MY_STATIC_VARIABLE`)
* **非静态字段/方法必须以驼峰式命名。** (`myNonStaticField`)


### 空格

* **制表符和空格的比较。** 我们使用制表符来缩进，而不是空格。
我们觉得使用空格会更好一点；使用制表符恰巧是因为我们很久以前就开始使用了(因为当时 Eclipse 的默认样式使用制表符)，使用制表符是为了保持代码的一致性(而不是混合制表符和空格)。
* **尾部不要留空格。**
* **操作符/关键字 前后有空格.** 操作符 (`+`, `=`, `>`, …) 和关键字 (`if`, `for`, `catch`, …) 必须在它们前后留出一个空格，前提是它们不在行首或行尾。


### 大括号

* **左大括号 (<code>{</code>) 不能放在新的行首**
* <strong>右大括号 (<code>}</code>) 必须始终放在行首。</strong>
* <strong>代码块。</strong> <code>if</code>, <code>for</code>, <code>while</code>, <code>do</code>, … 后面的所有语句必须始终用花括号封装在一个代码块中(即使该代码块只包含一条语句)。


### Java 注释文档

* **所有 public/protected 的方法和类必须有 Java 注释文档。**
* **Java 注释文档的第一句话要以句点结尾。**
* **段落之间必须用新的行隔开, 并以 <p> 开头。**


### 修饰符

* **没有多余的修饰符。** 例如, 不要在接口方法前加 public 修饰符。
* **遵循 JLS3 修饰符顺序。** 修饰符必须按照以下顺序排列: public, protected, private, abstract, static, final, transient, volatile, synchronized, native, strictfp。


### 文件

* **所有文件必须以 <code>\n</code> 结尾。**
* <strong>文件长度不能超过 3000 行。</strong>


### 杂项

* **数组必须定义为 java 风格。** 例如, `public String[] array`.
* **使用 Flink Preconditions.** 为了增加代码一致性, 统一使用 `org.apache.flink.Preconditions` 的方法 `checkNotNull` 和 `checkArgument` 而不要使用 Apache Commons Validate 或者 Google Guava.



<hr>

[^1]:
     为了简化调试并避免依赖冲突，我们将这些框架放在Flink之外。
