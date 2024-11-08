# ps-git-log-commit-info.ps1
# Displays detailed commit information, including commit hash, commit date, author date, and commit message.
# - Commit hash is shown in yellow
# - Commit date is shown in cyan
# - Author date is shown in magenta
# - Commit message is shown in green

git log --format="%C(yellow)%h%C(reset) | Commit Date: %C(cyan)%cD%C(reset) Author Date: %C(magenta)%aD%C(reset) Message: %C(green)%s%C(reset)"