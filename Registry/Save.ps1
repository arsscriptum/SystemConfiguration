<#
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>

[CmdletBinding(SupportsShouldProcess)]
param ()


$CurrentPath = (Get-Location).Path
$BackupPath = Join-Path $CurrentPath 'Backup'
$BackupFile = Join-Path $BackupPath 'OrganizationHKCU.reg'
$RegPath = "$ENV:OrganizationHKCU"
$RegPath = $Path.Replace(':','')
$RegExe = (Get-Command reg.exe).Source


Write-Host "===============================================================================" -f DarkRed
Write-Host "SAVING REGISTRY VALUES FROM $RegPath" -f DarkYellow;
Write-Host "===============================================================================" -f DarkRed    
Write-Host "Registry Path     `t" -NoNewLine -f DarkYellow ; Write-Host "$RegPath" -f Gray 
Write-Host "BackupFile   `t" -NoNewLine -f DarkYellow;  Write-Host "$BackupFile" -f Gray 
$Null = New-Item -Path $BackupPath -ItemType Directory -EA Ignore -Force 

$Result=&"$RegExe" EXPORT "$Path" "$BackupFile" /y

if($Result -eq 'The operation completed successfully.'){
    Write-Host "SUCCESS `t" -NoNewLine -f DarkGreen;  Write-Host " Saved in $BackupFile" -f Gray 
    $NowStr =  (get-date).GetDateTimeFormats()[12]
    $Content = Get-Content -Path $BackupFile -Raw
    $NewContent = @"
;;==============================================================================`
;;
;;  $RegPath 
;;  EXPORTED ON $NowStr
;;==============================================================================
;;  Ars Scriptum - made in quebec 2020 <guillaumeplante.qc>
;;==============================================================================

"@

    $NewContent += $Content
    Set-Content -Path $BackupFile -Value $NewContent
}

