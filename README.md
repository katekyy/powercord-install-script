

<div align="center">
  <p>
    <img src="/img.png"/>
    <a href="#powercord-install-script"><img src="https://img.shields.io/github/license/katekyy/powercord-install-script?color=%237289da&style=flat-square"/><a/>
    <a href="#powercord-install-script"><img src="https://img.shields.io/github/commit-activity/w/katekyy/powercord-install-script?color=%237289da&style=flat-square"/><a/>
  </p>
</div>

- [Prerequisites](#prerequisites)
- [Guide For Windows](#guide-for-windows)
  - [What Does This Windows Script Install?](#what-does-this-windows-script-install)
- Guide For Linux (In The Future)

## Prerequisites
- Installed Discord Canary
- Powershell 5.1 or up (On Windows)
- Installed and configured Sudo (On Linux)
  - Debian/Ubuntu `apt-get install sudo`
  - Arch Linux `pacman -S sudo`
  - Fedora `dnf install git`

<br/>

## Guide For Windows

> **Warning**:
> You need to run powershell in admin mode and have powershell in version 5.1 or up in order to run these scripts!

<br/>

First, you need to download scripts:
```
PS> git clone https://github.com/katekyy/powercord-install-script
PS> cd powercord-install-script
PS> cd win
```

<br/>

> **Warning**:
> If you'll get error no. 001, and you are absolutely sure that you dont have powercord installed, then type this command:
> `Remove-Item -Path "C:\Users\$env:USERNAME\AppData\Roaming\powercord_installer\instance_*-*"`

Then, you have two scripts there, one to install powercord, and one to uninstall it.
```
PS> .\install.ps1

PS> .\uninstall.ps1
```

<br/>

##### What Does This Windows Script Install?
Don't mind yourself if you don't have installed Chocolatey, NodeJS, Discord Canary or Git.

This script will automatically download all that software, if you don't have it!
