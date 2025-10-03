# Минимальный скрипт для загрузки последней версии 7-Zip
$DownloadPath = "C:\temp"

# Создаем папку если нет
if (!(Test-Path $DownloadPath)) { New-Item -ItemType Directory -Path $DownloadPath -Force }

# Получаем страницу загрузки
$html = Invoke-WebRequest -Uri "https://www.7-zip.org/download.html" -UseBasicParsing

# Ищем ссылку на последнюю x64 версию (первое совпадение)
$downloadLink = $html.Links | Where-Object href -match 'a/7z\d+-x64\.exe' | Select-Object -First 1

# Формируем полный URL и скачиваем
$downloadUrl = "https://www.7-zip.org/" + $downloadLink.href
$fileName = $downloadLink.href.Replace("a/", "")
$localFile = "$DownloadPath\$fileName"

Invoke-WebRequest -Uri $downloadUrl -OutFile $localFile
Write-Host "Downloaded: $localFile"