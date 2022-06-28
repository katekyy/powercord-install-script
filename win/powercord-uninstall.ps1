$build = "v005"
$base_location = Get-Location

#Requires -RunAsAdministrator

####

if (!(Test-Path -Path "C:\discord-canary") -Or !(Test-Path -Path "C:\Users\$env:USERNAME\AppData\Roaming\powercord_installer\instance_*-*")) {
    Write-Host "Powercord Instalation not found." -ForegroundColor red
    Write-Host "You can install it using './powercord-install.ps1' [8x00101]" -ForegroundColor red
    Sleep -s 1
    Exit 1
}

if (Get-Process "DiscordCanary" -ErrorAction SilentlyContinue) {
    Write-Host "Killing all Discord instances..." -ForegroundColor blue
    Stop-Process -Name "DiscordCanary" -Force | Out-Null
}

cd "C:\discord-canary\powercord"

Start-Sleep -s 1
Write-Host "Trying to unplug existing Powercord..." -ForegroundColor blue
try {
    npm run unplug | Out-Null
} catch 
{
    Write-Host "Failed to unplug Discord. [8x00011]" -ForegroundColor red
    Write-Host "Exiting..." -ForegroundColor red
    Exit 1
}

cd $base_location

try {
    Remove-Item -Path "C:\discord-canary" -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
} catch {
    Write-Host "Error removing Powercord installation. At 'C:\discord-canary' [8x00110]" -ForegroundColor red
}

try {
    Remove-Item -Path "C:\Users\$env:USERNAME\AppData\Roaming\powercord_installer\instance_*-*" -Force -Recurse -ErrorAction SilentlyContinue | Out-Null
} catch {
    Write-Host "Error removing Powercord Installer instance. [8x00111]" -ForegroundColor red
}

Write-Host "Starting Discord Canary..." -ForegroundColor blue
Invoke-Expression "C:\Users\$env:USERNAME\AppData\Local\DiscordCanary\app-*\DiscordCanary.exe" | Out-Null

Start-Sleep -s 2
Write-Host "Done! [8x00000]" -ForegroundColor green
Exit 0