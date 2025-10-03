$DownloadPath = "C:\temp"
if (!(Test-Path $DownloadPath)) { New-Item -ItemType Directory -Path $DownloadPath -Force }

# Get information about Adobe Reader from Chocolatey
$url = "https://community.chocolatey.org/packages/adobereader"
$html = Invoke-WebRequest -Uri $url -Method Get -ContentType "text/plain; charset=utf-8" -UseBasicParsing

# Find version in html code
$pattern = '<h1[^>]*id="packageName"[^>]*>[\s\S]*?Adobe Acrobat Reader DC[\s\S]*?(\d{4}\.\d+\.\d+)'
$match = [regex]::Match($html.Content, $pattern)

if ($match.Success){
    $version = $match.Groups[1].Value
    Write-Host "Last version of Adobe Reader: $version" -ForegroundColor Green
    
    # Create clean version
    $parts = $version.Split('.')
    $year = $parts[0]     # 2025
    $minor = $parts[1].PadLeft(3, '0')  # 1 → 001
    $build = $parts[2]    # 20756
    $cleanVersion = $year.Substring(2, 2) + $minor + $build  # 2500120756
	
	Write-Host "Version: $year.$minor.$build" -ForegroundColor Green
    Write-Host "Version to download: $cleanVersion" -ForegroundColor Yellow

	$DownloadUrl = "https://ardownload3.adobe.com/pub/adobe/acrobat/win/AcrobatDC/${cleanVersion}/AcroRdrDCx64${cleanVersion}_MUI.exe"
    $LocalFile = "$DownloadPath\AcroRdrDCx64${cleanVersion}_MUI.exe"

    Write-Host "download: $DownloadUrl"
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $LocalFile
    Write-Host "Downloaded successfully: $LocalFile" -ForegroundColor Green
}
else {
    Write-Host "Version has not found" -ForegroundColor Red
}