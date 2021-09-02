# flink-web

This repository contains the Flink website: https://flink.apache.org/.

You can find instructions for contributing to this repository here: https://flink.apache.org/contributing/improve-website.html.

## Testing changes locally

You can build the website using Docker (without changing your host environment) by using the provided script as shown below. 
Parameters passed as part of this call will be forwarded to `build.sh`. The `-i` option can be used to enable incremental builds.

```bash
# starts website with future posts disabled
./docker-build.sh -p

# starts website including future posts
./docker-build.sh -f
```

Both commands will start a web server hosting the website via `http://0.0.0.0:4000`.

If a newly added blog post does not show up in the blogs overview page, build the website again without the `-i` option.
You can also try deleting the "/content" directory before building the page locally. The entire "/content" directory will be
regenerated and include the newly added blog post.

## Building the website

The website needs to be rebuilt before being merged into the `asf-site` branch. When doing so, please *do not* use incremental builds. 

You can execute the following command to rebuild non-incrementally:

```bash
docker-build.sh
```
