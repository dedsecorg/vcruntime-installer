# Create a directory for downloading runtime files
$directory = "$env:USERPROFILE\Downloads\VC_Runtimes"
New-Item -ItemType Directory -Path $directory -Force | Out-Null

# Define URLs for Visual C++ Redistributable Runtime versions
$runtimes = @(
    "https://aka.ms/vs/17/release/vc_redist.x64.exe",
    "https://aka.ms/vs/17/release/vc_redist.x86.exe"
    # Add URLs for other versions here
)

# Download all runtime files
foreach ($url in $runtimes) {
    $fileName = Split-Path $url -Leaf
    $outputPath = Join-Path $directory $fileName
    Invoke-WebRequest -Uri $url -OutFile $outputPath
}

# Silent install all runtimes
foreach ($runtimeFile in Get-ChildItem -Path $directory -Filter "*.exe") {
    Start-Process -FilePath $runtimeFile.FullName -ArgumentList "/quiet /norestart" -Wait
}

# Clean up downloaded files
Remove-Item -Path $directory -Recurse -Force

# Script completed message
Write-Output "Installation of VC++ Redistributable Runtimes completed successfully!"
