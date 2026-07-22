export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/home/cedjuani/.local/bin"

ZSH_THEME="agnoster"

plugins=(
        git
        sudo
        copypath
        zsh-syntax-highlighting
        zsh-interactive-cd
        fzf
        zsh-autocomplete
)

zstyle ':autocomplete:history:*' list-lines 0
zstyle ':autocomplete:*' list-lines 5
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':autocomplete:*' delay 0.25
zstyle ':completion:*:git-*' tag-order 'common-commands'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

source $ZSH/oh-my-zsh.sh

alias start="xdg-open . > /dev/null 2>&1 &"
alias cls="clear"
alias cd="z"
alias ff="clear && fastfetch"
alias nvdot="(z nvim && nvim .)"

alias dirs="ls -l"
alias dirt="lt"
alias dirts="lts"
alias dir="ls -la"

alias ls="eza --icons=always --group-directories-first"
alias ll="eza --icons=always --group-directories-first -la --git"
alias lt="eza --tree --icons=always --tree --level=2 --git"
alias lts="eza --tree --icons=always --tree --level=2 --group-directories-first -la --git"

alias gits="git status"
alias lg="lazygit"
alias glp="git log $branch --pretty=format:'%C(yellow)%h%Creset - %C(green)%an%Creset, $ar : %s'"
alias glt="git log --graph --oneline --all --decorate"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias lzdots="GIT_DIR=$HOME/.cfg GIT_WORK_TREE=$HOME lazygit"

bindkey '^F' fzf-file-widget
bindkey '^T' transpose-chars

ff

export FZF_DEFAULT_OPTS="
  --height 40% 
  --layout=reverse 
  --border 
  --preview 'if [ -d {} ]; then eza --tree --level=2 {} 2>/dev/null || ls {}; else bat --color=always --style=changes {} 2>/dev/null || cat {}; fi' 
  --preview-window=right:60%"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"

    zle reset-prompt
}

zle -N y
bindkey '^Y' y

[ -s "/home/cedjuani/.bun/_bun" ] && source "/home/cedjuani/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/home/cedjuani/.local/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"

bindkey -e
bindkey '^D' delete-char
bindkey '^R' fzf-history-widget

bindkey '\e[A' up-line-or-search
bindkey '\e[B' down-line-or-search
zstyle ':autocomplete:tab:*' insert-unambiguous yes
