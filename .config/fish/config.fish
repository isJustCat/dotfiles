abbr g git
abbr gst 'git status'
abbr gco 'git checkout'
abbr gd 'git diff'
abbr gl 'git log'
abbr gsac 'git stage --all && git commit -m'
abbr gcm 'git commit -m'
abbr gcam 'git commit --ammend -m'
abbr gapa 'git add --patch'
abbr gau 'git add --update'
abbr grm 'git rm'
abbr grmc 'git rm --cached'
abbr grs 'git restore'
abbr grss 'git restore --source'
abbr grst 'git restore --staged'
abbr gsta 'git stash'
abbr gstd 'git stash drop'
abbr gstl 'git stash list'
abbr gsts 'git stash show --text'
abbr gbr 'git branch'
abbr gpl 'git pull'
abbr gts 'git tag -s'
abbr gps 'git push'
abbr gup 'git fetch --all && git pull'
abbr gcl 'git clone'
abbr gcp 'git cherry-pick'
abbr gcpn 'git cherry-pick --no-commit'
abbr grb 'git rebase'
abbr grbi 'git rebase -i'
abbr grba 'git rebase --abort'
abbr grbc 'git rebase --continue'
abbr grbs 'git rebase --skip'
abbr gmr 'git merge'
abbr gma 'git merge --abort'
abbr gmc 'git merge --continue'
abbr gpo 'git push origin'
abbr gpom 'git push origin main'
abbr gplom 'git pull origin main'
abbr gpos 'git push origin $(git symbolic-ref --short HEAD)'
abbr gplos 'git pull origin $(git symbolic-ref --short HEAD)'
abbr gpf 'git push --force'
abbr gpfu 'git push --force-with-lease'
abbr gpt 'git push --tags'
abbr gptf 'git push --force --tags'
abbr gfa 'git fetch --all'
abbr gfc 'git fetch --prune'
abbr glg 'git log --oneline --graph --decorate --all'

abbr _ sudo
abbr hx helix

thefuck --alias | source
export EDITOR="helix"

# Created by `pipx` on 2025-01-16 21:56:49
set PATH $PATH /home/poly/.local/bin

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias mixxx='flatpak run org.mixxx.Mixxx'
