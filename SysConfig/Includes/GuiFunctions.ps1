
# ============================================================================================================
# SCRIPT FUNCTIONS
# ============================================================================================================


function Script:CreatePowerShellDirectoryStructure {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    Write-Title "CreatePowerShellDirectoryStructure"

    $Script:POWERSHELL_PATH         = Join-Path "$Script:MYDOCUMENTS_PATH" "PowerShell"
    $Script:PS_MODULES_PATH         = Join-Path "$Script:POWERSHELL_PATH" "Modules"
    $Script:PS_MODDEV_PATH          = Join-Path "$Script:POWERSHELL_PATH" "Module-Development"
    $Script:PS_PROFILE_PATH         = Join-Path "$Script:POWERSHELL_PATH" "Profile"
    $Script:PS_PROJECTS_PATH        = Join-Path "$Script:POWERSHELL_PATH" "Projects"

    write-smsg "MY DOCUMENTS:      $Script:MYDOCUMENTS_PATH"
    write-smsg "PowerShell Home:   $Script:POWERSHELL_PATH"
    write-smsg "Modules:           $Script:PS_MODULES_PATH"
    write-smsg "Modules Dev:       $Script:PS_MODDEV_PATH"
    write-smsg "Projects:          $Script:PS_PROJECTS_PATH"
    write-smsg "Profile:           $Script:PS_PROFILE_PATH"

    $Text = "These are the current paths:<LineBreak />
    <Bold>MY DOCUMENTS.......: $Script:MYDOCUMENTS_PATH </Bold> <LineBreak />
    PowerShell Home....: $Script:POWERSHELL_PATH <LineBreak />
    Modules............: $Script:PS_MODULES_PATH <LineBreak />
    Modules Dev........: $Script:PS_MODDEV_PATH <LineBreak />
    Projects...........: $Script:PS_PROJECTS_PATH <LineBreak />
    Profile............: $Script:PS_PROFILE_PATH <LineBreak />
    <LineBreak />
    They will be created if non existant...
"
     Register-Assemblies
    $MessageBoxParams = @{
        Title = "Confirmation"
        TitleBackground = "White"
        TitleTextForeground = "Blue"
        TitleFontWeight = "UltraBold"
        TitleFontSize = 20
        ButtonType = "Yes-No-Cancel"
    }

    Show-MessageBox @MessageBoxParams -Content $Text
    $Prompt = Get-Variable -Name PWSHMessageBoxOutput -ValueOnly 
    if($Prompt -ne 'Yes') {
        return
    }
                
    New-Item -Path "$Script:POWERSHELL_PATH" -ItemType Directory -Force -ErrorAction Ignore  -WhatIf:$Script:TEST_MODE| Out-Null ; Write-MOk "Created: $Script:POWERSHELL_PATH" ; 
    New-Item -Path "$Script:PS_MODULES_PATH" -ItemType Directory -Force -ErrorAction Ignore  -WhatIf:$Script:TEST_MODE| Out-Null ; Write-MOk "Created: $Script:PS_MODULES_PATH" ; 
    New-Item -Path "$Script:PS_MODDEV_PATH" -ItemType Directory -Force -ErrorAction Ignore  -WhatIf:$Script:TEST_MODE| Out-Null ; Write-MOk "Created: $Script:PS_MODDEV_PATH" ; 
    New-Item -Path "$Script:PS_PROJECTS_PATH" -ItemType Directory -Force -ErrorAction Ignore  -WhatIf:$Script:TEST_MODE| Out-Null ; Write-MOk "Created: $Script:PS_PROJECTS_PATH" ; 
    New-Item -Path "$Script:PS_PROFILE_PATH" -ItemType Directory -Force -ErrorAction Ignore  -WhatIf:$Script:TEST_MODE| Out-Null ; Write-MOk "Created: $Script:PS_PROFILE_PATH" ; 
}



function Script:SetRegistryOrganizationHKCU {

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [ValidateNotNullOrEmpty()][String]$OrgIdentifier = "_gp"
    )
     $OrganizationHKCU = "HKCU:\Software\" + "$OrgIdentifier"
    $Text = "The Registry Path from which development projects will be saved. 
    The common path for all personal projects will be : <LineBreak /> <LineBreak />
    <Bold> $OrganizationHKCU </Bold> <LineBreak /> <LineBreak /> <LineBreak />Continue ?<LineBreak />
