<#
  Script: Convert-GIF-To-WebM.ps1
  Purpose: Converts all GIF files in specified folders to WebM format using FFmpeg.
  Dependencies: FFmpeg must be installed and accessible in system PATH.
#>

# Define folders containing GIF files
$folders = @(
    "folder_1",
    "folder_2",
    "folder_3",
    "folder_4"
)

# Convert GIFs to WebM format using FFmpeg
foreach ($folder in $folders) {
    $files = Get-ChildItem -Path $folder -Filter "*.gif"

    foreach ($file in $files) {
        # Set output file path with .webm extension
        $outputFile = [System.IO.Path]::ChangeExtension($file.FullName, ".webm")

        # Run FFmpeg to convert GIF to WebM (VP9)
        ffmpeg -y -i $file.FullName -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" `
               -c:v libvpx-vp9 -crf 30 -b:v 0 -pix_fmt yuv420p -an $outputFile
    }
}
