<# 
    This script automates the process of setting up a GitHub Pages repository.
    It creates a new directory for the repository, initializes a Git repository,
    creates an empty commit, sets up the 'main' and 'gh-pages' branches, 
    and pushes these branches to GitHub.

    Steps:
    Step 1: Create a directory for the repository and navigate to it.
    Step 2: Initialize a new Git repository.
    Step 3: Create an empty commit to initialize the repository.
    Step 4: Rename the default branch to 'main'.
    Step 5: Add a remote GitHub repository.
    Step 6: Push the 'main' branch to the remote repository.
    Step 7: Create and switch to the 'gh-pages' branch.
    Step 8: Push the 'gh-pages' branch to the remote repository.
    Step 9: Confirm successful setup of the GitHub Pages repository.
#>

# Variables (Update these before running)
$RepoName = "arnottferels.github.io"
$GitHubUsername = "arnottferels"

# Step 1: Create and navigate to the new directory
Write-Host "> Step 1: Creating the directory for the repository." -ForegroundColor Magenta
mkdir $RepoName
if ($?) {
    Set-Location $RepoName
    if (!$?) {
        Write-Host "> Failed to navigate to the directory." -ForegroundColor Red
        exit 1
    }
    Write-Host "> Directory '$RepoName' created and navigated to." -ForegroundColor Green
} else {
    Write-Host "> Failed to create the directory." -ForegroundColor Red
    exit 1
}

# Step 2: Initialize a new Git repository
Write-Host "> Step 2: Initializing the Git repository." -ForegroundColor Magenta
git init
if (!$?) {
    Write-Host "> Failed to initialize Git repository." -ForegroundColor Red
    exit 1
}
Write-Host "> Git repository initialized." -ForegroundColor Green

# Step 3: Create an empty commit
Write-Host "> Step 3: Creating an empty commit." -ForegroundColor Magenta
git commit --allow-empty --allow-empty-message --no-edit
if (!$?) {
    Write-Host "> Commit failed." -ForegroundColor Red
    exit 1
}
Write-Host "> Empty commit created." -ForegroundColor Green

# Step 4: Rename the default branch to 'main'
Write-Host "> Step 4: Renaming the default branch to 'main'." -ForegroundColor Magenta
git branch -M main
if (!$?) {
    Write-Host "> Failed to rename branch." -ForegroundColor Red
    exit 1
}
Write-Host "> Branch renamed to 'main'." -ForegroundColor Green

# Step 5: Add the remote repository
Write-Host "> Step 5: Adding the remote GitHub repository." -ForegroundColor Magenta
$RemoteUrl = "https://github.com/$GitHubUsername/$RepoName.git"
git remote add origin $RemoteUrl
if (!$?) {
    Write-Host "> Failed to add remote repository." -ForegroundColor Red
    exit 1
}
Write-Host "> Remote repository added: $RemoteUrl." -ForegroundColor Green

# Step 6: Push the 'main' branch to the remote repository
Write-Host "> Step 6: Pushing the 'main' branch to GitHub." -ForegroundColor Magenta
git push -u origin main
if (!$?) {
    Write-Host "> Failed to push 'main' branch." -ForegroundColor Red
    exit 1
}
Write-Host "> Main branch pushed to remote repository." -ForegroundColor Green

# Step 7: Create and switch to the 'gh-pages' branch
Write-Host "> Step 7: Creating and switching to the 'gh-pages' branch." -ForegroundColor Magenta
git checkout -b gh-pages
if (!$?) {
    Write-Host "> Failed to switch to 'gh-pages' branch." -ForegroundColor Red
    exit 1
}
Write-Host "> Switched to 'gh-pages' branch." -ForegroundColor Green

# Step 8: Push the 'gh-pages' branch to the remote repository
Write-Host "> Step 8: Pushing the 'gh-pages' branch to GitHub." -ForegroundColor Magenta
git push -u origin gh-pages
if (!$?) {
    Write-Host "> Failed to push 'gh-pages' branch." -ForegroundColor Red
    exit 1
}
Write-Host "> 'gh-pages' branch pushed to remote repository." -ForegroundColor Green

# Step 9: Confirm successful setup
Write-Host "✓" -ForegroundColor Green -NoNewline
Write-Host " GitHub Pages repository '$RepoName' set up successfully." -ForegroundColor Magenta
