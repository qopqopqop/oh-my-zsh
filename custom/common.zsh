export LESS="-r -X"

function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

function brewu () {
    brew update

    for php in `brew outdated | egrep 'php\d{2}-(imagick|intl)' | sed -r 's#^.+php/(php[0-9]+).+#\1#' | uniq`; do
        brew reinstall -s ${php}-imagick
        brew reinstall -s ${php}-intl
    done

    brew upgrade
    brew prune
    brew doctor
}
