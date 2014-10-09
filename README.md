github-create
=============

Bash script for creating a github repository in the current directory inspired by the [blog post](http://viget.com/extend/create-a-github-repo-from-the-command-line) by Eli Fatsi and developed into something a little more functional. Options are used to allow the repository name to be changed from the default current directory base name and the commit message to be used. Also, to make sure that you know whether the repository already exists, you can have the script list all repositories on your remote server as well.

Note that previous issues with ca certificates were a consequence of using the broken *~/anaconda/bin/curl* supplied with the Anaconda distribution of Python 2.7 rather than the standard */usr/bin/curl* as expected. Hence, the path to the ca certificates no longer needs to be specified manually, provided that you have installed curl using the `sudo apt-get install curl` or the equivalent command.