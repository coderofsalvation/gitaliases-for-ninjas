#!/bin/bash 
run(){ echo "-> $*"; [[ ! -n $DRY ]] && "$@"; } # run and show cmd

usage(){
  echo -e "Usage: git p [tags|-i] [branch] <remote1> [remote2] \n"
  echo "available tags:
    (w)ork in progress
    (b)ugfix
    (r)efactor
    (m) publish module (npm/composer)
    (u) tag as unstable
    (s) tag as stable"
}

[[ ! -n $1 ]] && usage && exit
[[ "$1" == "-i" ]] && {
  usage
  read -p "enter tags> " tags;
}

[[ "$1" =~ "w" ]] && commit_msg="work in progress [might break]"
[[ "$1" =~ "b" ]] && commit_msg="minor bugfix"
[[ "$1" =~ "r" ]] && commit_msg="major refactor"
[[ "$1" =~ "u" ]] && {
  run git tag -a unstable;
  run git tag -d stable;
}
[[ "$1" =~ "s" ]] && {
  run git tag -d stable;
  run git tag -a unstable;
}
[[ -n $commit_msg ]] && run git commit -m "$commit_msg"
[[ "$1" =~ "m" && -f package.json ]] && { run sleep 1s; run npm publish; }

# do the push
[[ -n $2 ]] && { branch=$2; shift;  } || branch=master
[[ ! "$(git branch)" =~ "$branch" ]] && { echo "branch $branch doesnt exist"; exit 1; }
[[ -n $1 ]] && { shift; remotes="$1"; shift; } || remotes="origin"
[[ -n $1 ]] && { remotes="$remotes $*";shift; } 
for remote in $remotes; do 
  run git push $remote $branch --tags
done
echo "$0> done"
