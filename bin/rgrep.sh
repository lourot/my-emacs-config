# See
# * http://blog.rtwilson.com/how-to-fix-warning-terminal-is-not-fully-functional-error-on-windows-with-cygwinmsysgit/
# * https://askubuntu.com/questions/920908/what-does-export-term-linux-actually-do-when-inside-a-script
export TERM=linux

(set -x; git grep --untracked -n "$@")
code=$?
printf "\n\n\n\n\n"

if [ "$code" -eq "0" ]; then
  (set -x; git grep --recurse-submodules -n "$@")
  printf "\n\n\n\n\n"
else
  (set -x; git grep --no-index --exclude-standard -n "$@")
  printf "\n\n\n\n\n"
fi
