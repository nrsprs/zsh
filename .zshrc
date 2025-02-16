# Z Shell config:

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Source zshell autocomplete:
source ~/workspaces/zsh_scripts/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# zsh autocomplete keybinds: 
bindkey              '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete

# cmd + backspace:
bindkey "^X\\x7f" backward-kill-line

# Add python venv to prompt:
function venv_name() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "($(basename $VIRTUAL_ENV)) "
  fi
}

# Add git branch to prompt:
parse_git_branch() {
  local branch=""
  branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  local git_status=$(git status --porcelain 2>/dev/null)
  local color=green
  if echo "$git_status" | grep -q "^ M"; then
    color=yellow
    branch="${branch}*"
  fi
  if echo "$git_status" | grep -qE "^ A|^\?\?"; then
    color=yellow
    branch="${branch}+"
  fi
  if echo "$git_status" | grep -q "^ D"; then
    color=yellow
    branch="${branch}-"
  fi

  if [[ -n "$branch" ]]; then
    branch="[%F{${color}}${branch}%F{reset}] "
  fi
  echo "$branch"
}
update_prompt() {
    PROMPT="$(venv_name)$(parse_git_branch)%B%F{40}%n%f%b%B%F{40}@%f%b%B%F{40}%m%f%b%F{74} /%f%F{74}%1~%f > "
}
precmd_functions+=(update_prompt)
#force_color_prompt=yes
#color_prompt=yes
update_prompt

# Username highlight:
#PROMPT="%B%F{40}%n%f%b%B%F{40}@%f%b%B%F{40}%m%f%b%F{74} /%f%F{74}%1~%f > "
PROMPT="$(parse_git_branch) %B%F{40}%n%f%b%B%F{40}@%f%b%B%F{40}%m%f%b%F{74} /%f%F{74}%1~%f > "

# Set the editor to always use nano instead of vim:
export EDITOR=nano
export VISUAL="$EDITOR"

# Link nano 8.0:
alias nano='/usr/local/Cellar/nano/8.0/bin/nano -m'

# Alias python
alias python='python3'
alias py='python3'

# Alias l to extended details:
alias l='ls -alhF'
alias ls='ls -F'

# Alias ~/.zshrc
alias nzsh="nano ~/.zshrc"
alias szsh="source ~/.zshrc"

# Alias network ip to get wireless network address:
alias networkip='dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com'

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Run fastfetch on shell start:
fastfetch

# Spicetify setup:
#export PATH=$PATH:/Users/nick/.spicetify
#spicetify refresh
#spicetify backup apply

# Alias cat to bat:
alias cat="bat"

# Add bin to path:
export PATH="/usr/local/bin:$PATH"

# port_cassini command:
alias port_cassini="sh ~/workspaces/zsh_scripts/ssh_cassini.sh &"

# source esp idf & add IDF_PATH env var:
alias espidf="source $HOME/workspaces/esp-idf/export.sh"
export IDF_TOOLS_PATH="$HOME/workspaces/esp-idf/tools"
export IDF_PATH="$HOME/workspaces/esp-idf"
#export IDF_PATH="$HOME/.platformio/packages/framework-espidf"
#export IDF_TOOLS_PATH="$HOME/.platformio/packages/framework-espidf/tools"
