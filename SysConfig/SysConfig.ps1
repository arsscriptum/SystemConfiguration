
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
$Script:GIT_WINDOWS_64_URL      = 'https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/Git-2.35.1.2-64-bit.exe'

$Script:DATA_DRIVE             = "x:\"
$Script:TEST_MODE              = "$false"
$Script:QUIET_MODE             = "$Quiet"
$Script:DEV_ROOT               = "$ENV:TEMP"
$Script:SYSCONFIG_SCRIPTS      = "$PSScriptRoot\Scripts"
$Script:CONFIGURE_SCRIPT_PATH  = "$SYSCONFIG_SCRIPTS\Configure.ps1"
$Script:WINGIT_SCRIPT_PATH     = "$SYSCONFIG_SCRIPTS\WindowsGit.ps1"
$Script:REG_USER_ENV           = "$SYSCONFIG_SCRIPTS\UserEnv.reg"
$Script:REG_GLOBAL_ENV         = "$SYSCONFIG_SCRIPTS\GlobalEnv.reg"
$Script:OrganizationHKCUScript = "$SYSCONFIG_SCRIPTS\OrganizationHKCU.reg"

$Script:PROGRAMS_PATH           = Join-Path "$Script:DATA_DRIVE" "Programs"
$Script:MYDOCUMENTS_PATH        = Join-Path "$Script:DATA_DRIVE" "DOCUMENTS"
$Script:MYPICTURES_PATH         = Join-Path "$Script:DATA_DRIVE" "Data\Pictures"
$Script:MYVIDEOS_PATH           = Join-Path "$Script:DATA_DRIVE" "Data\Videos"
$Script:SCREENSHOTS_PATH        = Join-Path "$Script:DATA_DRIVE" "Data\Pictures\Screenshots"
$Script:DOWNLOAD_PATH           = Join-Path "$Script:DATA_DRIVE" "Data\Downloads"
$Script:DESKTOP_PATH            = Join-Path "$Script:DATA_DRIVE" "Data\Windows\Desktop"

$Script:WIN_GIT_INSTALL_PATH    = Join-Path "$Script:PROGRAMS_PATH" "Git"
$Script:POWERSHELL_PATH         = Join-Path "$Script:MYDOCUMENTS_PATH" "PowerShell"
$Script:PS_MODULES_PATH         = Join-Path "$Script:POWERSHELL_PATH" "Modules"
$Script:PS_MODDEV_PATH          = Join-Path "$Script:POWERSHELL_PATH" "Module-Development"
$Script:PS_PROFILE_PATH         = Join-Path "$Script:POWERSHELL_PATH" "Profile"
$Script:PS_PROJECTS_PATH        = Join-Path "$Script:POWERSHELL_PATH" "Projects"



if (-not $env:TEMP) {
    $env:TEMP = Join-Path $env:SystemDrive -ChildPath 'temp'
}



$ErrorActionPreference = 'SilentlyContinue'


function Install-Chocolatey{

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
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


function Check-ValidateBeforeStart {


    if(-not(Test-Path -Path $Script:DEV_ROOT))              { Write-MError "NOT EXISTING: $Script:DEVDRIVE" }
    if(-not(Test-Path -Path $Script:REG_USER_ENV))          { Write-MError "NOT EXISTING: $Script:REG_USER_ENV" }
    if(-not(Test-Path -Path $Script:REG_GLOBAL_ENV))        { Write-MError "NOT EXISTING: $Script:REG_GLOBAL_ENV" }
    if(-not(Test-Path -Path $Script:OrganizationHKCUScript)){ Write-MError "NOT EXISTING: $Script:OrganizationHKCUScript" }

    if(-not(Test-Path -Path $Script:WINGIT_SCRIPT_PATH))    { Write-MError "NOT EXISTING: $Script:WINGIT_SCRIPT_PATH" }
    if(-not(Test-Path -Path $Script:CONFIGURE_SCRIPT_PATH)) { Write-MError "NOT EXISTING: $Script:CONFIGURE_SCRIPT_PATH" }

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


<#
try{
    if (-not(Test-Path "$Script:CONFIGURE_SCRIPT_PATH")){
        throw "Missing Configure Script at $Script:CONFIGURE_SCRIPT_PATH"
        return
    }


    . "$Script:CONFIGURE_SCRIPT_PATH"
    Write-MOk "Included $Script:CONFIGURE_SCRIPT_PATH"

    . "$Script:WINGIT_SCRIPT_PATH"
    Write-MOk "Included $Script:WINGET_SCRIPT_PATH"

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

    Set-GitUSerData "guillaumeplante.qc@gmail.com" "gp"


    Write-MMsg "PUSHD IN $Script:DEV_ROOT"
    pushd "$Script:DEV_ROOT"

    Write-Title 'Git Clone BuildAutomation'
    Invoke-GitClone 'BuildAutomation'
    Write-Title 'Git Clone DejaInsight'
    Invoke-GitClone 'DejaInsight'
    
    Write-MMsg "POPD GO OUT"
    popd
    
    Write-MMsg "PUSHD IN $ENV:TEMP"
    pushd "$ENV:TEMP"
    Write-Title 'Git Clone PowerShell.Profile'
    Invoke-GitClone 'PowerShell.Profile'

    Write-MMsg "PUSHD IN PowerShell.Profile"
    pushd 'PowerShell.Profile'
    Write-MMsg "COPY Microsoft.PowerShell_profile.ps1 --> to $Script:POWERSHELL_PATH"
    Copy-Item "Microsoft.PowerShell_profile.ps1" "$Script:POWERSHELL_PATH"

    Write-MMsg "Remove-Item -Path `"$Script:POWERSHELL_PATH\Profile`""
    $Null=Remove-Item -Path "$Script:POWERSHELL_PATH\Profile" -Recurse -Force -ErrorAction Ignore
    Write-MMsg " Copy-Item `"Profile`" `"$Script:POWERSHELL_PATH\Profile`" -Recurse"
    Copy-Item "Profile" "$Script:POWERSHELL_PATH\Profile" -Recurse 

    Write-MMsg "PUSHD IN $Script:PS_PROJECTS_PATH"
    pushd "$Script:PS_PROJECTS_PATH"


    Write-Title 'Git Clone PowerShell.ModuleBuilder'
    Invoke-GitClone 'PowerShell.ModuleBuilder'

    Write-MMsg "PUSHD IN PowerShell.ModuleBuilder\setup"
    pushd "PowerShell.ModuleBuilder\setup"
    ./Setup.ps1

    Write-MMsg "POPD GO OUT"
    popd


    Write-MMsg "PUSHD IN $Script:PS_MODDEV_PATH"
    pushd "$Script:PS_MODDEV_PATH"

    Write-Title 'Git Clone PowerShell.Module.Core'
    Invoke-GitClone 'PowerShell.Module.Core'

    Write-Title 'Git Clone PowerShell.Module.Reddit'
    Invoke-GitClone 'PowerShell.Module.Reddit'

    Write-Title 'Git Clone PowerShell.Module.Github'
    Invoke-GitClone 'PowerShell.Module.Github'

    Write-Title 'Git Clone PowerShell.Module.WindowsHost'
    Invoke-GitClone 'PowerShell.Module.WindowsHost'

    Write-MMsg "POPD GO OUT"
    popd

    Write-MOk "DONE"

}catch{
    Show-ExceptionDetails($_) -ShowStack
}

#>