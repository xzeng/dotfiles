PS1='\u@\h \w \$ '
reduce-path() {
   local path=${1-$PWD} target=${2-33} IFS=/
   [[ "$path" =~ ^$HOME(/|$) ]] && path="~${path#$HOME}"
   [[ ${#path} -le $target ]] && echo "$path" && return
   local order=$((i=0; for e in $path; do echo ${#e} $i; ((i++)); done) |
       head -n-1 | sort -rn | cut -d " " -f 2)
   local elements=($path)
   IFS=$'\n'
   for i in $order; do
       elements[i]=${elements[i]:0:1}
       IFS=/
       path="${elements[*]}"
       [[ ${#path} -le $target ]] && echo "$path" && return
   done
   echo "${path:0:target/2}~${path: -target/2}"
}
PROMPT_COMMAND=PROMPT_COMMAND; PROMPT_COMMAND() {
   local retval=$?
   local path=$(reduce-path)
   local n=$(ls -A1 | wc -l)
   local b=$(git branch 2>/dev/null | sed 's/^\* \(.*\)/\1/p;d')
   PS1="\[\e[01;32m\]\u@\h\[\e[00m\] "
   if [ "$TERM" = "xterm" ]; then
       PS1+="\[\e]2;\u@\H \w\a\]"
   fi
   if [ -n "$b" ]; then
       PS1+="\[\e[01;33m\][$b]\[\e[00m\] "
   fi
   PS1+="\[\e[01;34m\]$path\[\e[00m\] "
   if [ "$retval" -ne 0 ]; then
       PS1+="\[\e[01;31m\]¡$retval!\[\e[00m\] "
   fi
   PS1+="\\\$ "
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias vim='mvim -v'
