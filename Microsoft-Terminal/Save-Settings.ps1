<#
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>

    [CmdletBinding(SupportsShouldProcess)]
    Param
    (

    )


Function Save-TerminalSettings{
   
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $true, Position=0)]
        [String]$RootPath
    )
    pushd $RootPath
    $SettingsFile = "C:\Users\$ENV:USERNAME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    [string]$DateString = (Get-Date).GetDateTimeFormats()[8]
    [string]$Content = 'Windows Terminal Profile BACKUP'
    [string]$Content += "`n`nBACKUP ON`t$DateString`nFILE     `t$SettingsFile"
    $CurrentBackup = "$RootPath\current_settings\settings.json"
    $ReadMe = "$RootPath\current_settings\README.md"
    New-Item -Path $ReadMe -ItemType File -Force -EA Ignore | Out-Null
    Remove-Item -Path $ReadMe -Force | Out-Null    
    Set-Content -Path $ReadMe -Value $Content
    if(-not(Test-Path $CurrentBackup)){
        New-Item -Path $CurrentBackup -ItemType File -Force -EA Ignore | Out-Null
        Remove-Item -Path $CurrentBackup -Force | Out-Null
        Copy-Item $SettingsFile $CurrentBackup
        Write-Host "[TERMINAL]`t" -f DarkGreen -NoNewLine
        Write-Host "$SettingsFile ==> $CurrentBackup" -f DarkGray
    }
    else{
        $base = (Get-Item -Path $CurrentBackup).Basename
        $dir = (Get-Item -Path $CurrentBackup).DirectoryName
        [string]$epoch = Get-UnixTime
        $name = $base + '_' + $epoch + '.json'
        $NewBackup = Join-Path $dir $name
        Copy-Item $CurrentBackup $NewBackup
        Copy-Item $SettingsFile $CurrentBackup
        Write-Host "[TERMINAL]`t" -f DarkGreen -NoNewLine
        Write-Host "$CurrentBackup ==> $NewBackup" -f DarkGray        
        Write-Host "[TERMINAL]`t" -f DarkGreen -NoNewLine
        Write-Host "$SettingsFile ==> $CurrentBackup" -f DarkGray
    }

}


$RootPath = (Get-Location).Path
Save-TerminalSettings $RootPath
