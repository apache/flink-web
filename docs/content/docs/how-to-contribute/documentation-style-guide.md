---
title: Documentation Style Guide
bookCollapseSection: false
weight: 21
---

# Documentation Style Guide

This guide provides an overview of the essential style guidelines for writing
and contributing to the Flink documentation. It's meant to support your
contribution journey in the greater community effort to improve and extend
existing documentation — and help make it more **accessible**, **consistent**
and **inclusive**.

## Language

The Flink documentation is maintained in **US English** and **Chinese** — when
extending or updating the documentation, both versions should be addressed in
one pull request. If you are not familiar with the Chinese language, make sure
that your contribution is complemented by these additional steps:

* Open a
  [JIRA](https://issues.apache.org/jira/projects/FLINK/issues)
  ticket for the translation, tagged with the chinese-translation component;
* Link the ticket to the original contribution JIRA ticket.

Looking for style guides to contribute with translating existing documentation
to Chinese? Go ahead and consult [this translation
specification](https://cwiki.apache.org/confluence/display/FLINK/Flink+Translation+Specifications).

## Language Style

Below, you find some basic guidelines that can help ensure readability and
accessibility in your writing. For a deeper and more complete dive into
language style, also refer to the [General Guiding
Principles](#general-guiding-principles).

### Voice and Tone

* **Use active voice.** [Active
  voice](https://medium.com/@DaphneWatson/technical-writing-active-vs-passive-voice-485dfaa4e498)
  supports brevity and makes content more engaging. If you add _by zombies_
  after the verb in a sentence and it still makes sense, you are using the
  passive voice.

  <div class="alert alert-info">
    <b>Active Voice</b>
    <p>"You can run this example in your IDE or on the command line."</p>

    <p></p>

  <b>Passive Voice</b>
    <p>"This example can be run in your IDE or on the command line (by zombies)."</p>
  </div>

* **Use you, never we.** Using _we_ can be confusing and patronizing to some
  users, giving the impression that “we are all members of a secret club and
  _you_ didn’t get a membership invite”. Address the user as _you_.

* **Avoid gender- and culture-specific language.** There is no need to identify
  gender in documentation: technical writing should be
  [gender-neutral](https://techwhirl.com/gender-neutral-technical-writing/).
  Also, jargon and conventions that you take for granted in your own language
  or culture are often different elsewhere. Humor is a staple example: a great
  joke in one culture can be widely misinterpreted in another.

* **Avoid qualifying and prejudging actions.** For a user that is frustrated or
  struggling to complete an action, using words like _quick_ or _easy_ can lead
  to a poor documentation experience.

* **Avoid using uppercase words** to highlight or emphasize statements.
  Highlighting key words with e.g. **bold** or _italic_ font usually appears more polite.
  If you want to draw attention to important but not obvious statements,
  try to group them into separate paragraphs starting with a label,
  highlighted with a corresponding HTML tag:
    * `<span class="label label-info">Note</span>`
    * `<span class="label label-warning">Warning</span>`
    * `<span class="label label-danger">Danger</span>`

### Using Flink-specific Terms

Use clear definitions of terms or provide additional instructions on what
something means by adding a link to a helpful resource, such as other
documentation pages or the {{< docs_link file="flink-docs-stable/docs/concepts/glossary" name="Flink Glossary.">}}
The Glossary is a work in progress, so you can also propose new terms by
opening a pull-request.

## Repository

Markdown files (.md) should have a short name that summarizes the topic
covered, spelled in **lowercase** and with **dashes (-)** separating the
words. The Chinese version file should have the same name as the English
version, but stored in the **content.zh** folder.

## Syntax

The documentation website is generated using
[Hugo](https://gohugo.io/) and the pages are written in
[Markdown](https://daringfireball.net/projects/markdown/syntax), a lightweight
portable format for web publishing (but not limited to it).

### Extended Syntax

Markdown can also be used in combination with [GitHub Flavored
Markdown](https://guides.github.com/features/mastering-markdown/) and plain
[HTML](http://www.simplehtmlguide.com/cheatsheet.php). For example, some
contributors prefer to use HTML tags for images and are free to do so with this
intermix.

### Front Matter

In addition to Markdown, each file contains a YAML [front matter
block](https://jekyllrb.com/docs/front-matter/) that will be used to set
variables and metadata on the page. The front matter must be the first thing in
the file and must be specified as a valid YAML set between triple-dashed lines.

<div class="alert alert-warning">
  <h3>Apache License</h3>

  <p>For every documentation file, the front matter should be immediately
  followed by the Apache License statement. For both language versions, this
  block must be stated in US English and copied in the exact same words as in
  the following example.</p>
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

Below are the front matter variables most commonly used along the Flink
documentation.

<font size="3">
<table width="100%" class="table table-bordered">
  <thead>
  <tr>
    <th></th>
    <th style="vertical-align : middle;"><center><b>Variable</b></center></th>
    <th style="vertical-align : middle;"><center><b>Possible Values</b></center></th>
    <th style="vertical-align : middle;"><center><b>Description</b></center></th>
  </tr>
  <tr>
    <td><b>Layout</b></td>
    <td>layout</td>
    <td>{base,plain,redirect}</td>
    <td>The layout file to use. Layout files are located under the <i>_layouts</i> directory.</td>
  </tr>
  <tr>
    <td><b>Content</b></td>
    <td>title</td>
    <td>%s</td>
    <td>The title to be used as the top-level (Level-1) heading for the page.</td>
  </tr>
  <tr>
	    <td rowspan="4" style="vertical-align : middle;"><b>Navigation</b></td>
	    <td>nav-id</td>
	    <td>%s</td>
	    <td>The ID of the page. Other pages can use this ID as their nav-parent_id.</td>
	  </tr>
	  <tr>
	    <td>nav-parent_id</td>
	    <td>{root,%s}</td>
	    <td>The ID of the parent page. The lowest navigation level is root.</td>
	  </tr>
	  <tr>
	    <td>nav-pos</td>
	    <td>%d</td>
	    <td>The relative position of pages per navigation level.</td>
	  </tr>
	  <tr>
	    <td>nav-title</td>
	    <td>%s</td>
	    <td>The title to use as an override of the default link text (title).</td>
	  </tr>
 </thead>
</table>
</font>

Documentation-wide information and configuration settings that sit under
`_config.yml` are also available to the front matter through the site variable.
These settings can be accessed using the following syntax:

```liquid
{{ "{{ site.CONFIG_KEY " }}}}
```
The placeholder will be replaced with the value of the variable named `CONFIG_KEY` when generating the documentation.

## Formatting

Listed in the following sections are the basic formatting guidelines to get you
started with writing documentation that is consistent and simple to navigate.

### Headings

In Markdown, headings are any line prefixed with a hash (#), with the number of
hashes indicating the level of the heading. Headings should be nested and
consecutive — never skip a header level for styling reasons!

<font size="3">
<table width="100%" class="table table-bordered">
  <thead>
  <tr>
    <th style="vertical-align : middle;"><center><b>Syntax</b></center></th>
    <th style="vertical-align : middle;"><center><b>Level</b></center></th>
    <th style="vertical-align : middle;"><center><b>Description</b></center></th>
  </tr>
  <tr>
    <td># Heading</td>
    <td><center>Level-1</center></td>
    <td>The page title is defined in the Front Matter, so this level should <b>not be used</b>.</td>
  </tr>
  <tr>
    <td>## Heading</td>
    <td><center>Level-2</center></td>
    <td>Starting level for Sections. Used to organize content by higher-level topics or goals.</td>
  </tr>
  <tr>
    <td>### Heading</td>
    <td><center>Level-3</center></td>
    <td rowspan="2" style="vertical-align : middle;">Sub-sections. Used in each Section to separate supporting information or tasks.</td>
  </tr>
  <tr>
    <td>#### Heading</td>
    <td><center>Level-4</center></td>
  </tr>
</thead>
</table>
</font>

<div class="alert alert-warning">
  <h3>Best Practice</h3>

Use descriptive language in the phrasing of headings. For example, for a
documentation page on dynamic tables, "Dynamic Tables and Continuous Queries"
is more descriptive than "Background" or "Technical Information".
</div>

### Table of Contents

In the documentation build, the **Table Of Contents** (TOC) is automatically
generated from the headings of the page using the following line of markup:

```liquid
{{ "{:toc" }}}
```

All headings up to **Level-3** are considered. To exclude a particular heading
from the TOC:

```liquid
{{ "# Excluded Heading
{:.no_toc" }}}
```

<div class="alert alert-warning">
  <h3>Best Practice</h3>

Write a short and concise introduction to the topic that is being covered and
place it before the TOC. A little context, such an outline of key messages,
goes a long way in ensuring that the documentation is consistent and
accessible to all levels of knowledge.
</div>

### Navigation

In the documentation build, navigation is defined using properties configured
in the [front-matter variables](#front-matter) of each page.

It's possible to use _Back to Top_ links in extensive documentation pages, so
that users can navigate to the top of the page without having to scroll back up
manually. In markup, this is implemented as a placeholder that is replaced with
a default link when generating the documentation:

```liquid
{{ "{% top " }}%}
```

<div class="alert alert-warning">
  <h3>Best Practice</h3>

It's recommended to use Back to Top links at least at the end of each Level-2
section.
</div>

### Annotations

In case you want to include edge cases, tightly related information or
nice-to-knows in the documentation, it’s a (very) good practice to highlight
them using special annotations.

* To highlight a tip or piece of information that may be helpful to know:

  ```html
  <div class="alert alert-info"> // Info Message </div>
  ```

* To signal danger of pitfalls or call attention to an important piece of
  information that is crucial to follow:

  ```html
  <div class="alert alert-danger"> // Danger Message </div>
  ```

### Links

Adding links to documentation is an effective way to guide the user into a
better understanding of the topic being discussed without the risk of
overwriting.

* **Links to sections in the page.** Each heading generates an implicit
  identifier to directly link it within a page. This identifier is generated by
  making the heading lowercase and replacing internal spaces with hyphens.

    * **Heading:** ## Heading Title
    * **ID:** #heading-title
  <p></p>

  ```liquid 
  [Link Text](#heading-title) 
  ```

* **Links to other pages of the Flink documentation.**

  ```liquid 
  [Link Text]({% link path/to/link-page.md %})
  ```

* **Links to external pages**

  ```liquid 
  [Link Text](external_url)
  ```

<div class="alert alert-warning">
  <h3>Best Practice</h3>

Use descriptive links that provide information on the action or destination.
For example, avoid using "Learn More" or "Click Here" links.
</div>

### Visual Elements

Figures and other visual elements are placed under the root _fig_ folder and
can be referenced in documentation pages using a syntax similar to that of
links:

```liquid 
{{< img src="/fig/image_name.png" alt="Picture Text" width="200px" >}}
```

<div class="alert alert-warning">
  <h3>Best Practice</h3>

Use flowcharts, tables and figures where appropriate or necessary for
additional clarification, but never as a standalone source of information.
Make sure that any text included in those elements is large enough to read
and that the overall resolution is adequate.
</div>

### Code

* **Inline code.** Small code snippets or references to language constructs in
  normal text flow should be highlighted using surrounding backticks ( **\`**
  ).

* **Code blocks.** Code that represents self-contained examples, feature
  walkthroughs, demonstration of best practices or other useful scenarios
  should be wrapped using a fenced code block with appropriate [syntax
  highlighting](https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers).
  One way of achieving this with markup is:

  ````liquid
  ```java 
     // Java Code
  ```
  ````

When specifying multiple programming languages, each code block should be styled as a tab:

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

These code blocks are often used to learn and explore, so there are a few
best practices to keep in mind:

* **Showcase key development tasks.** Reserve code examples for common
  implementation scenarios that are meaningful for users. Leave more lengthy
  and complicated examples for tutorials or walkthroughs.

* **Ensure the code is standalone.** Code examples should be self-contained
  and not have external dependencies (except for outlier cases such as
  examples on how to use specific connectors). Include all import statements
  without using wildcards, so that newcomers can understand and learn which
  packages are being used.

* **Avoid shortcuts.** For example, handle exceptions and cleanup as you
  would in real-world code.

* **Include comments, but don’t overdo it.** Provide an introduction
  describing the main functionality of the code and possible caveats that
  might not be obvious from reading it. Use comments to clarify
  implementation details and to describe the expected output.

* **Commands in code blocks.** Commands can be documented using `bash` syntax
  highlighted code blocks. The following items should be considered when adding
  commands to the docummentation:
    * **Use long parameter names.** Long parameter names help the reader to
      understand the purpose of the command. They should be preferred over their
      short counterparts.
    * **One parameter per line.** Using long parameter names makes the command
      possibly harder to read. Putting one parameter per line improves the
      readability. You need to add a backslash `\` escaping the newline at
      the end of each intermediate line to support copy&paste.
    * **Indentation**. Each new parameter line should be indented by 6 spaces.
    * **Use `$` prefix to indicate command start**. The readability of the code
      block might worsen having multiple commands in place. Putting a dollar sign
      `$` in front of each new commands helps identifying the start of a
      command.

  A properly formatted command would look like this:

```bash
$ ./bin/flink run-application \
--target kubernetes-application \
-Dkubernetes.cluster-id=my-first-application-cluster \
-Dkubernetes.container.image=custom-image-name \
local:///opt/flink/usrlib/my-flink-job.jar
```

## General Guiding Principles

This style guide has the overarching goal of setting the foundation for
documentation that is **Accessible**, **Consistent**, **Objective**,
**Logical** and **Inclusive**.

#### Accessible

The Flink community is diverse and international, so you need to think wide and
globally when writing documentation. Not everyone speaks English at a native
level and the level of experience with Flink (and stream processing in general)
ranges from absolute beginners to experienced advanced users. Ensure technical
accuracy and linguistic clarity in the content you produce so that it can be
understood by all users.

#### Consistent

Stick to the basic guidelines detailed in this style guide and use your own
best judgment to uniformly spell, capitalize, hyphenate, bold and italicize
text. Correct grammar, punctuation and spelling are desirable, but not a hard
requirement — documentation contributions are open to any level of language
proficiency.

#### Objective

Keep your sentences short and to the point. As a rule of thumb, if a sentence
is shorter than 14 words, readers will likely understand 90 percent of its
content. Sentences with more than 25 words are usually harder to understand and
should be revised and split, when possible. Being concise and using well-known
keywords also allows users to navigate to relevant documentation with little
effort.

#### Logical

Be mindful that most users will scan through online content and only read
around [28 percent of it](https://www.nngroup.com/articles/website-reading/).
This underscores the importance of grouping related ideas together into a clear
hierarchy of information and using focused, descriptive headings. Placing the
most relevant information in the first two paragraphs of each section is a good
practice that increases the “return of time invested” for the user.

#### Inclusive

Use positive language and concrete, relatable examples to ensure the content is
findable and welcoming to all users. The documentation is translated to other
languages, so using simple language and familiar words also helps reduce the
translation effort.