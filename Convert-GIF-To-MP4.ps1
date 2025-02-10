<#
  Script: Convert-GIF-To-MP4.ps1
  Purpose: Converts all GIF files in specified folders to MP4 format using FFmpeg.
  Dependencies: FFmpeg must be installed and accessible in system PATH.
#>

# Define folders containing GIF files
$folders = @(
    "folder_1",
    "folder_2",
    "folder_3",
    "folder_4"
)

# Convert GIFs to MP4 format using FFmpeg
foreach ($folder in $folders) {
    $files = Get-ChildItem -Path $folder -Filter "*.gif"

    foreach ($file in $files) {
        # Set output file path with .mp4 extension
        $outputFile = [System.IO.Path]::ChangeExtension($file.FullName, ".mp4")

        # Run FFmpeg to convert GIF to MP4 (H.264)
        ffmpeg -i $file.FullName -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" `
               -c:v libx264 -preset slow -crf 23 -pix_fmt yuv420p `
               -movflags +faststart -an $outputFile
    }
}
