# flink-web

This repository contains the Flink website: https://flink.apache.org/.

You find instructions for this repository here: https://flink.apache.org/contributing/improve-website.html.

## Testing changes locally

You can build the website using Docker such as below (without augmenting your host environment). Parameters passed as 
part of this call will be forwarded to `build.sh`.
```bash
# starts website with future post being disabled
bash docker-build.sh -p

# starts website including also future posts
bash docker-build.sh -f
```

Both commands will start a webserver providing the website via `http://0.0.0.0:4000`.

## Building website

The site needs to be rebuild before merging into the branch asf-site.
```bash
bash docker-build.sh
```
