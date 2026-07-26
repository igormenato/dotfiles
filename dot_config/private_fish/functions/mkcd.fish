function mkcd --description "Create a directory and cd into it"
    if not set -q argv[1]
        echo >&2 "usage: mkcd <directory>"
        return 1
    end
    if set -q argv[2]
        echo >&2 "mkcd: too many arguments (use / to nest paths)"
        return 1
    end

    mkdir -p -- $argv[1] && cd -- $argv[1]
end
