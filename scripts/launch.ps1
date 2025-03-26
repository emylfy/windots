$tempPath = "$env:TEMP\windots"
$zipPath = "$tempPath\windots.zip"

if (!(Test-Path $tempPath)) {
    New-Item -ItemType Directory -Path $tempPath | Out-Null
}

try {
    Add-MpPreference -ExclusionPath $tempPath -ErrorAction SilentlyContinue
} catch {
    Write-Host "Note: Running without admin rights, continuing normally..." -ForegroundColor Yellow
}

Write-Host "Downloading Windots..." -ForegroundColor Cyan
Write-Progress -Activity "Downloading Windots" -Status "Initializing..." -PercentComplete 0

try {
    Start-BitsTransfer -Source "https://github.com/emylfy/windots/archive/refs/heads/main.zip" `
                      -Destination $zipPath `
                      -DisplayName "Downloading Windots" `
                      -Description "Downloading required files..."

    Write-Progress -Activity "Downloading Windots" -Status "Complete" -PercentComplete 100
    Write-Host "Download complete!" -ForegroundColor Green
    
    Write-Host "Extracting files..." -ForegroundColor Cyan
    Write-Progress -Activity "Installing Windots" -Status "Extracting..." -PercentComplete 50

    Expand-Archive -Path $zipPath -DestinationPath $tempPath -Force

    Write-Progress -Activity "Installing Windots" -Status "Complete" -PercentComplete 100

    Write-Host @"
         _         _     _      
 __ __ _(_)_ _  __| |___| |_ ___
 \ V  V / | ' \/ _` / _ \  _(_-<
  \_/\_/|_|_||_\__,_\___/\__/__/
                                
"@ -ForegroundColor Cyan

    Start-Sleep -Seconds 1
    
    $psScriptPath = "$tempPath\windots-main\windots.ps1"
    
    if (!(Test-Path $psScriptPath)) {
        Write-Host "Error: Could not find windots.ps1 at $psScriptPath" -ForegroundColor Red
        Write-Host "Contents of $tempPath\windots-main:" -ForegroundColor Yellow
        Get-ChildItem "$tempPath\windots-main" | Format-Table -AutoSize
        Start-Sleep -Seconds 5
        exit
    }
    
    if (Get-Command wt -ErrorAction SilentlyContinue) {
        wt -d "$tempPath\windots-main" powershell -ExecutionPolicy Bypass -File "$psScriptPath"
    } else {
        powershell.exe -ExecutionPolicy Bypass -File "$psScriptPath"
    }
}
catch {
    Write-Progress -Activity "Installing Windots" -Status "Error" -PercentComplete 100
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host "Please download manually from: https://github.com/emylfy/windots" -ForegroundColor Yellow
    Start-Sleep -Seconds 5
}
finally {
    Write-Progress -Activity "Installing Windots" -Completed
}