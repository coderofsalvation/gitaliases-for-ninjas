git_alias(){
  [[ "$1" == "init" ]] && echo "please use 'git i'" && return 0
  [[ "$1" == "push" ]] && echo "please use 'git p'" && return 0
  \git "$@"
}
alias git='git_alias'

