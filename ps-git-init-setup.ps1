# ps-git-init-setup.ps1

# Navigate to the desired directory for the new Git repository
# Update the path below to point to your desired local directory
cd [path/to/your/directory]

# Initialize a new Git repository
# This command creates a new Git repository in the current directory.
git init

# Create an empty commit
# This command creates an empty commit with no message.
# The --allow-empty flag allows the creation of a commit without any changes, 
# and --allow-empty-message allows an empty commit message.
git commit --allow-empty --allow-empty-message -m ""

# Rename the default branch to 'main'
# This command renames the default branch from 'master' (or whatever it may be) to 'main'.
git branch -M main

# Add a remote repository
# Update the URL below with your GitHub repository link.
# Example: https://github.com/username/repo.git
# In this case, the repository is: https://github.com/arnottferels/arnottferels.github.io.git
git remote add origin https://github.com/arnottferels/arnottferels.github.io.git

# Push the 'main' branch to the remote repository
# This command pushes the 'main' branch to the remote repository and sets the upstream tracking.
git push -u origin main

# Create and switch to a new branch 'gh-pages'
# This command creates a new branch named 'gh-pages' and switches to it.
git checkout -b gh-pages

# Push the 'gh-pages' branch to the remote repository
# This command pushes the 'gh-pages' branch to the remote repository and sets the upstream tracking.
git push -u origin gh-pages
