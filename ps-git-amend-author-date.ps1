# ps-git-amend-author-date.ps1
# Updates the author date for the current commit in a Git rebase without modifying the author name or email.

while ($true) {
  # Preserve author date
  $authorDate = git show --no-patch --no-notes --pretty="%aD"
  $env:GIT_COMMITTER_DATE = $authorDate

  # Amend commit with preserved author date (no change to author name/email)
  git commit --amend --no-edit --date="$authorDate"

  # Continue rebase
  git rebase --continue
}