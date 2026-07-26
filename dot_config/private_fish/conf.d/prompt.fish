set fish_greeting

if type -q starship
    starship init fish | source
    enable_transience
end
