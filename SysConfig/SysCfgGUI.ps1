

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

# ============================================================================================================
#  GUI COMPONENTS
# ============================================================================================================

[void] $Script:ListBox01.Items.Add('c:')
[void] $Script:ListBox01.Items.Add('x:')
$Script:ListBox01.SelectedIndex = 0

$Script:TextBox01.Text = '_gp'

$Script:Form.controls.AddRange(@($Script:Panel02,$Script:Panel01,$Script:Panel03,$Script:Panel04,$Script:Panel05,$Script:Panel06))
$Script:Panel01.controls.AddRange(@($Script:Label01,$Script:Button01,$Script:ListBox01,$Script:TextBox01,$Script:Button02,$Button03,$Button31))
$Script:Panel02.controls.AddRange(@($Script:Label02,$Script:Button04))
$Script:Panel03.controls.AddRange(@($Script:Label03,$Script:Button05,$Script:Button06))
$Script:Panel04.controls.AddRange(@($Script:Label04,$Script:Button07))
$Script:Panel05.controls.AddRange(@($Script:Label05,$Script:Button08,$Script:Button09))
$Script:Panel06.controls.AddRange(@($Script:Label06,$Script:Button10,$Script:Button11,$Script:Button12,$Script:Button13,$Script:Button14))


# ============================================================================================================
#  GUI EVENTS
# ============================================================================================================

$Script:Button01.Add_Click( { Script:Set-WellKnownPaths } )
$Script:Button02.Add_Click( { Script:CreatePowerShellDirectoryStructure -WhatIf:$Script:TEST_MODE } ) 
$Script:Button03.Add_Click( { Set-RegistryOrganizationHKCU -WhatIf:$Script:TEST_MODE } ) 
$Script:Button04.Add_Click( { Set-SystemEnvironmentValues -WhatIf:$Script:TEST_MODE } ) 
$Script:Button06.Add_Click( { Set-WellKnownPaths -WhatIf:$Script:TEST_MODE } ) 

$Script:Button08.Add_Click( { } )  
$Script:Button05.Add_Click( { } )  
$Script:Button07.Add_Click( { } )  
$Script:Button13.Add_Click( { } )   
$Script:Button14.Add_Click( { } )  
$Script:Button12.Add_Click( { } )
$Script:Button11.Add_Click( { } ) 
$Script:Button15.Add_Click( { } )
$Script:Button09.Add_Click( { } ) 
$Script:Button10.Add_Click( { } )


[void]$Script:Form.showdialog()


