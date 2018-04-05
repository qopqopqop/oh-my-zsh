export LESS="-r -X"

function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}
