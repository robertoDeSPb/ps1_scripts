$DownloadPath = "C:\temp"
if (!(Test-Path $DownloadPath)) { New-Item -ItemType Directory -Path $DownloadPath -Force }

# Получаем страницу загрузки
$html = Invoke-WebRequest -Uri "https://codecguide.com/download_k-lite_codec_pack_full.htm" -UseBasicParsing

# Ищем ссылку на Basic версию
$downloadLink = $html.Links | Where-Object href -match 'https://files.*codecguide.com/.*_Full\.exe' | Select-Object -First 1

$localFile = "$DownloadPath\K-Lite_Codec_Pack_Full.exe"
Invoke-WebRequest -Uri $downloadLink.href -OutFile $localFile
Write-Host "Downloaded: $localFile"