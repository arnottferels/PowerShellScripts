<#
    Archives the latest state of a Git repository by creating an orphan branch with the same commit date as the last commit.
    - Creates an orphan branch.
    - Stages and commits all changes with the same date as the last commit.
    - Replaces the old 'main' branch with the new archived state.
#>

# Navigate to your Git repository
cd [path/to/your/repository]

# Get the last commit date
$LAST_COMMIT_DATE = git log -1 --format=%cd --date=iso

# Set environment variables for commit dates
$env:GIT_COMMITTER_DATE = $LAST_COMMIT_DATE
$env:GIT_AUTHOR_DATE = $LAST_COMMIT_DATE

# Optional: Check if the environment variables are set correctly
Get-ChildItem Env:

# Create a new branch with no history
git checkout --orphan main-legacy

# Stage all files for commit
git add -A

# Commit the changes with the same date as the last commit
git commit --date="$LAST_COMMIT_DATE" -m "Archiving latest state"

# Delete the old main branch
git branch -D main

# Rename the new branch to 'main'
git branch -m main

# Force push to the remote repository
git push origin main --force

# Cleanup: Remove the environment variables created
Remove-Item Env:GIT_COMMITTER_DATE
Remove-Item Env:GIT_AUTHOR_DATE

# Final check: List remaining environment variables to confirm deletion
Get-ChildItem Env:
