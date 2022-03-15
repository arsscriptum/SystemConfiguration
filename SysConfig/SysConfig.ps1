
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


[CmdletBinding(SupportsShouldProcess)]
param
(
    [Parameter(Mandatory=$false)]    
    [switch]$Quiet
)

# ============================================================================================================
# SCRIPT VARIABLES
# ============================================================================================================

$Script:TEST_MODE              = "$false"
$Script:QUIET_MODE             = "$Quiet"
$Script:DEV_ROOT               = "$ENV:TEMP"
$Script:SYSCONFIG_SCRIPTS      = "$PSScriptRoot\Scripts"
$Script:CONFIGURE_SCRIPT_PATH  = "$SYSCONFIG_SCRIPTS\Configure.ps1"
$Script:ASSEMBLIES_SCRIPT_PATH = "$SYSCONFIG_SCRIPTS\Assemblies.ps1"
$Script:SYSLOG_SCRIPT_PATH     = "$SYSCONFIG_SCRIPTS\Syslog.ps1"
$Script:EXCEPTION_SCRIPT_PATH  = "$SYSCONFIG_SCRIPTS\Exception.ps1"
$Script:REG_USER_ENV           = "$SYSCONFIG_SCRIPTS\UserEnv.reg"
$Script:REG_GLOBAL_ENV         = "$SYSCONFIG_SCRIPTS\GlobalEnv.reg"
$Script:OrganizationHKCUScript = "$SYSCONFIG_SCRIPTS\OrganizationHKCU.reg"

$Script:GIT_WINDOWS_64_URL      = 'https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/Git-2.35.1.2-64-bit.exe'
$Script:PROGRAMS_PATH           = 'c:\Programs'
$Script:WIN_GIT_INSTALL_PATH    = Join-Path "$Script:PROGRAMS_PATH" "Git"
$Script:MYDOCUMENTS_PATH        = 'c:\DOCUMENTS'
$Script:MYPICTURES_PATH         = 'c:\Data\Pictures'
$Script:MYVIDEOS_PATH           = 'c:\Data\Videos'
$Script:SCREENSHOTS_PATH        = 'c:\Data\Pictures\Screenshots'
$Script:DOWNLOAD_PATH           = 'c:\Data\Downloads' 
$Script:DESKTOP_PATH            = 'c:\Data\Windows\Desktop' 

$Script:POWERSHELL_PATH         = Join-Path "$Script:MYDOCUMENTS_PATH" "PowerShell"
$Script:PS_MODULES_PATH         = Join-Path "$Script:POWERSHELL_PATH" "Modules"
$Script:PS_MODDEV_PATH          = Join-Path "$Script:POWERSHELL_PATH" "Modules-Development"
$Script:PS_PROFILE_PATH         = Join-Path "$Script:POWERSHELL_PATH" "Profile"
$Script:PS_PROJECTS_PATH        = Join-Path "$Script:POWERSHELL_PATH" "Projects"



if (-not $env:TEMP) {
    $env:TEMP = Join-Path $env:SystemDrive -ChildPath 'temp'
}



$ErrorActionPreference = 'SilentlyContinue'



function Clone-BaseRepos {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    New-Item -Path "$Script:DEV_ROOT" -ItemType Directory -Force -ErrorAction Ignore | Out-Null

    pushd "$Script:DEV_ROOT"

    Invoke-GitClone 'BuildAutomation'

    Invoke-GitClone 'DejaInsight'
    popd

}


function Clone-PwshRepos {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()
    
    write-slog "Going in $ENV:TEMP"
    pushd "$ENV:TEMP"
    write-slog "Cloning PowerShell.Profile"
    Invoke-GitClone 'PowerShell.Profile'
    pushd 'PowerShell.Profile'
    write-slog "COPY Microsoft.PowerShell_profile.ps1 --> to $Script:POWERSHELL_PATH"
    Copy-Item "Microsoft.PowerShell_profile.ps1" "$Script:POWERSHELL_PATH"

    $Null=Remove-Item -Path "$Script:POWERSHELL_PATH\Profile" -Recurse -Force -ErrorAction Ignore
    Copy-Item "Profile" "$Script:POWERSHELL_PATH\Profile" -Recurse 
}

