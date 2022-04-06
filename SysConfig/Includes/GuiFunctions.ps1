
# ============================================================================================================
# SCRIPT FUNCTIONS
# ============================================================================================================

Register-Assemblies
$Script:MessageBoxParams = @{
    Title = "Confirmation"
    TitleBackground = "Gray"
    TitleTextForeground = "MidnightBlue"
    TitleFontWeight = "UltraBold"
    TitleFontSize = 16
    ButtonType = "Yes-No"
}

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
    param (
        [Parameter(Position=0,Mandatory=$true)]
        [string]$Identifier
    ) 
  
         
    $OrgValue = $ENV:OrganizationHKCU
    Write-Host -n -f DarkRed "[SetRegistryOrganizationHKCU] "
    Write-Host -f DarkYellow " Identifier : $Identifier , current ENV:OrganizationHKCU is $OrgValue"
    $OrganizationHKCU = "HKCU:\Software\" + "$Identifier"

    $Text = "This will be the registry root path for all local development apps<LineBreak />
    <Bold>$OrganizationHKCU</Bold> <LineBreak />
"
    Show-MessageBox @MessageBoxParams -Content $Text
    $Prompt = Get-Variable -Name PWSHMessageBoxOutput -ValueOnly 
    if($Prompt -ne 'Yes') {
        return
    }

    $Null = New-Item -Path "$OrganizationHKCU" -ItemType Directory -Force -ErrorAction Ignore -WhatIf:$Script:TEST_MODE
    
    if($Script:TEST_MODE -eq $False){
        $ENV:OrganizationHKCU = "$OrganizationHKCU"
        [Environment]::SetEnvironmentVariable('OrganizationHKCU',$OrganizationHKCU,"User")
    }else{
        Write-Host -n -f DarkRed "[WhatIf] "
        Write-Host -f DarkYellow "ENV:OrganizationHKCU = `"$OrganizationHKCU`""
        Write-Host -n -f DarkRed "[WhatIf] "
        Write-Host -f DarkYellow "SetEnvironmentVariable(`"OrganizationHKCU`",$OrganizationHKCU,`"User`")"
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


function Script:SetSystemEnvironmentValues {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()

    $RegExe = (get-command 'reg.exe').Source

    if($Script:TEST_MODE -eq $False){
        &"$RegExe" "import" "$Script:REG_GLOBAL_ENV"
        write-smsg "Registry Import $Script:REG_GLOBAL_ENV"
        
        &"$RegExe" "import" "$Script:REG_USER_ENV"
        write-smsg "Registry Import $Script:REG_USER_ENV"
    }else{
        write-smsg "WhatIf : Registry Import $Script:REG_GLOBAL_ENV"
        write-smsg "WhatIf : Registry Import $Script:REG_USER_ENV"
    }
}

function Script:SetWellKnownPaths {

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

    
}



function Script:ClonePwshProfiles {

    [CmdletBinding(SupportsShouldProcess)]
    param
    ()
    
    $NewDir = ((New-TemporaryDirectory).Fullname)
    pushd $NewDir
    
    write-smsg "Cloning PowerShell.Profile"
    Invoke-GitClone 'PowerShell.Profile' -WhatIf:$Script:TEST_MODE 
    pushd 'PowerShell.Profile'
    write-smsg "COPY Microsoft.PowerShell_profile.ps1 --> to $Script:POWERSHELL_PATH"
    Copy-Item "Microsoft.PowerShell_profile.ps1" "$Script:POWERSHELL_PATH" -WhatIf:$Script:TEST_MODE 
    popd
    $Null=Remove-Item -Path "$Script:POWERSHELL_PATH\Profile" -Recurse -Force -ErrorAction Ignore -WhatIf:$Script:TEST_MODE 
    Copy-Item "PowerShell.Profile" "$Script:POWERSHELL_PATH\Profile" -Recurse -WhatIf:$Script:TEST_MODE 
}


function Script:RefreshEnvironmentVariables {

    [CmdletBinding(SupportsShouldProcess)]
    param()
    
    $Cmds = @('RefreshEnv.cmd','RefreshEnvironment.exe')
    ForEach($cmd in $Cmds){
        $CmdData = Get-Command "$cmd"
        if($CmdData){
            $RefreshEnv = $CmdData.Source
            Write-Title "Refreshing Environment Variables using $RefreshEnv"
            $Text = "Refresh Environment Variables using:<LineBreak /><LineBreak />
        <Bold>$RefreshEnv</Bold><LineBreak />
        <LineBreak />
"
            Show-MessageBox @MessageBoxParams -Content $Text
            &"$RefreshEnv"
        }
    } 
}


function RestartWithAdminPriv{

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


<#

Show-MessageBox: Cannot validate argument on parameter 'TitleTextForeground'. 
The argument "dBlue" does not belong to the set "AliceBlue,AntiqueWhite,Aqua,Aquamarine,Azure,
Beige,Bisque,Black,BlanchedAlmond,Blue,BlueViolet,Brown,BurlyWood,CadetBlue,Chartreuse,Chocolate,
Coral,CornflowerBlue,Cornsilk,Crimson,Cyan,DarkBlue,DarkCyan,DarkGoldenrod,DarkGray,DarkGreen,
DarkKhaki,DarkMagenta,DarkOliveGreen,DarkOrange,DarkOrchid,DarkRed,DarkSalmon,DarkSeaGreen,
DarkSlateBlue,DarkSlateGray,DarkTurquoise,DarkViolet,DeepPink,DeepSkyBlue,DimGray,DodgerBlue,
Firebrick,FloralWhite,ForestGreen,Fuchsia,Gainsboro,GhostWhite,Gold,Goldenrod,Gray,Green,GreenYellow,
Honeydew,HotPink,IndianRed,Indigo,Ivory,Khaki,Lavender,LavenderBlush,LawnGreen,LemonChiffon,
LightBlue,LightCoral,LightCyan,LightGoldenrodYellow,LightGray,LightGreen,LightPink,LightSalmon,
LightSeaGreen,LightSkyBlue,LightSlateGray,LightSteelBlue,LightYellow,Lime,LimeGreen,Linen,Magenta,
Maroon,MediumAquamarine,MediumBlue,MediumOrchid,MediumPurple,MediumSeaGreen,MediumSlateBlue,
MediumSpringGreen,MediumTurquoise,MediumVioletRed,MidnightBlue,MintCream,MistyRose,Moccasin,
NavajoWhite,Navy,OldLace,Olive,OliveDrab,Orange,OrangeRed,Orchid,PaleGoldenrod,PaleGreen,PaleTurquoise,PaleVioletRed,PapayaWhip,PeachPuff,Peru,Pink,Plum,PowderBlue,Purple,Red,RosyBrown,RoyalBlue,SaddleBrown,Salmon,SandyBrown,SeaGreen,SeaShell,Sienna,Silver,SkyBlue,SlateBlue,SlateGray,Snow,SpringGreen,SteelBlue,Tan,Teal,Thistle,Tomato,Transparent,Turquoise,Violet,Wheat,White,WhiteSmoke,Yellow,YellowGreen" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again.
#>