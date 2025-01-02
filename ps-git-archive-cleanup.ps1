# ps-git-archive-cleanup.ps1

# Navigate to your Git repository
# Update the path below to point to your local Git repository
cd [path/to/your/repository]

# Get the last commit date
# This retrieves the date of the most recent commit in ISO format.
# This date will be used for the new commit to maintain commit history integrity.
$LAST_COMMIT_DATE = git log -1 --format=%cd --date=iso

# Set environment variables for commit dates
# These environment variables ensure that the new commit uses the same date as the last commit.
# This helps in maintaining a consistent commit timeline.
$env:GIT_COMMITTER_DATE = $LAST_COMMIT_DATE
$env:GIT_AUTHOR_DATE = $LAST_COMMIT_DATE

# Optional: Check if the environment variables are set correctly
# This command displays all environment variables to verify that our dates are set.
Get-ChildItem Env:

# Create a new branch with no history
# This creates an orphan branch named 'main-legacy', which starts with no commit history.
# This is useful for archiving the current state without affecting the main branch.
git checkout --orphan main-legacy

# Stage all files for commit
# This command stages all changes in the working directory, including new, modified, and deleted files,
# preparing them to be included in the next commit.
git add -A

# Commit the changes with the same date as the last commit
# The commit message indicates that this commit serves as an archive of the latest state.
# Using the same date helps preserve the timeline of changes.
git commit --date="$LAST_COMMIT_DATE" -m "Archiving latest state"

# Delete the old main branch
# This command removes the existing 'main' branch from the local repository.
# It's necessary to delete it to replace it with the new archived version.
git branch -D main

# Rename the new branch to 'main'
# This command renames the orphan branch 'main-legacy' to 'main',
# effectively making the archived state the new main branch.
git branch -m main

# Force push to the remote repository
# This command pushes the new 'main' branch to the remote repository, overwriting the old 'main' branch.
# This ensures that the remote reflects the newly archived state.
git push origin main --force

# Cleanup: Remove the environment variables created
# This removes the environment variables used for commit dates to clean up the environment.
Remove-Item Env:GIT_COMMITTER_DATE
Remove-Item Env:GIT_AUTHOR_DATE

# Final check: List remaining environment variables to confirm deletion
# This command displays the current environment variables to verify that the cleanup was successful.
Get-ChildItem Env:
