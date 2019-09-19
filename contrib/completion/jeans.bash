# jeans autocomplete for bash
#
# A complete rip off of the example code found here
#
#   https://www.tldp.org/LDP/abs/html/tabexpansion.html
#

_jeans() {
  local cur
  local generated_matches

  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}

  generated_matches=$(./jeans complete $cur)
  COMPREPLY=( $( compgen -W "$generated_matches" -- $cur ) )

  return 0
}

complete -F _jeans -o filenames jeans
