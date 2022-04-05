

[CmdletBinding(SupportsShouldProcess)] 
    param(
        [switch]$TestMode,
        [switch]$Quiet,
        [switch]$Admin
    )


# ============================================================================================================
# SCRIPT VARIABLES
# ============================================================================================================
$Script:GIT_WINDOWS_64_URL      = 'https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/Git-2.35.1.2-64-bit.exe'

$Script:DATA_DRIVE             = "x:\"
$Script:TEST_MODE              = "$false"
$Script:QUIET_MODE             = "$Quiet"
$Script:DEV_ROOT               = Join-Path "$Script:DATA_DRIVE" "Development"
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

$Script:PwshExe                 = (Get-Command 'pwsh.exe').Source

if ($PSBoundParameters.ContainsKey('Admin')) {
    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
        Write-Host '[Admin] ' -f DarkRed -NoNewLine
        Write-Host "Restart in Admin mode" -f Yellow          
        Restart-WithAdminPriv
    }

}


if (-not $env:TEMP) {
    $env:TEMP = Join-Path $env:SystemDrive -ChildPath 'temp'
}

if ($PSBoundParameters.ContainsKey('WhatIf')) {
    Write-Host '[WhatIf] ' -f DarkRed -NoNewLine
    Write-Host "Simulation Only" -f Yellow            
    $Script:TEST_MODE = $True
    $WhatIf = $True
}
$ErrorActionPreference = 'SilentlyContinue'
$Script:UsePreCompiledDependencies = $False
$Script:TEST_MODE = $TestMode

if($Script:TEST_MODE){
    Write-Title "TEST MODE ENABLED"
}else{
    Write-Title "SYSTEM CONFIGURATION - NORMAL MODE"
}

Register-Assemblies

   



# ============================================================================================================
# SCRIPT LOGS
# ============================================================================================================

function write-serr([string]$msg,[switch]$fatal){    
    Write-Host -n "❗❗❗ "; Write-Host -f DarkYellow "$msg"
    if($fatal){ exit; }
}

function write-smsg([string]$msg,[switch]$ok=$false){
    if($ok){Write-Host -n "✅ "; }else{ Write-Host -n "⚡ "; }
    Write-Host " $msg"
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


# ============================================================================================================
# SCRIPT Dependencies
# ============================================================================================================

function Restart-WithAdminPriv{

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



    if($Script:TEST_MODE -eq $False){
        If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
            Show-MessageBox @ErrorMsgParams -Content $Text
            $Prompt = Get-Variable -Name PWSHMessageBoxOutput -ValueOnly 
            Switch ($Prompt) {
                #This will debloat Windows 10
                Yes {
                    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
                    Start-Process "$Script:PwshExe" -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
                    Exit
                }
                No {
                    Break
                }
            }
        }
    }    
}

function Import-PreCompiled{
    $PcsPath = "$PSScriptRoot\pcs.ps1"
    If( -not (Test-Path $PcsPath) ) {
        write-serr "Missing precompiled script file ${PcsPath}" -Fatal
    }
    . "$PcsPath"
    write-smsg "included dependency: $PcsPath" -ok
   
}

function Import-Dependencies{
    $DependenciesPath = "$PSScriptRoot\Includes"
    If( -not (Test-Path $DependenciesPath) ) {
        write-serr "Missing Dependencies Path ${DependenciesPath}" -Fatal
    }
    $DepList = (Get-ChildItem -Path $DependenciesPath -File -Filter '*.ps1').Fullname
    foreach($dep in $DepList){
        . "$dep"
        write-smsg "included dependency: $dep" -ok
    }
}

$ScriptFullname = & { $myInvocation.ScriptName }

if($Script:UsePreCompiledDependencies){
    Import-PreCompiled    
}else{
    Import-Dependencies
}


[void] $Script:ListBox01.Items.Add('c:')
[void] $Script:ListBox01.Items.Add('x:')
$Script:ListBox01.SelectedIndex = 0

[void] $Script:ListBox02.Items.Add('MYDOC')
#[void] $Script:ListBox02.Items.Add('x:')
$Script:ListBox02.SelectedIndex = 0

$Script:Form.controls.AddRange(@($Script:Panel02,$Script:Panel01,$Script:Panel03,$Script:Panel04,$Script:Panel05,$Script:Panel06))
$Script:Panel01.controls.AddRange(@($Script:Label01,$Script:Button01,$Script:ListBox01,$Script:ListBox02,$Script:Button02,$Button03))
$Script:Panel02.controls.AddRange(@($Script:Label02,$Script:Button04))
$Script:Panel03.controls.AddRange(@($Script:Label03,$Script:Button05,$Script:Button06))
$Script:Panel04.controls.AddRange(@($Script:Label04,$Script:Button07))
$Script:Panel05.controls.AddRange(@($Script:Label05,$Script:Button08,$Script:Button09))
$Script:Panel06.controls.AddRange(@($Script:Label06,$Script:Button10,$Script:Button11,$Script:Button12,$Script:Button13,$Script:Button14))


#region gui events {
$Script:Button01.Add_Click( { 


    Script:Set-WellKnownPaths

    write-smsg "PowerShell Profile location is $Profile" -Ok

    } )

$Script:Button02.Add_Click( {
    Script:CreatePowerShellDirectoryStructure -WhatIf:$Script:TEST_MODE
 } ) 
$Script:Button03.Add_Click( {
    Set-RegistryOrganizationHKCU -WhatIf:$Script:TEST_MODE

 } ) 

$Script:Button04.Add_Click( {
    Set-SystemEnvironmentValues -WhatIf:$Script:TEST_MODE

 } ) 
$Script:Button06.Add_Click( { 
    Set-WellKnownPaths -WhatIf:$Script:TEST_MODE

    } ) 
$Script:Button08.Add_Click( { 
    
    } )  
$Script:Button05.Add_Click( { 
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

    } )  
$Script:Button07.Add_Click( { 
    Write-MMsg "PUSHD IN $Script:DEV_ROOT"
    pushd "$Script:DEV_ROOT"

    Write-Title 'Git Clone BuildAutomation'
    Invoke-GitClone 'BuildAutomation'
    Write-Title 'Git Clone DejaInsight'
    Invoke-GitClone 'DejaInsight'
    
    Write-MMsg "POPD GO OUT"
    popd
    
    } )  
$Script:Button13.Add_Click( { 


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

    } )   
$Script:Button14.Add_Click( {

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
 } )  
$Script:Button12.Add_Click( { } )
$Script:Button11.Add_Click( { } ) 
$Script:Button15.Add_Click( { } )
$Script:Button09.Add_Click( { } ) 
$Script:Button10.Add_Click( { } )




[void]$Script:Form.showdialog()


