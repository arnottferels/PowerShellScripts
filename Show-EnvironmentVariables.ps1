<#
    Displays all environment variables and filters to show only Git-related ones.
#>

# Display all environment variables
Get-ChildItem Env:

# Display only Git-related environment variables
Get-ChildItem Env: | Where-Object { $_.Name -match "^GIT" }