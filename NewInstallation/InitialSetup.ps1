
<#
  ╓──────────────────────────────────────────────────────────────────────────────────────
  ║   PowerShell Script to configure a newly installed Windows system
  ╙──────────────────────────────────────────────────────────────────────────────────────
 #>

<#

    1) Set the PowerShell HOME path, the modules path and the module development path
    2) Set the REGISTRY variable representing the root path of all scripts settings
    3) Set the System Environment variables...


Requirements:
    1) Github Authentication Token

#>

<#
.SYNOPSIS
    A brief description of the function or script.
    This keyword can be used only once in each topic.

.DESCRIPTION
    A detailed description of the function or script.
    This keyword can be used only once in each topic.

.NOTES
    Some additional notes. This keyword can be used only once in each topic.
    This keyword can be used only once in each topic.

.LINK
    A link used when Get-Help with a switch -OnLine is used.
    This keyword can be used only once in each topic.

.EXAMPLE
    Example 1
    You can use this keyword as many as you want.

.EXAMPLE
    Example 2
    You can use this keyword as many as you want.
#>

<#
    .Synopsis
        Convert a compressed script in BASE64 string value back in CLEAR
    .Description
        Convert a compressed script in BASE64 string value back in CLEAR
    .Parameter ScriptBlock
        The ScriptBlock to convert
    .Inputs
        ScriptBlock
    .Outputs
        ScriptBlock
#>




#Requires -RunAsAdministrator



# ============================================================================================================
# SCRIPT VARIABLES
# ============================================================================================================

$Global:DEVDRIVE               = 'P:\'
$Global:DEV_ROOT               = 'P:\Development'
$Global:REG_USER_ENV           = "$PSScriptRoot\Environment\UserEnv.reg"
$Global:REG_GLOBAL_ENV         = "$PSScriptRoot\Environment\GlobalEnv.reg"
$Global:OrganizationHKCUScript = "$PSScriptRoot\Registry\OrganizationHKCU.reg"

$Global:GIT_WINDOWS_64_URL      = 'https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/Git-2.35.1.2-64-bit.exe'
$Global:PROGRAMS_PATH           = 'c:\Programs'
$Global:WIN_GIT_INSTALL_PATH    = Join-Path "$Global:PROGRAMS_PATH" "Git"
$Global:MYDOCUMENTS_PATH        = 'c:\DOCUMENTS'
$Global:MYPICTURES_PATH         = 'c:\Data\Pictures'
$Global:MYVIDEOS_PATH           = 'c:\Data\Videos'
$Global:SCREENSHOTS_PATH        = 'c:\Data\Pictures\Screenshots'
$Global:DOWNLOAD_PATH           = 'c:\Data\Downloads' 
$Global:DESKTOP_PATH            = 'c:\Data\Windows\Desktop' 

$Global:POWERSHELL_PATH         = Join-Path "$Global:MYDOCUMENTS_PATH" "PowerShell"
$Global:PS_MODULES_PATH         = Join-Path "$Global:POWERSHELL_PATH" "Modules"
$Global:PS_MODDEV_PATH          = Join-Path "$Global:POWERSHELL_PATH" "Modules-Development"
$Global:PS_PROFILE_PATH         = Join-Path "$Global:POWERSHELL_PATH" "Profile"
$Global:PS_PROJECTS_PATH        = Join-Path "$Global:POWERSHELL_PATH" "Projects"

$Global:GITHUB_AUTH_USER        = 'arsscriptum'
$Global:GITHUB_AUTH_TOKEN       = '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'



if (-not $env:TEMP) {
    $env:TEMP = Join-Path $env:SystemDrive -ChildPath 'temp'
}

$Global:TEMP_INSTALL_PATH = Join-Path $env:TEMP -ChildPath "SystemConfiguration"


function Invoke-GitClone {

    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        [Parameter(Mandatory=$true,Position=0)]     
        [string]$Repo,
        [Parameter(Mandatory=$false)]     
        [string]$Name
    )

    $GitExe = (get-command 'git.exe').Source

    if ($PSBoundParameters.ContainsKey('Name')) {
        Write-Host '[GIT] ' -f DarkRed -NoNewLine
        Write-Host "clone $Repo.git" -f Yellow            
        &"$GitExe" "clone" "https://$Global:GITHUB_AUTH_USER:$Global:GITHUB_AUTH_TOKEN@github.com/$Global:GITHUB_AUTH_USER/$Repo.git" "$Name"
    }else{
        &"$GitExe" "clone" "https://$Global:GITHUB_AUTH_USER:$Global:GITHUB_AUTH_TOKEN@github.com/$Global:GITHUB_AUTH_USER/$Repo.git"    
    }  
    
    
}