"
     Register-Assemblies
    $MessageBoxParams = @{
        Title = "Confirmation"
        TitleBackground = "White"
        TitleTextForeground = "Blue"
        TitleFontWeight = "UltraBold"
        TitleFontSize = 20
        ButtonType = "Yes-No"
    }

    Show-MessageBox @MessageBoxParams -Content $Text
    $Prompt = Get-Variable -Name PWSHMessageBoxOutput -ValueOnly 
    if($Prompt -ne 'Yes') {
        return
    }
        
function Script:Set-RegistryOrganizationHKCU {

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
        $Null = New-Item -Path "$OrganizationHKCU" -ItemType Directory -Force -ErrorAction Ignore -WhatIf:$Script:TEST_MODE

        $Cmd = Get-Command "RefreshEnv.cmd"
        if($Cmd){
            $RefreshEnv = $Cmd.Source
            &"$RefreshEnv"
        }

        $ENV:OrganizationHKCU = "$OrganizationHKCU"

    }
}


function Script:Check-ValidateBeforeStart {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()
    if(-not(Test-Path -Path $Script:DEV_ROOT))              { write-serr "NOT EXISTING: $Script:DEVDRIVE" ; return $false;}
    if(-not(Test-Path -Path $Script:REG_USER_ENV))          { write-serr "NOT EXISTING: $Script:REG_USER_ENV"; return $false; }
    if(-not(Test-Path -Path $Script:REG_GLOBAL_ENV))        { write-serr "NOT EXISTING: $Script:REG_GLOBAL_ENV" ; return $false;}
    if(-not(Test-Path -Path $Script:OrganizationHKCUScript)){ write-serr "NOT EXISTING: $Script:OrganizationHKCUScript" ; return $false;}

    if(-not(Test-Path -Path $Script:WINGIT_SCRIPT_PATH))    { write-serr "NOT EXISTING: $Script:WINGIT_SCRIPT_PATH" ; return $false;}
    if(-not(Test-Path -Path $Script:CONFIGURE_SCRIPT_PATH)) { write-serr "NOT EXISTING: $Script:CONFIGURE_SCRIPT_PATH" ; return $false;}

    return $true;

}


