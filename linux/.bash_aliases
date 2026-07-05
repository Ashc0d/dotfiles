# alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias mkcd='mkcd_alias() { mkdir -p "$1" && cd "$1"; }; mkcd_alias'
alias ffile='find . | grep '
alias fhis='history | grep '
alias si="du -sh ."
alias siall="du -sh *"

if command -v eza &> /dev/null; then
    alias ll="eza -al"
else
    alias ll="ls -alF"
fi
