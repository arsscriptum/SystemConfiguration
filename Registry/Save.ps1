<#
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>

    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $true, Position=0)]
        [Alias('p', 'file', 'f')]
        [String]$Path
    )


$CurrentPath = (Get-Location).Path
$BackupPath = Join-Path $CurrentPath "Backup-$ENV:COMPUTERNAME"
$BackupFile = Join-Path $BackupPath 'OrganizationHKCU.reg'
$RegPath = "$ENV:OrganizationHKCU"
$RegPath = $Path.Replace(':','')

$Null = New-Item -Path $BackupPath -ItemType Directory -EA Ignore -Force 


Export-RegistryItem $RegPath $BackupFile
