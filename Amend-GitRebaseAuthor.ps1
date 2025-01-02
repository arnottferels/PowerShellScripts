<#
    Amends the author information (name, email, and date) for the current commit during a Git rebase.
#>

# Set new author info
$authorName = "arnottferels"
$authorEmail = "64685389+arnottferels@users.noreply.github.com"

# Preserve author date
$authorDate = git show --no-patch --no-notes --pretty="%aD"
$env:GIT_COMMITTER_DATE = $authorDate

# Amend commit with new author info (name, email) and preserved author date
git commit --amend --no-edit --author="$authorName <$authorEmail>" --date="$authorDate"

# Continue rebase
git rebase --continue
