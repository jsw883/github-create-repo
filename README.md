github-create-repo
==================

Bash script for creating a github repository from the current directory inspired by the [blog post](http://viget.com/extend/create-a-github-repo-from-the-command-line) by Eli Fatsi and developed into something more functional. Options are used to allow the repository name to be changed from the default current directory base name and a specific commit message to be specified. For diagnostic purposes the script can also list all repositories on your remote server.

The script uses the [GitHub API v3](http://developer.github.com/v3/), which uses HTTPS GET and POST requests to send and receive JSON data using [cURL](http://curl.haxx.se/), as demonstrated in some of the examples in the API. Note that you need to have a github personal access token in order to use the API, which you can set up by following the steps on [this article](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) or going to the [applications page](https://github.com/settings/applications) on your your github [profile page](https://github.com/settings/profile) and creating a new personal access token with repo, user, and gist scopes (minimum). From this, you need to copy your token (before refreshing your page) and run `git config --global github.token <token>` with `<token>` replaced with your token string.

Note that if you do not already have a .gitignore and README.md in the current directory, the script will copy default .gitignore and README.md into the current directory before creating the github repository, as these are required.

Note that script has only be tested on Linux, and although [cURL](http://curl.haxx.se/) should work the same on Mac OS X and on Windows with Cygwin, there might be subtleties which have yet to be tested and discovered. Makefiles are provided for installation under these environments, which make github-create-repo.sh executable and globally accesible and makes .github-repo-defaults available for copying.

### Install

Modify the Makefile.config to specify your home directory and run `make install`.

### Usage

```
github-create-repo -l
github-create-repo -v -r "specific repository name" -m "specific commit message"
```