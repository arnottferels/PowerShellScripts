# ps-git-amend-author-date-rebase.ps1
# Automates updating the author date during a Git rebase without changing the author name or email.

while ($true) {
  # Preserve author date
  $authorDate = git show --no-patch --no-notes --pretty="%aD"
  $env:GIT_COMMITTER_DATE = $authorDate

  # Amend commit with preserved author date (no change to author name/email)
  git commit --amend --no-edit --date="$authorDate"

  # Try to continue rebase
  $rebaseResult = git rebase --continue 2>&1

  # Check if "fatal: no rebase in progress" is in the output
  if ($rebaseResult -match "fatal: no rebase in progress") {
    Write-Host "No rebase in progress, exiting." -ForegroundColor Red
    break
  }

  # Optional pause
  Start-Sleep -Milliseconds 500
}