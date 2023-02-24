# flink-web

This repository contains the Flink project website: https://flink.apache.org/.

You can find instructions for contributing to this repository here: https://flink.apache.org/how-to-contribute/improve-website/

## Testing changes locally

### Build the documentation and serve it locally

The Flink documentation uses [Hugo](https://gohugo.io/getting-started/installing/) to generate HTML files.  More specifically, it uses the *extended version* of Hugo with Sass/SCSS support.

To build the documentation, you can install Hugo locally or use a Docker image.

The built site is served at http://localhost:1313/.

#### Using Hugo Docker image:

```sh
$ ./docker-build.sh
```

#### Local Hugo installation:

Make sure you have installed [Hugo](https://gohugo.io/getting-started/installing/) on your system.

```sh
$ ./build.sh
```

The site can be viewed at http://localhost:1313/

## Building the website

You must have [Hugo](https://gohugo.io/getting-started/installing/) installed on your system.

The website needs to be rebuilt before being merged into the `asf-site` branch.  

You can execute the following command to rebuild non-incrementally:

#### Using Hugo Docker image:

```bash
./docker-build.sh build
```

#### Local Hugo installation:

```bash
./build.sh build
```

This will generate the static HTML files in the `content` folder, which are used to serve out the project website.

## Contribute

### Markdown

The documentation pages are written in [Markdown](http://daringfireball.net/projects/markdown/syntax). It is possible to use [GitHub flavored syntax](http://github.github.com/github-flavored-markdown) and intermix plain html.

### Front matter

In addition to Markdown, every page contains a Jekyll front matter, which specifies the title of the page and the layout to use. The title is used as the top-level heading for the page. The default layout is `plain` (found in `_layouts`).

    ---
    title: "Title of the Page"
    ---
    
    ---
    title: "Title of the Page" <-- Title rendered in the side nave
    weight: 1 <-- Weight controls the ordering of pages in the side nav.
    aliases:  <-- Alias to setup redirect from removed page to this one
      - /alias/to/removed/page.html
    ---

### Structure

#### Page

##### Headings

All documents are structured with headings. From these headings, you can automatically generate a page table of contents (see below).

```
# Level-1 Heading  <- Used for the title of the page 
## Level-2 Heading <- Start with this one for content
### Level-3 heading
#### Level-4 heading
##### Level-5 heading
```

Please stick to the "logical order" when using the headlines, e.g. start with level-2 headings and use level-3 headings for subsections, etc. Don't use a different ordering, because you don't like how a headline looks.

##### Table of Contents

Table of contents are added automatically to every page, based on heading levels 2 - 4.
The ToC can be omitted by adding the following to the front matter of the page:

    ---
    bookToc: false
    ---

#### ShortCodes

Flink uses [shortcodes](https://gohugo.io/content-management/shortcodes/) to add custom functionality
to its documentation markdown.
