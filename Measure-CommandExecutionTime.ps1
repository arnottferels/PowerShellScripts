<##
    This PowerShell script measures the execution time of a specified command.

    Steps:
    1. Declare the command you want to run (e.g., 'npm run test').
    2. Capture the start time before running the command.
    3. Execute the command using `Invoke-Expression`.
    4. Capture the end time after the command completes.
    5. Calculate the elapsed time by subtracting the start time from the end time.
    6. Display the start time, end time, and elapsed time in a readable format.

    The times are displayed with the following colors:
    - Start and End times are shown in cyan.
    - Elapsed time is shown in green.
##>

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
