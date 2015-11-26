#!/bin/bash 
run(){ echo "-> $*"; [[ ! -n $DRY ]] && "$@"; } # run and show cmd

echo "$0> setting up git repo $1"
{
  git init
  [[ -n $1 ]] && { git remote add origin "$2"; git pull origin master; }
  # replace username-less repo with username
  grep -q github .git/config && sed -i 's|https://github.com|https://$GITHUBUSERNAME@github.com|g' .git/config
  mkdir test
  [[ ! -f README.md ]] &&
    echo -e "description here\n\n<img alt='' src='https://api.travis-ci.org/username/reponame'/>\n\n## Usage\n\n## Features\n\n## Example: foo\n" > README.md
  [[ -n $1 ]] && sed -i "s|username/reponame|${1/*com\//}|g" README.md
  echo -e "install: true\nscript: ./testrun" > .travis.yml
  echo -e "#!/bin/bash\n\necho 'OK'\nexit 0" > testrun
  chmod 755 testrun
  touch .gitignore
  touch .vimrc
  $(dirname "$0")/git.alias.hooks
} # &>/dev/null
