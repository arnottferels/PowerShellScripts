<# 
    Displays detailed commit information, including commit hash, dates, author details, and commit message.
    - Commit hash is shown in yellow
    - Commit date is shown in cyan
    - Author date is shown in magenta
    - Author name and email are shown in blue
    - Commit message is shown in green
#>

git log --format="%C(yellow)%h%C(reset) | Commit Date: %C(cyan)%cD%C(reset) Author Date: %C(magenta)%aD%C(reset) | Author Name: %C(blue)%an%C(reset) | Author Email: %C(blue)%ae%C(reset) | Message: %C(green)%s%C(reset)"