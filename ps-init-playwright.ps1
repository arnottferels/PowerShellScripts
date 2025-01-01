<#
    This PowerShell script automates the setup for a Playwright testing project with Prettier formatting.
    Before running, ensure that you have:
    - Node.js and npm installed on your system.
    
    If Node.js and npm are not installed, you can follow these steps:
    1. Download and install Node.js from https://nodejs.org/.
    2. Ensure npm is installed by running: `npm -v`.

    Once Node.js and npm are installed, this script will:
    1. Initialize a new npm project.
    2. Install Playwright and Prettier.
    3. Modify `package.json` to include test scripts.
    4. Create a test file for Playwright.
    5. Format files using Prettier.
    6. Run the Safari test script.

    After running this script, you'll be able to run tests using the provided npm commands.
#>

# Step 1: Ensure Node.js and npm are installed
$nodeInstalled = Get-Command node -ErrorAction SilentlyContinue
$npmInstalled = Get-Command npm -ErrorAction SilentlyContinue

if (-not $nodeInstalled -or -not $npmInstalled) {
  Write-Host "Node.js or npm is not installed. Please install them first from https://nodejs.org/."
  exit 1
}

# Step 2: Initialize a new project inside an empty repository
npm init -y

# Step 3: Install @playwright/test as a development dependency
npm i -D @playwright/test

# Step 4: Install the default browsers
npx playwright install

# Step 5: Install Prettier to format files
npm i -D prettier

# Step 6: Read and modify package.json

$packageJsonPath = "./package.json"
$packageJsonContent = Get-Content $packageJsonPath -Raw | ConvertFrom-Json

# Ensure the 'scripts' section exists and is a hashtable (dictionary)
if (-not $packageJsonContent.PSObject.Properties['scripts']) {
  $packageJsonContent | Add-Member -MemberType NoteProperty -Name 'scripts' -Value @{ }
}

# Convert the scripts section to a hashtable
$scripts = @{ }
foreach ($key in $packageJsonContent.scripts.PSObject.Properties.Name) {
  $scripts[$key] = $packageJsonContent.scripts.$key
}

# Add new test scripts
$scripts['test:chrome'] = 'npx playwright test --headed --browser=chromium'
$scripts['test:firefox'] = 'npx playwright test --headed --browser=firefox'
$scripts['test:safari'] = 'npx playwright test --headed --browser=webkit'

# Reassign the modified scripts back to the packageJsonContent
$packageJsonContent.scripts = $scripts

# Save the updated package.json back to the file
$packageJsonContent | ConvertTo-Json -Depth 4 | Set-Content $packageJsonPath

# Step 7: Ensure the 'tests' directory exists
$testDir = "./tests"
if (-not (Test-Path -Path $testDir)) {
  New-Item -ItemType Directory -Path $testDir
}

# Step 8: Create the test file
$testCode = @"
import { test } from '@playwright/test'

test('test browser', async ({ page }) => {
  await page.goto('http://localhost:4321/')
  await page.pause()
})
"@

# Create the test file in the tests directory
$testCode | Set-Content -Path "$testDir/browser.test.ts"

# Step 9: Create .prettierrc file for Prettier configuration
$prettierConfig = @"
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "all"
}
"@

# Save the .prettierrc file to the root directory
$prettierConfig | Set-Content -Path "./.prettierrc"

# Step 10: Create .gitignore file to ignore node_modules
$gitignoreContent = @"
node_modules/
test-results/
"@

# Save the .gitignore file to the root directory
$gitignoreContent | Set-Content -Path "./.gitignore"

# Step 11: Format the package.json file using Prettier
npx prettier --write $packageJsonPath

# Step 12: Format the test file using Prettier
npx prettier --write "$testDir/browser.test.ts"

# Step 13: Run the Safari test script
npm run test:safari
