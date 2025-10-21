. ./scripts/info.sh

# Git aliases
git config --global alias.co "checkout"
git config --global alias.ci "commit"
git config --global alias.br "branch"
git config --global alias.st "status"
git config --global alias.lg "log --decorate --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.wip "!git add -A; git ls-files --deleted -z | xargs -0 git rm; git commit -m \"wip\""
git config --global alias.unwip "!git log -n 1 | grep -q -c wip && git reset HEAD~1"
git config --global alias.rb "rebase"
git config --global alias.nuke "!git clean -df && git reset --hard"
git config --global alias.unstage "git restore --staged"

# Push default behavior
git config --global push.default "current"

# Credential helper
git config --global credential.helper "osxkeychain"

# Core settings
git config --global core.pager "less -R"

# User settings
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
