# flink-web

This repository contains the Flink website: https://flink.apache.org/.

You can find instructions for contributing to this repository here: https://flink.apache.org/contributing/improve-website.html.

## Testing changes locally

Check out [the README in the `docs` folder](docs/README.md) for all information on how to build locally. 

## Building the website

The website needs to be rebuilt before being merged into the `asf-site` branch. When doing so, please *do not* use incremental builds. 

You can execute the following command to rebuild non-incrementally:

```bash
./docker-build.sh
```
