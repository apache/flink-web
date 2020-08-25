# flink-web

This repository contains the Flink website: https://flink.apache.org/.

You find instructions for this repository here: https://flink.apache.org/contributing/improve-website.html.

You can build the website using Docker such as below (without augmenting your host environment):

```
make docker-run
```

And then rebuild the site before merging into the branch asf-site.

```
make docker-rebuild
```
