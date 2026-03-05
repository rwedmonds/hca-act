# ------------------------------------------------------- #
# Set Oh-My-Posh theme 
# ------------------------------------------------------- #
eval "$(oh-my-posh init zsh --config $HOME/.config/zsh/oh-my-posh/themes/stelbent.minimal.omp.json)"

# ------------------------------------------------------- #
# Load aliases file every time I hit Enter
# ------------------------------------------------------- #
precmd() {
  source $HOME/.aliasrc
}

# ------------------------------------------------------- #
# Keybindings
# ------------------------------------------------------- #
bindkey ' ' magic-space # Expand command shortcuts (e.g. !!)
bindkey -s '^Xgc' 'git commit -m ""\C-b' # Execute git commit command and place cursor in quotes

# ------------------------------------------------------- #
# Execute 'll' command after evry 'cd' command
# ------------------------------------------------------- #
chpwd() {
  eza -lahF  --icons --group-directories-first
}

# ------------------------------------------------------- #
# Enable zmv command
# ------------------------------------------------------- #
autoload zmv

# ------------------------------------------------------- #
# Load plugins
# (https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
# ------------------------------------------------------- #
source $HOME/.config/zsh/plugins/virtualenv/virtualenv.plugin.zsh
source $HOME/.config/zsh/plugins/you-should-use/you-should-use.plugin.zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.config/zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/.config/zsh/plugins/python.plugin.zsh
source $HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# ------------------------------------------------------- #
# PATH config
#-------------------------------------------------------- #
export PATH="$PATH:$HOME/.hishtory:/usr/local/bin:/opt/homebrew/bin:/Users/redmonds/Library/Python/3.9/bin:/Applications/WezTerm.app/Contents/MacOS:Users/redmonds/Applications:/Users/redmonds/Documents/Keyboard/qmk_toolchains/qmk_toolchains_macosARM64:/opt/homebrew/Cellar/arm-none-eabi-gcc@8/8.5.0_2:/Users/redmonds/.cargo/bin:~/Github/zclock/zig-out/bin/:/Users/redmonds/dotfiles/nvim/img
"
if command -v python3 > /dev/null; then
  export PATH='python3 -m site --user-base'/bin:$PATH
fi

# ------------------------------------------------------- #
# Start the ssh-agent so ssh passphrases can be cached
#-------------------------------------------------------- #
# eval "$(ssh-agent -s)"
# for file in ~/.ssh/710p-1 ~/.ssh/720xp-1 ~/.ssh/cvp ~/.ssh/docker1 ~/.ssh/eve-labs ~/.ssh/eve-mgmt ~/.ssh/eve-ng ~/.ssh/gitea ~/.ssh/github ~/.ssh/gitlab ~/.ssh/ha ~/.ssh/jumpbox ~/.ssh/office1 ~/.ssh/pfsense ~/.ssh/proxmox1 ~/.ssh/redmonds_openssh_key; do ssh-add "$file"; done

# ------------------------------------------------------- #
# Load nvm bash_completion
#-------------------------------------------------------- #
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ------------------------------------------------------- #
# Initialize fzf
#-------------------------------------------------------- #
eval "$(fzf --zsh)"
enable-fzf-tab

# ------------------------------------------------------- #
# Enable completion styling
#-------------------------------------------------------- #
# Case-insensitve completions
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Colorize completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Disable default ZSH completion menu
zstyle ':completion:*' menu no
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# ------------------------------------------------------- #
# Yazi config
#-------------------------------------------------------- #
export YAZI_CONFIG_HOME="~/.config/yazi"
export EDITOR="/opt/homebrew/bin/nvim"

# Exit Yazi to current directory
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ------------------------------------------------------- #
# Initialize zoxide
#-------------------------------------------------------- #
eval "$(zoxide init zsh)"
# eval "$(zoxide init --cmd cd zsh)"


# ------------------------------------------------------- #
# bat
# ------------------------------------------------------- #
export BAT_THEME=Dracula
# eval "$(bat --export-env)"

# ------------------------------------------------------- #
# bitwarden
# ------------------------------------------------------- #
export NODE_OPTIONS="--no-deprecation"
export BW_SESSION="Ssu/TZenKps+PId+K2fjOpbMnfk3nYJD7eZAPys7dNoot1Cj7Dy54rRRIHiejU3askgB9J5uBG2gV/JZHCzX3w=="

# ------------------------------------------------------- #
#  History
# ------------------------------------------------------- #
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt share_history
setopt hist_verify
setopt combining_chars
setopt extended_glob
setopt dot_glob
setopt
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ------------------------------------------------------- #
# Hishtory Config:
#-------------------------------------------------------- #
export PATH="$PATH:/Users/redmonds/.hishtory"
source /Users/redmonds/.hishtory/config.zsh

# ------------------------------------------------------- #
# Set ZSH command line options
# ------------------------------------------------------- #
setopt CORRECT
# setopt SHIN_STDIN
setopt AUTO_CD
setopt NO_CASE_GLOB
unsetopt PROMPT_SP # don't autoclean blank lines
export XDG_CONFIG_HOME=$HOME/.config

# ------------------------------------------------------- #
# Colored man pages
# ------------------------------------------------------- #
export MANPAGER="less -R --use-color -Dd+r -Du+b"

# ------------------------------------------------------- #
# Janky Borders
# ------------------------------------------------------- #
borders active_color=0xff00ff00 inactive_color=0xffff0000 width=6.0 hidpi=off style=round
borders active_color=0xff00ff00 width=5.0 hidpi=off style=round

if [ -f "/Users/redmonds/.config/fabric/fabric-bootstrap.inc" ]; then . "/Users/redmonds/.config/fabric/fabric-bootstrap.inc"; fi

source /Users/redmonds/.config/broot/launcher/bash/br
# source $HOME/.local/bin/env

alias typr="python3 /src/main.py"
alias typr="python3 /src/main.py"
alias typr="python3 /src/main.py"

. "$HOME/.local/bin/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/redmonds/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/redmonds/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/redmonds/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/redmonds/google-cloud-sdk/completion.zsh.inc'; fi

clear

echo "╔════════════════════════════════╗"
echo "║      _         _     _         ║"
echo "║     / \   _ __(_)___| |_ __ _  ║"
echo "║    / _ \ |  __| / __| __/ _  | ║"
echo "║   / ___ \| |  | \__ \ || (_| | ║"
echo "║  /_/   \_\_|  |_|___/\__\__,_| ║"
echo "║                                ║"
echo "╚════════════════════════════════╝"
