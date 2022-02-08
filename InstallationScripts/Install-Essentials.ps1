1##===----------------------------------------------------------------------===
##  ┌─┐┬ ┬┌┐ ┌─┐┬─┐┌─┐┌─┐┌─┐┌┬┐┌─┐┬─┐ 
##  │  └┬┘├┴┐├┤ ├┬┘│  ├─┤└─┐ │ │ │├┬┘ 
##  └─┘ ┴ └─┘└─┘┴└─└─┘┴ ┴└─┘ ┴ └─┘┴└─ 
##  ┌┬┐┌─┐┬  ┬┌─┐┬  ┌─┐┌─┐┌┬┐┌─┐┌┐┌┌┬┐
##   ││├┤ └┐┌┘├┤ │  │ │├─┘│││├┤ │││ │ 
##  ─┴┘└─┘ └┘ └─┘┴─┘└─┘┴  ┴ ┴└─┘┘└┘ ┴ 
##
##  powershell script (c) by <cybercastor@icloud.com>
##  Author: cybercastor <at> icloud <dot> com
##
##  Quebec City, Canada, MMXXI
##===----------------------------------------------------------------------===


#Requires -RunAsAdministrator


# ChocoInstallBase.ps1 by atwork.at
# Get Chocolatey
#Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# See packages at https://chocolatey.org/packages/
# Use according to your own needs...

$MyPackages = @()

# basic editors and dev tools
#$MyPackages += 'sublimetext'
$MyPackages += 'visualstudio2019community'
$MyPackages += 'visualstudio2015community'
#$MyPackages += 'araxismerge'

# Essentials!
$MyPackages += 'pstools'
$MyPackages += 'sysinternals'

$MyPackages += 'vcredist140'

# Microsoft .NET Framework 4.7.2
$MyPackages += 'netfx-4.7.1-devpack'
# or Microsoft .NET Framework 4.7.2
$MyPackages += 'dotnetfx'
# or Microsoft .NET Framework 4.7.2 Developer Pack
$MyPackages += 'netfx-4.7.2-devpack'
# Microsoft .NET Core 2.2.6
$MyPackages += 'dotnetcore'
# or Microsoft .NET Core Runtime (Install) 2.2.6
$MyPackages += 'dotnetcore-runtime.install'

# some generics
$MyPackages += 'googlechrome'
$MyPackages += 'brave'
$MyPackages += 'adobereader'
$MyPackages += 'vlc'
$MyPackages += 'audacity'
$MyPackages += 'microsoft-teams'
$MyPackages += 'skype'
$MyPackages += 'powerbi'

# Additional Tools
$MyPackages += '7zip'
$MyPackages += 'filezilla'
$MyPackages += 'curl'
$MyPackages += 'youtube-dl'

# More Tools
$MyPackages += 'powershell-core'
$MyPackages += 'sysinternals'
$MyPackages += 'fiddler'

# My music
$MyPackages += 'spotify'

# Devices
$MyPackages += 'hpsupportassistant'

# Microsoft Terminal
$MyPackages += 'microsoft-windows-terminal'
$MyPackages += 'terminal-icons.powershell'
$MyPackages += 'glow'

#Youtube channel
$MyPackages += 'obs-studio'

# Nord
$MyPackages += 'nordvpn'

# packet captre / foresics
$MyPackages += 'wireshark'
$MyPackages += 'usbpcap'
$MyPackages += 'network-miner'
$MyPackages += 'netfoxdetective'
$MyPackages += 'microsoft-message-analyzer'

# Network scanners
$MyPackages += 'nmap'
$MyPackages += 'advanced-ip-scanner'

Foreach( $program in $MyPackages ){
    $cmd="choco install $program -y"
    & $cmd
}