function write-slog {

    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        [Parameter(Mandatory=$true,Position=0)]     
        [string]$Message
    )
    Write-Host -n -f DarkCyan "[i] "
    Write-Host -f Cyan "$Message"  
}

function write-serror {

    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        [Parameter(Mandatory=$true,Position=0)]     
        [string]$Message
    )
    Write-Host -n -f DarkRed "[ERROR] "
    Write-Host -f DarkYellow "$Message"  
}


function ValidateBeforeStart {

    if(-not(Test-Path -Path $Global:DEVDRIVE))              { write-serror "NOT EXISTING: $Global:DEVDRIVE" }
    if(-not(Test-Path -Path $Global:REG_USER_ENV))          { write-serror "NOT EXISTING: $Global:REG_USER_ENV" }
    if(-not(Test-Path -Path $Global:REG_GLOBAL_ENV))        { write-serror "NOT EXISTING: $Global:REG_GLOBAL_ENV" }
    if(-not(Test-Path -Path $Global:OrganizationHKCUScript)){ write-serror "NOT EXISTING: $Global:OrganizationHKCUScript" }
}

function Get-OnlineFileNoCache{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$true,Position=0)]   
        [string]$Url,
        [Parameter(Mandatory=$true,Position=1)]   
        [string]$Path,
        [Parameter(Mandatory=$false)]
        [string]$ProxyAddress,
        [Parameter(Mandatory=$false)]
        [string]$ProxyUser,
        [Parameter(Mandatory=$false)]
        [string]$ProxyPassword,
        [Parameter(Mandatory=$false)]
        [string]$UserAgent=""
    )

    $ForceNoCache=$True

    $client = New-Object Net.WebClient
    if( $PSBoundParameters.ContainsKey('ProxyAddress') ){
        Write-Warning ('NetGetFileNoCache''s -ProxyAddress parameter is not tested.')
        $proxy = New-object System.Net.WebProxy "$ProxyAddress"
        $proxy.Credentials = New-Object System.Net.NetworkCredential ($ProxyUser, $ProxyPassword) 
        $client.proxy=$proxy
    }
    
    if($UserAgent -ne ""){
        $Client.Headers.Add("user-agent", "$UserAgent")     
    }else{
        $Client.Headers.Add("user-agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 13_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.1 Mobile/15E148 Safari/604.1") 
    }

    $RequestUrl = "$Url"

    if ($ForceNoCache) {
        # doesn’t use the cache at all
        $client.CachePolicy = New-Object Net.Cache.RequestCachePolicy([Net.Cache.RequestCacheLevel]::NoCacheNoStore)

        $RandId=(new-guid).Guid
        $RandId=$RandId -replace "-"
        $RequestUrl = "$Url" + "?id=$RandId"
    }
    Write-Host "NetGetFileNoCache: Requesting $RequestUrl"
    $client.DownloadFile($RequestUrl,$Path)
}




