$DownloadPath = "C:\temp"
if (!(Test-Path $DownloadPath)) { New-Item -ItemType Directory -Path $DownloadPath -Force }

# Скачиваем стабильную версию Chrome
$downloadUrl = "https://dl.google.com/tag/s/dl/chrome/install/GoogleChromeStandaloneEnterprise64.msi"
$localFile = "$DownloadPath\GoogleChromeStandaloneEnterprise64.msi"

Invoke-WebRequest -Uri $downloadUrl -OutFile $localFile
Write-Host "Downloaded: $localFile"