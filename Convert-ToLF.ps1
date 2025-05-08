Get-ChildItem -Recurse -Filter *.tex | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $content = $content -replace "`r`n", "`n"  # Replace CRLF with LF
    Set-Content $_.FullName -Value $content -Force
}