function Clone-PwshModules {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    pushd "$Script:PS_PROJECTS_PATH"
    Invoke-GitClone 'PowerShell.ModuleBuilder'
    pushd "PowerShell.ModuleBuilder\setup"
    ./Setup.ps1
    popd


    pushd "$Script:PS_MODDEV_PATH"

    Invoke-GitClone 'PowerShell.Module.Core'
    Invoke-GitClone 'PowerShell.Module.Reddit'
    Invoke-GitClone 'PowerShell.Module.Github'
    Invoke-GitClone 'PowerShell.Module.WindowsHost'
    popd

}



function Set-SystemEnvironmentValues {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    $RegExe = (get-command 'reg.exe').Source

    if($Script:TEST_MODE -eq $False){
        &"$RegExe" "import" "$Script:REG_GLOBAL_ENV"
        Write-MOk "Registry Import $Script:REG_GLOBAL_ENV"
        
        &"$RegExe" "import" "$Script:REG_USER_ENV"
        Write-MOk "Registry Import $Script:REG_USER_ENV"
    }else{
        Write-MMsg "WhatIf : Registry Import $Script:REG_GLOBAL_ENV"
        Write-MMsg "WhatIf : Registry Import $Script:REG_USER_ENV"
    }
}
function Write-Title{

    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        [Parameter(Mandatory=$true,Position=0)]    
        [string]$Title
    )

    Write-Host -f DarkYellow "`n======================================================"
    Write-Host -n -f DarkRed "$Title"
    if($Script:TEST_MODE -eq $False){
        Write-Host -n -f DarkRed "`n"
    }else{
        Write-Host -f Red "  ** TEST MODE"
    }
    Write-Host -f DarkYellow "======================================================`n"

}

function Set-WellKnownPaths {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    Write-Title "WELL KNOWN PATHS (DOCUMENTS, PICTURES, ETC)"

    Write-MMsg "Desktop:         $Script:DESKTOP_PATH"
    Write-MMsg "Pictures:        $Script:MYPICTURES_PATH"
    Write-MMsg "Screenshots:     $Script:SCREENSHOTS_PATH"
    Write-MMsg "Download:        $Script:DOWNLOAD_PATH"
    Write-MMsg "Documents:       $Script:MYDOCUMENTS_PATH"
    Write-MMsg "Videos:          $Script:MYVIDEOS_PATH"

    if($Script:QUIET_MODE -eq $False){
        $confirm = Read-Host -Prompt 'Are all the paths above correct (y/n)'
        if ($confirm -ne 'y') {
            Write-Host -f DarkYellow "Edit the script to set the values you want."
            return
        }
    }
    

    # MY DOCUMENTS
    New-Item -Path "$Script:DESKTOP_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Script:MYPICTURES_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Script:SCREENSHOTS_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Script:DOWNLOAD_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Script:MYDOCUMENTS_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Script:MYVIDEOS_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    New-Item -Path "$Script:POWERSHELL_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null

    $RegPathShellFolders = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders'
    
    New-ItemProperty "$RegPathShellFolders" Personal -Value "$Script:MYDOCUMENTS_PATH" -Type ExpandString -Force | Out-Null
    Set-ItemProperty "$RegPathShellFolders" Desktop -Value "$Script:DESKTOP_PATH" -Type ExpandString -Force | Out-Null
    Set-ItemProperty "$RegPathShellFolders" 'My Pictures' -Value "$Script:MYPICTURES_PATH" -Type ExpandString -Force | Out-Null
    Set-ItemProperty "$RegPathShellFolders" 'My Video' -Value "$Script:MYVIDEOS_PATH" -Type ExpandString -Force | Out-Null
     
    $RegPathShellFolders = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
    
    New-ItemProperty "$RegPathShellFolders" Personal -Value "$Script:MYDOCUMENTS_PATH" -Type ExpandString -Force | Out-Null
    Set-ItemProperty "$RegPathShellFolders" Desktop -Value "$Script:DESKTOP_PATH" -Type ExpandString -Force | Out-Null
    Set-ItemProperty "$RegPathShellFolders" 'My Pictures' -Value "$Script:MYPICTURES_PATH" -Type ExpandString -Force | Out-Null
    Set-ItemProperty "$RegPathShellFolders" 'My Video' -Value "$Script:MYVIDEOS_PATH" -Type ExpandString -Force | Out-Null
}


