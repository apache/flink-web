# flink-web

This repository contains the Flink website: https://flink.apache.org/.

You find instructions for this repository here: https://flink.apache.org/contributing/improve-website.html.

## Testing changes locally

You can build the website using Docker such as below (without augmenting your host environment). Parameters passed as 
part of this call will be forwarded to `build.sh`. The `-i` option can be used to enable incremental builds.
```bash
# starts website with future post being disabled
bash docker-build.sh -p

# starts website including also future posts
bash docker-build.sh -f
```

Both commands will start a webserver providing the website via `http://0.0.0.0:4000`.

If a newly added blog post is not showing up on the index / blog overview page, build the website again without the `-i` option, or delete the "content" directory before building the page locally. The "content" directory will be regenerated completely, including the newly added blog post.

## Building website

The site needs to be rebuild before merging into the branch asf-site.
When doing so, DO NOT use incremental builds.
```bash
bash docker-build.sh
```
