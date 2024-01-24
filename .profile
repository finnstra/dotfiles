# Profile files are usually non-shell-specific logic that you will always need. ZSH stuff goes in .zshrc

# I like nvim, let's use that.
export EDITOR=nvim

# Turn off autocomplete beeps
unsetopt LIST_BEEP

# Enable tab completion
autoload -Uz compinit && compinit

# Alias - Dev
alias cls='clear'
alias tf='terraform'
alias zsh-config="vi ~/.zshrc"
alias v='nvim'