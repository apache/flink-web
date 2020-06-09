# flink-web

This repository contains the Flink website: https://flink.apache.org/.

You find instructions for this repository here: https://flink.apache.org/contributing/improve-website.html.

You can build the website using Docker such as below (without augmenting your host environment):

```
docker run --rm --volume="$PWD:/srv/flink-web" --expose=4000 -p 4000:4000 -it ruby:2.5 bash -c 'cd /srv/flink-web && ./build.sh -p'
```
