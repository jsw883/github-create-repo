#!/bin/bash
# github-create-repo

# usage details
usage() {
  cat << EOF
[`basename $0`]
USAGE: `basename $0` [-h]
       `basename $0` [-l]
       `basename $0` [-v] [-r repo_name] [-m message]

OPTIONS:
  -h  usage
  -r  repository name (default is the cururent directory base name)
  -m  commit message (default is automated)
  -v  verbose (debugging)
  -l  list remote repositories (diagnostic only)

See http://developer.github.com/v3/ for GitHub API v3. Note that curl is being
used to perform the GET and POST requests provided in the API, as demonstrated
in some of the examples on the main page.
EOF
}

# default options
repo_name=`basename $(pwd)`
message="github-create-repo commit (automated)"
verbose=false
curl_flag="-s"
list_only=false

# parse options using getopts
while getopts ":hr:m:vl" OPTION # while getopts ":hr:c:m:vl" OPTION
do
  case $OPTION in
    h)  usage
        exit 0
        ;;
    r)  repo_name=$OPTARG
        ;;
    m)  message=$OPTARG
        ;;
    v)  verbose=true
        curl_flag=""
        ;;
    l)  list_only=true
        ;;
    :)  echo "`basename $0`: $OPTARG requires an argument to be provided"
        echo "See '`basename $0` -h' for usage details"
        exit 1
        ;;
    ?)  echo "`basename $0`: $OPTARG invalid"
        echo "See '`basename $0` -h' for usage details"
        exit 1
        ;;
  esac
done

# start working
echo "[`basename $0`]"

# validate github credentials for https security 
username=`git config --global github.user`
if [ "$username" = "" ]; then
  echo "Could not find username: run 'git config --global github.user <username>'"
  invalid_credentials=1
fi
apitoken=`git config --global github.token`
if [ "$apitoken" = "" ]; then
  echo "Could not find personal access token for https security: run 'git config --global github.token <token>'"
  invalid_credentials=1
fi
if [ "$invalid_credentials" = "1" ]; then
  echo "`basename $0`: invalid github credentials (see report above)"
  exit 3
fi

# check for .gitignore and README.md
if [ ! -f .gitignore ]; then
  if $verbose; then echo "Custom .gitnore not found: attempting to copy standard .gitignore from ~/.github-repo-defaults"; fi
  touch .gitignore
  cp ~/.github-repo-defaults/.gitignore .gitignore
fi
if [ ! -f README.md ]; then
   if $verbose; then echo "Custom README.md not found: attempting to copy standard README.md from ~/.github-repo-defaults"; fi
   touch README.md
   cp ~/.github-repo-defaults/README.md README.md
fi

# simply list all repos
if $list_only; then
  if $verbose; then echo "Listing remote repositories ..."; fi
  curl $curl_flag -u "$username:$apitoken" https://api.github.com/user/repos | grep "\"full_name\":" | cut -d \" -f 4 2>&1
    if [ $? -ne 0 ]; then echo "`basename $0`: curl could not perform GET"; exit 5; fi
  exit 0
fi

# sanity check before messing with remote server
echo "Parameters provided or default parameters assumed"
echo "  repository name = $repo_name"
echo "  commit message = $message"
echo -n "Proceed [y/n]:"
read answer
if [ $answer != "y" ]; then
  echo "`basename $0`: aborted"
  exit 0
fi

# create and push new repository
if $verbose; then echo "Creating local / github repository ..."; fi
if [ -d .git ]; then
  git remote show origin
  echo "`basename $0`: directory already tracked"
  exit 7
fi

if $verbose; then echo "Starting local git repository ..."; fi
git init
git add . 
git commit -m "$message"
  if [ $? -gt 1 ]; then echo "`basename $0`: could not commit local repository"; exit 8; fi

if $verbose; then echo "Creating Github repository '$repo_name' ..."; fi
curl $curl_flag -u "$username:$apitoken" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
  if [ $? -ne 0 ]; then echo "`basename $0`: curl could not perform POST"; exit 5; fi

if $verbose; then echo "Pushing local code to remote server ..."; fi
git remote add origin git@github.com:$username/$repo_name.git 2>&1
  if [ $? -ne 0 ]; then echo "`basename $0`: could not add remote repository"; exit 8; fi
git push -u origin master 2>&1
  if [ $? -ne 0 ]; then echo "`basename $0`: could not push to new remote repository"; exit 8; fi

if $verbose; then echo "`basename $0`: finished"; fi