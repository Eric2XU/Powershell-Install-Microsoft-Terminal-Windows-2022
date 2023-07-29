###############################################################
# Install Windows Terminal on Server 2022
# Writen for PowerShell Core (remove lines 7-9 for Windows PS)
###############################################################

# PowerShell Core Preflight (remove if Windows PowerShell)
Install-Module WindowsCompatibility -Force
Import-Module WindowsCompatibility
Import-WinModule AppX

#################
# Pre-Req: Microsoft.UI.Xaml (note it only works with 2.7 while writing this)
# Download Microsoft.UI.Xaml
$RepoName = "microsoft/microsoft-ui-xaml"
$APIUrl = "https://api.github.com/repos/$repoName/releases/tags/v2.7.3"
$assets = (Invoke-WebRequest $APIUrl | ConvertFrom-Json).assets
$asset = $assets | ? {$_.Name -like "*x64.appx"}
$DownloadURL = $asset | select -ExpandProperty browser_download_url
$DownloadPath = "$env:USERPROFILE\Downloads\$($asset.Name)"
Invoke-WebRequest -Uri $DownloadURL -OutFile $DownloadPath

# Install Microsoft.UI.Xaml
Add-AppxPackage -Path $DownloadPath

##################
# Download and isntall Windows Terminal
# Download Windows Terminal
$RepoName = "microsoft/terminal"
$APIUrl = "https://api.github.com/repos/$repoName/releases/latest"
$assets = (Invoke-WebRequest $APIUrl | ConvertFrom-Json).assets
$asset = $assets | ? {$_.Name -like "*_8wekyb3d8bbwe.msixbundle"} 
$DownloadURL = $asset | select -ExpandProperty browser_download_url
$DownloadPath = "$env:USERPROFILE\Downloads\$($asset.Name)"
Invoke-WebRequest -Uri $DownloadURL -OutFile $DownloadPath

#Install Windows Terminal
Add-AppxPackage -Path $DownloadPath
