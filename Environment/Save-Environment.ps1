<#
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>

$RegPath = "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
$CurrentPath = (Get-Location).Path
$BackupPath = Join-Path $CurrentPath "Backup-$ENV:COMPUTERNAME"
$BackupFile = Join-Path $BackupPath 'GlobalEnv.reg'
Write-Host -f DarkRed "[EXPORTING ENVIRONMENT] " -NoNewline
Write-Host "$RegPath $BackupFile" -f Magenta
$Null = New-Item -Path $BackupPath -ItemType Directory -EA Ignore -Force 

Export-RegistryItem $RegPath $BackupFile

$RegPath = "HKCU\Environment"
$BackupPath = Join-Path $CurrentPath "Backup-$ENV:COMPUTERNAME"
$BackupFile = Join-Path $BackupPath 'UserEnv.reg'
$Null = New-Item -Path $BackupPath -ItemType Directory -EA Ignore -Force 
Write-Host -f DarkRed "[EXPORTING ENVIRONMENT] " -NoNewline
Write-Host "$RegPath $BackupFile" -f Cyan

Export-RegistryItem $RegPath $BackupFile
