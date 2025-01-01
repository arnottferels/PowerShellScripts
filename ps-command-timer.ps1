# 1. Declare the command to run
$command = 'npm run test'

# 2. Get start time
$startTime = Get-Date
Write-Host "Start Time   : $startTime"

# 3. Run the command
Invoke-Expression $command

# 4. Get end time
$endTime = Get-Date

# 5. Calculate elapsed time
$elapsedTime = $endTime - $startTime

# 6. Write the result
Write-Host "----------------------------------"
Write-Host "Start Time   : " -NoNewline; Write-Host $startTime -ForegroundColor cyan
Write-Host "End Time     : " -NoNewline; Write-Host $endTime -ForegroundColor cyan
Write-Host "Elapsed Time : " -NoNewline; Write-Host $elapsedTime -ForegroundColor Green
Write-Host "----------------------------------"
