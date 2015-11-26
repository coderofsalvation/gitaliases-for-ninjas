Advanced git aliases for ninjas
===============================

### Statement ###

*Bash allows you to turn repetitive tasks into automations, Git aliases allow you to run Bash*

For all you git console ninjas out there: prevent yourself typing the same commands over and over again.

> DRY git power! modify this repo to your need!

## Installation

    $ git clone http://github.com/coderofsalvation/gitaliases-for-ninjas
    $ cp bin/* ~/bin/.
    $ git config --global alias.i ~/bin/git.alias.i
    $ git config --global alias.p ~/bin/git.alias.p
    $ git config --global alias.hooks ~/bin/git.alias.hooks
    $ cat .bashrc >> ~/.bashrc

## Example: basic

    $ git init
    please use 'git i'
    $ git i
    /home/sqz/bin/git.alias.init> setting up git repo 
    Initialized empty Git repository in /tmp/flopp/.git/
    /home/sqz/bin/git.alias.hooks> setting up git hooks in '.hooks'

Now lets see:    

    $ ls -la
    drwxrwxrwt 24 root root 4.0K Nov 26 13:23 ..
    drwxr-xr-x  2 sqz  sqz  4.0K Nov 26 13:22 .hooks
    drwxr-xr-x  7 sqz  sqz  4.0K Nov 26 13:22 .git
    drwxr-xr-x  5 sqz  sqz  4.0K Nov 26 13:22 .
    drwxr-xr-x  2 sqz  sqz  4.0K Nov 26 13:22 test
    -rw-r--r--  1 sqz  sqz     0 Nov 26 13:22 .gitignore
    -rw-r--r--  1 sqz  sqz   123 Nov 26 13:22 README.md
    -rwxr-xr-x  1 sqz  sqz    30 Nov 26 13:22 testrun
    -rw-r--r--  1 sqz  sqz    32 Nov 26 13:22 .travis.yml
    -rw-r--r--  1 sqz  sqz     0 Nov 26 13:22 .vimrc
Allright!

    $ cat ~/.git/config 
      ...
      [remote "origin"]
              url = https://coderofsalvation@bitbucket.org/coderofsalvation/dotfiles.g
      ...

Nice! it added my username.
Otherwise you get the annoying extra username prompt upon pushing.
( I know I should setup ssh, but yolo ).

## Example: language specific

Many times I find myself re-compiling javascript files before committing my coffeescript npm modules.
Specifying a language upon init automates that:

    $ export LANG=coffee
    $ git hooks  # actually 'git i' would work as well since it calls 'git hooks' automatically 
    $ cat .hooks/pre-commit 
    #!/bin/bash
    find . -name "*.coffee" | grep -v node_modules | while read file; do
      echo "compiling ${file/coffee$/js/g}";
      coffee -c "$file"; git add "${file/coffee$/js/}";
    done

## Features / Breakdown

This is just an example of often performed tasks in my repo-setups:

#### init (now 'git i')

* setup an githubrepo (and make sure the 'username@' is in the url)
* setup a README.md with travis badge
* setup a .travis.yml file
* add a .gitignore
* add a 'test' folder
* add a 'testrun' bashscript
* add githooks in '.hooks' (to compile coffeescript to javascript during commits)

#### push (now 'git p')

* push to multiple remotes
* tag/untag with stable/unstable 
* commitmessages containing 'bug fix' or 'work in progress [might break]' or 'refactor'
* publish to npm

## Related

[gitsh](https://github.com/thoughtbot/gitsh) and [git-sh](https://github.com/rtomayko/git-sh) are nice.
(but sometimes a teaspoon of bash will be sufficient)