function Script:Set-SystemEnvironmentValues {

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

function Script:Set-WellKnownPaths {

    [CmdletBinding(SupportsShouldProcess)]
    param()
    Write-Title "WELL KNOWN PATHS (DOCUMENTS, PICTURES, ETC)" 


    $Script:DATA_DRIVE  = $Script:ListBox01.SelectedItem
    write-smsg "Selected Root Drive is $Script:DATA_DRIVE"
    $Script:PROGRAMS_PATH           = Join-Path "$Script:DATA_DRIVE" "Programs"
    $Script:MYDOCUMENTS_PATH        = Join-Path "$Script:DATA_DRIVE" "DOCUMENTS"
    $Script:MYPICTURES_PATH         = Join-Path "$Script:DATA_DRIVE" "Data\Pictures"
    $Script:MYVIDEOS_PATH           = Join-Path "$Script:DATA_DRIVE" "Data\Videos"
    $Script:SCREENSHOTS_PATH        = Join-Path "$Script:DATA_DRIVE" "Data\Pictures\Screenshots"
    $Script:DOWNLOAD_PATH           = Join-Path "$Script:DATA_DRIVE" "Data\Downloads"
    $Script:DESKTOP_PATH            = Join-Path "$Script:DATA_DRIVE" "Data\Windows\Desktop"

    write-smsg "Desktop:         $Script:DESKTOP_PATH"
    write-smsg "Pictures:        $Script:MYPICTURES_PATH"
    write-smsg "Screenshots:     $Script:SCREENSHOTS_PATH"
    write-smsg "Download:        $Script:DOWNLOAD_PATH"
    write-smsg "Documents:       $Script:MYDOCUMENTS_PATH"
    write-smsg "Videos:          $Script:MYVIDEOS_PATH"
 

    $Text = "These are the current paths:<LineBreak /><LineBreak />
    <Bold>* My Documents..: $Script:MYDOCUMENTS_PATH </Bold> <LineBreak /> (PowerShell Paths are based on this) <LineBreak />
     Desktop........: $Script:DESKTOP_PATH<LineBreak />
     Pictures.......: $Script:MYPICTURES_PATH <LineBreak />
     Screenshots....: $Script:SCREENSHOTS_PATH <LineBreak />
     Download.......: $Script:DOWNLOAD_PATH <LineBreak />
     Videos.........: $Script:MYVIDEOS_PATH <LineBreak />
    <LineBreak />
    They will be created if non existant...
"
     Register-Assemblies
    $MessageBoxParams = @{
        Title = "Confirmation"
        TitleBackground = "White"
        TitleTextForeground = "Blue"
        TitleFontWeight = "UltraBold"
        TitleFontSize = 20

        ButtonType = "Yes-No-Cancel"
    }

    Show-MessageBox @MessageBoxParams -Content $Text
    $Prompt = Get-Variable -Name PWSHMessageBoxOutput -ValueOnly 
    if($Prompt -ne 'Yes') {
        return
    }
     


    New-Item -Path "$Script:DESKTOP_PATH" -ItemType Directory -Force -ErrorAction Ignore -WhatIf:$Script:TEST_MODE | Out-Null
    New-Item -Path "$Script:MYPICTURES_PATH" -ItemType Directory -Force -ErrorAction Ignore  -WhatIf:$Script:TEST_MODE | Out-Null
    New-Item -Path "$Script:SCREENSHOTS_PATH" -ItemType Directory -Force -ErrorAction Ignore  -WhatIf:$Script:TEST_MODE | Out-Null
    New-Item -Path "$Script:DOWNLOAD_PATH" -ItemType Directory -Force -ErrorAction Ignore  -WhatIf:$Script:TEST_MODE | Out-Null
    New-Item -Path "$Script:MYDOCUMENTS_PATH" -ItemType Directory -Force -ErrorAction Ignore -WhatIf:$Script:TEST_MODE  | Out-Null
    New-Item -Path "$Script:MYVIDEOS_PATH" -ItemType Directory -Force -ErrorAction Ignore -WhatIf:$Script:TEST_MODE  | Out-Null
    New-Item -Path "$Script:POWERSHELL_PATH" -ItemType Directory -Force -ErrorAction Ignore -WhatIf:$Script:TEST_MODE  | Out-Null
    $RegPathShellFolders = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders'
        
    New-ItemProperty "$RegPathShellFolders" Personal -Value "$Script:MYDOCUMENTS_PATH" -Type ExpandString -Force -WhatIf:$Script:TEST_MODE  | Out-Null
    Set-ItemProperty "$RegPathShellFolders" Desktop -Value "$Script:DESKTOP_PATH" -Type ExpandString -Force -WhatIf:$Script:TEST_MODE  | Out-Null
    Set-ItemProperty "$RegPathShellFolders" 'My Pictures' -Value "$Script:MYPICTURES_PATH" -Type ExpandString -Force -WhatIf:$Script:TEST_MODE  | Out-Null
    Set-ItemProperty "$RegPathShellFolders" 'My Video' -Value "$Script:MYVIDEOS_PATH" -Type ExpandString -Force -WhatIf:$Script:TEST_MODE  | Out-Null
         
    $RegPathShellFolders = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
        
    New-ItemProperty "$RegPathShellFolders" Personal -Value "$Script:MYDOCUMENTS_PATH" -Type ExpandString -Force  -WhatIf:$Script:TEST_MODE | Out-Null
    Set-ItemProperty "$RegPathShellFolders" Desktop -Value "$Script:DESKTOP_PATH" -Type ExpandString -Force -WhatIf:$Script:TEST_MODE  | Out-Null
    Set-ItemProperty "$RegPathShellFolders" 'My Pictures' -Value "$Script:MYPICTURES_PATH" -Type ExpandString -Force -WhatIf:$Script:TEST_MODE  | Out-Null
    Set-ItemProperty "$RegPathShellFolders" 'My Video' -Value "$Script:MYVIDEOS_PATH" -Type ExpandString -Force  -WhatIf:$Script:TEST_MODE | Out-Null

    
<<<<<<< HEAD
}





function Script:Restart-WithAdminPriv{
    [CmdletBinding(SupportsShouldProcess)]
    param()
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

