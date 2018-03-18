export LESS="-r -X"

function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

function brewu () {
    brew update

    for v in 54 55 56 70 71; do brew unlink php$v; done

    for php in `brew outdated | egrep 'php\d{2}-(imagick|intl)' | sed -r 's#^.+php/(php[0-9]+).+#\1#' | uniq`; do
        brew link $php
        brew reinstall -s ${php}-imagick
        brew reinstall -s ${php}-intl
        brew unlink $php
    done

    brew link php71

    brew upgrade
    brew prune
    brew doctor
}
