$build = "v005"
$base_location = Get-Location

#Requires -RunAsAdministrator

####

if (Test-Path -Path "C:\Users\$env:USERNAME\AppData\Roaming\powercord_installer\instance_*-*")
{
    Write-Host "Powercord Installer instance file located. Please uninstall powercord with:" -ForegroundColor red
    Write-Host "'.\powercord-uninstall.ps1' [8x00001]" -ForegroundColor red
    Write-Host "Exiting..." -ForegroundColor red
    Sleep -s 1
    Exit 1
}

####

function isInstalled($name)
{
    $32BitPrograms = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $64itPrograms = Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $programs_with_that_name = ($32BitPrograms + " " + $64BitPrograms) | Where-Object { $_.DisplayName -match $Name }
    $is_installed = $null -ne $programs_with_that_name
    return $is_installed
}

####

Write-Host "Installing Powercord..." -ForegroundColor blue

try {
    choco -v | Out-Null
    $choco_installed = $true
} catch {
    $choco_installed = $false
}

if (!($choco_installed)) {
    Write-Host "Chocolatey is not installed. Installing..." -ForegroundColor yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
}
choco upgrade chocolatey -y | Out-Null

if (!(isInstalled("git"))) 
{
    Write-Host "Git is not installed on this machine." -ForegroundColor yellow
    Write-Host "Preparing to install Git..." -ForegroundColor yellow

    Start-Sleep -s 1
    Write-Host "Installing Git..." -ForegroundColor yellow

    choco install git -y | Out-Null
}

if (!(isInstalled("nodejs"))) 
{
    Write-Host "NodeJS is not installed on this machine." -ForegroundColor yellow
    Write-Host "Preparing to install NodeJS..." -ForegroundColor yellow

    Start-Sleep -s 1
    Write-Host "Installing NodeJS..." -ForegroundColor yellow

    choco install npm -y | Out-Null
}

if (!(Test-Path -Path "C:\Users\$env:USERNAME\AppData\Roaming\discordcanary"))
{
    Write-Host "Discord Canary is not installed on this machine." -ForegroundColor yellow
    Write-Host "Preparing to install Discord Canary..." -ForegroundColor yellow

    Start-Sleep -s 1
    Write-Host "Installing Discord Canary..." -ForegroundColor yellow

    choco install discord-canary -y | Out-Null

    Write-Host "Starting Discord Canary..." -ForegroundColor yellow
    Invoke-Expression "C:\Users\$env:USERNAME\AppData\Local\DiscordCanary\app-*\DiscordCanary.exe" | Out-Null
    
    until (!(Test-Path -Path "C:\Users\GuCom\AppData\Local\DiscordCanary\app-1.0.47\resources\bootstrap\manifest.json")) {
        Start-Sleep -s 1
    }
}

if (Get-Process "DiscordCanary" -ErrorAction SilentlyContinue) {
    Write-Host "Killing all Discord instances..." -ForegroundColor blue
    Stop-Process -Name "DiscordCanary" -Force | Out-Null
}

if (!(Test-Path -Path "C:\Users\$env:USERNAME\AppData\Roaming\powercord_installer\powercord\")) {
    New-Item -Path "C:\Users\$env:USERNAME\AppData\Roaming\powercord_installer\" -Name "powercord" -ItemType "directory" -Force | Out-Null
    cd "C:\Users\$env:USERNAME\AppData\Roaming\powercord_installer\powercord\"
}

Start-Sleep -s 1
git clone "https://github.com/powercord-org/powercord"
cd powercord

Start-Sleep -s 1
Write-Host "Installing dependencies..." -ForegroundColor blue
try {
    npm i | Out-Null
} catch
{
    Write-Host "Failed to install Node dependencies. [8x00010]" -ForegroundColor red
    Write-Host "Exiting..." -ForegroundColor red
    Exit 1
}

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

Start-Sleep -s 1
Write-Host "Pluging into Discord..." -ForegroundColor blue
try {
    npm run plug | Out-Null
} catch 
{
    Write-Host "Failed to plug into Discord. [8x00100]" -ForegroundColor red
    Write-Host "Exiting..." -ForegroundColor red
    Exit 1
}

cd $base_location

Write-Host "Starting Discord Canary..." -ForegroundColor blue
Invoke-Expression "C:\Users\$env:USERNAME\AppData\Local\DiscordCanary\app-*\DiscordCanary.exe" | Out-Null

Start-Sleep -s 2
Write-Host "Done! [8x00000]" -ForegroundColor green

####

New-Item -Path "C:\Users\$env:USERNAME\AppData\Roaming\" -Name "powercord_installer" -ItemType "directory" -Force | Out-Null
$date = Get-Date -Format "MM+dd+yyyy_HH+mm"
New-Item -Path "C:\Users\$env:USERNAME\AppData\Roaming\powercord_installer" -Name "instance_$build-$date" -ItemType "file" -Force | Out-Null

####

Exit 0