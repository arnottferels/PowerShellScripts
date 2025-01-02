<#
    Automates updating author information (name, email, and date) during a Git rebase by amending each commit.
#>

$authorName = "arnottferels"
$authorEmail = "64685389+arnottferels@users.noreply.github.com"

# Flag to track if the rebase is completed
while ($true) {
  # Preserve author date
  $authorDate = git show --no-patch --no-notes --pretty="%aD"
  $env:GIT_COMMITTER_DATE = $authorDate

  # Amend commit with new author info (name, email) and preserved author date
  git commit --amend --no-edit --author="$authorName <$authorEmail>" --date="$authorDate"

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