function Install-WindowsGit {

    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        [Parameter(Mandatory=$true,Position=0)]    
        [string]$Url,
        [Parameter(Mandatory=$true,Position=1)]    
        [string]$InstallPath
    )
    $Installed =  Test-GitInstalled
    if($Installed) {write-slog "Windows Git already installed..." ; return ; } 
    write-slog "Installing Windows Git from $Url to $InstallPath"

    $LocalInstaller = Join-Path "$ENV:Temp" "Git.exe"
    Get-OnlineFileNoCache -Url "$Url" -Path $LocalInstaller
    if(-not(Test-Path $LocalInstaller)){
        throw "Failed to get Git installer"
    }

    write-slog "$LocalInstaller /NORESTART /SUPPRESSMSGBOXES /VERYSILENT /SP /ALLUSERS /NOCANCEL /NOCLOSEAPPLICATIONS /DIR=$InstallPath"
    
    # Args: https://jrsoftware.org/ishelp/index.php?topic=setupcmdline
    &"$LocalInstaller" "/NORESTART" "/SUPPRESSMSGBOXES" "/VERYSILENT" "/SP" "/ALLUSERS" "/NOCANCEL" "/NOCLOSEAPPLICATIONS" "/DIR=`"$InstallPath`""
}



function Test-GitInstalled {
    [CmdletBinding()]
    param()

    $checkPath = 'c:\Programs\Git'

    if ($Command = Get-Command 'git.exe' -CommandType Application -ErrorAction Ignore) {
        Write-Verbose "git is on the PATH, assume it's installed"
        $true
    }
    elseif (-not (Test-Path $checkPath)) {
        Write-Verbose "Install folder doesn't exist"
        $false
    }
    elseif (-not (Get-ChildItem -Path $checkPath)) {
        Write-Verbose "Install folder exists but is empty"
        $false
    }
    else {
        Write-Verbose "Install folder exists and is not empty"

        $checkFiles = @('c:\Programs\Git\git-bash.exe', 'c:\Programs\Git\git-cmd.exe', 'c:\Programs\Git\bin\git.exe', 'c:\Programs\Git\bin\sh.exe', 'c:\Programs\Git\bin\bash.exe')
        
        ForEach($theFile in $checkFiles){
            if (-not (Test-Path $theFile)) {
                Write-Verbose "$theFile missing"
                return $false
            }
        }
        $true
    }
}

function Wait-GitInstalled {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()
    
    $GitInstalled = $false

    While($GitInstalled -eq $False){
        Sleep -Seconds 5
        Write-Verbose "Checking if Git is Installed....."
        $GitInstalled = Test-GitInstalled
    }

    Write-Verbose "Git is Installed"
}



function Set-HiddenDriveP {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()
    write-slog "Set the P drive has Hidden"
    $Null = New-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' NoDrives -Value 32768 -Type DWORD -Force
}


function Install-Chocolatey{

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}


function Set-SystemEnvironmentValues {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    $RegExe = (get-command 'reg.exe').Source
    $UserEnvScript = "$PSScriptRoot\Environment\UserEnv.reg"
    $GlobalEnvScript = "$PSScriptRoot\Environment\GlobalEnv.reg"

    if(-not(Test-Path -Path $GlobalEnvScript)){ throw "Missing $GlobalEnvScript" }
    if(-not(Test-Path -Path $UserEnvScript)){ throw "Missing $UserEnvScript" }

    write-slog "Registry Import $GlobalEnvScript"
    &"$RegExe" "import" "$GlobalEnvScript"
    write-slog "Registry Import $UserEnvScript"
    &"$RegExe" "import" "$UserEnvScript"

}



function Set-WellKnownPaths {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    Write-Host "======================================================"
    Write-Host "WELL KNOWN PATHS (DOCUMENTS, PICTURES, ETC)"
    Write-Host "======================================================"

    Write-Host "Desktop:         $Global:DESKTOP_PATH"
    Write-Host "Pictures:        $Global:MYPICTURES_PATH"
    Write-Host "Screenshots:     $Global:SCREENSHOTS_PATH"
    Write-Host "Download:        $Global:DOWNLOAD_PATH"
    Write-Host "Documents:       $Global:MYDOCUMENTS_PATH"
    Write-Host "Videos:          $Global:MYVIDEOS_PATH"

    $confirm = Read-Host -Prompt 'Are all the paths above correct (y/n)'
    if ($confirm -ne 'y') {
        Write-Host -n -f DarkRed "[!] "
        Write-Host -f DarkYellow "Edit the script to set the values you want."
        return
    }

    # MY DOCUMENTS
    New-Item -Path "$Global:DESKTOP_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:MYPICTURES_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:SCREENSHOTS_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:DOWNLOAD_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:MYDOCUMENTS_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:MYVIDEOS_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:POWERSHELL_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null

    # POWERSHELL PROFILE
    New-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' Personal -Value "$Global:MYDOCUMENTS_PATH" -Type ExpandString -Force | Out-Null
    Set-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' Desktop -Value "$Global:DESKTOP_PATH" -Type ExpandString -Force | Out-Null
    Set-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' 'My Pictures' -Value "$Global:MYPICTURES_PATH" -Type ExpandString -Force | Out-Null
    Set-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' 'My Video' -Value "$Global:MYVIDEOS_PATH" -Type ExpandString -Force | Out-Null
}


function Set-PowerShellPaths {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    Write-Host "======================================================"
    Write-Host "SET POWERSHELL HOME, MODULES, MODULE DEVELOPMENT PATH"
    Write-Host "======================================================"

    Write-Host "PowerShell Home:   $Global:POWERSHELL_PATH"
    Write-Host "Modules:           $Global:PS_MODULES_PATH"
    Write-Host "Modules Dev:       $Global:PS_MODDEV_PATH"
    Write-Host "Projects:          $Global:PS_PROJECTS_PATH"
    Write-Host "Profile:           $Global:PS_PROFILE_PATH"

    $confirm = Read-Host -Prompt 'Are all the paths above correct (y/n)'
    if ($confirm -ne 'y') {
        Write-Host -n -f DarkRed "[!] "
        Write-Host -f DarkYellow "Edit the script to set the values you want."
        return
    }

    New-Item -Path "$Global:POWERSHELL_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:PS_MODULES_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:PS_MODDEV_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:PS_PROJECTS_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Global:PS_PROFILE_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
}


function Invoke-InstallWindowsGit {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    Write-Host "======================================================"
    Write-Host "INSTALL WIN GIT"
    Write-Host "======================================================"

    Write-Host "GIT Install Url :   $Global:GIT_WINDOWS_64_URL"
    Write-Host "Git Install Path:   $Global:WIN_GIT_INSTALL_PATH"

    $confirm = Read-Host -Prompt 'Install Windows Git ? (y/n)'
    if ($confirm -ne 'y') {
         Write-Host -n -f DarkRed "[!] "
        Write-Host -f DarkYellow " Exit. "
        return
    }
    Install-WindowsGit -Url "$Global:GIT_WINDOWS_64_URL" -InstallPath "$Global:WIN_GIT_INSTALL_PATH"
}

function Clone-BaseRepos {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    New-Item -Path "$Global:DEV_ROOT" -ItemType Directory -Force -ErrorAction Ignore | Out-Null

    pushd "$Global:DEV_ROOT"

    Invoke-GitClone 'BuildAutomation'

    Invoke-GitClone 'DejaInsight'
    popd

}


function Clone-PwshRepos {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()
    
    $NewDir = ((New-TemporaryDirectory).Fullname)
    pushd $NewDir
    
    write-slog "Cloning PowerShell.Profile"
    Invoke-GitClone 'PowerShell.Profile'
    pushd 'PowerShell.Profile'
    write-slog "COPY Microsoft.PowerShell_profile.ps1 --> to $Global:POWERSHELL_PATH"
    Copy-Item "Microsoft.PowerShell_profile.ps1" "$Global:POWERSHELL_PATH"      
    popd
    $Null=Remove-Item -Path "$Global:POWERSHELL_PATH\Profile" -Recurse -Force -ErrorAction Ignore
    Copy-Item "PowerShell.Profile" "$Global:POWERSHELL_PATH\Profile" -Recurse 
}

function Clone-PwshModules {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    pushd "$Global:PS_PROJECTS_PATH"
    Invoke-GitClone 'PowerShell.ModuleBuilder'
    pushd "PowerShell.ModuleBuilder\setup"
    ./Setup.ps1
    popd


    pushd "$Global:PS_MODDEV_PATH"

    Invoke-GitClone 'PowerShell.Module.Core'
    Invoke-GitClone 'PowerShell.Module.Reddit'
    Invoke-GitClone 'PowerShell.Module.Github'
    Invoke-GitClone 'PowerShell.Module.WindowsHost'
    popd

}



function Set-RegistryOrganizationHKCU {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    #===============================================================================
    # OrganizationHKCU
    #===============================================================================
    if( ($ENV:OrganizationHKCU -eq $null) -Or ($ENV:OrganizationHKCU -eq '') )
    {
        Write-Host "===============================================================================" -f DarkRed    
        Write-Host "A required environment variable needs to be setup (user scope)     `t" -NoNewLine -f DarkYellow ; Write-Host "$Global:OrganizationHKCU" -f Gray 
        $OrgIdentifier = "_gp"
        $OrganizationHKCU = "HKCU:\Software\" + "$OrgIdentifier"

        [Environment]::SetEnvironmentVariable('OrganizationHKCU',$OrganizationHKCU,"User")

        Write-Host "Setting OrganizationHKCU --> $OrganizationHKCU [User]"  -ForegroundColor Yellow
        $Null = New-Item -Path "$OrganizationHKCU" -ItemType Directory -Force -ErrorAction Ignore

        $Cmd = Get-Command "RefreshEnv.cmd"
        if($Cmd){
            $RefreshEnv = $Cmd.Source
            &"$RefreshEnv"
        }

        $ENV:OrganizationHKCU = "$OrganizationHKCU"

    }
}







<#
ValidateBeforeStart 


Set-RegistryOrganizationHKCU


Read-Host 'Next: Set-SystemEnvironmentValues'
Set-SystemEnvironmentValues

Read-Host 'Next: Set-WellKnownPaths'
Set-WellKnownPaths

Read-Host 'Next: Set-PowerShellPaths'
Set-PowerShellPaths

#>
Read-Host 'Next: Invoke-InstallWindowsGit'
Invoke-InstallWindowsGit
Wait-GitInstalled 
return

git config --global user.email "guillaumeplante.qc@gmail.com"
git config --global user.name "Guillaume Plante"


Clone-BaseRepos

Clone-PwshRepos


Clone-PwshModules


Read-Host 'Next: Install-Chocolatey'
Install-Chocolatey