function Set-PowerShellPaths {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    Write-Title "SET POWERSHELL HOME, MODULES, MODULE DEVELOPMENT PATH"

    Write-MMsg "PowerShell Home:   $Script:POWERSHELL_PATH"
    Write-MMsg "Modules:           $Script:PS_MODULES_PATH"
    Write-MMsg "Modules Dev:       $Script:PS_MODDEV_PATH"
    Write-MMsg "Projects:          $Script:PS_PROJECTS_PATH"
    Write-MMsg "Profile:           $Script:PS_PROFILE_PATH"

    if($Script:QUIET_MODE -eq $False){
        $confirm = Read-Host -Prompt 'Are all the paths above correct (y/n)'
        if ($confirm -ne 'y') {
            Write-Host -f DarkYellow "Edit the script to set the values you want."
            return
        }
    }
    

    New-Item -Path "$Script:POWERSHELL_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null ; Write-MOk "Created: $Script:POWERSHELL_PATH" ; 
    New-Item -Path "$Script:PS_MODULES_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null ; Write-MOk "Created: $Script:PS_MODULES_PATH" ; 
    New-Item -Path "$Script:PS_MODDEV_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null ; Write-MOk "Created: $Script:PS_MODDEV_PATH" ; 
    New-Item -Path "$Script:PS_PROJECTS_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null ; Write-MOk "Created: $Script:PS_PROJECTS_PATH" ; 
    New-Item -Path "$Script:PS_PROFILE_PATH" -ItemType Directory -Force -ErrorAction Ignore | Out-Null ; Write-MOk "Created: $Script:PS_PROFILE_PATH" ; 
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
        Write-Host "A required environment variable needs to be setup (user scope)     `t" -NoNewLine -f DarkYellow ; Write-Host "$Script:OrganizationHKCU" -f Gray 
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



try{
    if (-not(Test-Path "$Script:CONFIGURE_SCRIPT_PATH")){
        throw "Missing Configure Script at $Script:CONFIGURE_SCRIPT_PATH"
        return
    }


    . "$Script:CONFIGURE_SCRIPT_PATH"
    Write-MOk "Included $Script:CONFIGURE_SCRIPT_PATH"

    Register-Assemblies
    Check-ValidateBeforeStart



    $PwshExe = (Get-Command 'pwsh.exe').Source

    $Text = "
    Some operations will require elevated privilege
    <LineBreak />
            Do you want to run this script as an Administrator?<LineBreak />
            <LineBreak />
             - Select `"Yes`" to Run as an Administrator<LineBreak />
             - Select `"No`" to not run this as an Administrator<LineBreak />
             - Select `"Cancel`" to stop the script.<LineBreak />
"


    $ErrorMsgParams = @{
        Title = "Error"
        TitleBackground = "Yellow"
        TitleTextForeground = "Red"
        TitleFontWeight = "UltraBold"
        TitleFontSize = 20
        ButtonType = "Yes-No-Cancel"
    }

    if ($PSBoundParameters.ContainsKey('WhatIf')) {
            Write-Host '[WhatIf] ' -f DarkRed -NoNewLine
            Write-Host "Simulation Only" -f Yellow            
            $Script:TEST_MODE = $True
            $WhatIf = $True
        }

    if($Script:TEST_MODE -eq $False){
        If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
            Show-MessageBox @ErrorMsgParams -Content $Text
            $Prompt = Get-Variable -Name PWSHMessageBoxOutput -ValueOnly 
            Switch ($Prompt) {
                #This will debloat Windows 10
                Yes {
                    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
                    Start-Process "$PwshExe" -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
                    Exit
                }
                No {
                    Break
                }
            }
        }
    }



    Set-RegistryOrganizationHKCU
    Set-SystemEnvironmentValues -WhatIf:$Script:TEST_MODE
    Set-WellKnownPaths -WhatIf:$Script:TEST_MODE
    Set-PowerShellPaths -WhatIf:$Script:TEST_MODE

    Write-Title "WINDOWS GIT"

    $GitInstalled = Test-GitInstalled 
    if($GitInstalled -eq $False){
        Write-Title 'Invoke-InstallWindowsGit'
        Invoke-InstallWindowsGit
        Wait-GitInstalled     
    }else{
        Write-MOk "Git Installed"
    }
    


git config --global user.email "guillaumeplante.qc@gmail.com"
git config --global user.name "Guillaume Plante"


}catch{
    Show-ExceptionDetails($_) -ShowStack
}

