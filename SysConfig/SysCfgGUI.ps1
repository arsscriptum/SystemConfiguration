
$ErrorActionPreference = 'SilentlyContinue'
$Script:UsePreCompiledDependencies = $False
Register-Assemblies

function write-serr([string]$msg,[switch]$fatal){    
    Write-Host -n "❗❗❗ "; Write-Host -f DarkYellow "$msg"
    if($fatal){ exit; }
}

function write-smsg([string]$msg,[switch]$ok=$false){
    if($ok){Write-Host -n "✅ "; }else{ Write-Host -n "⚡ "; }
    Write-Host " $msg"
}


function Import-PreCompiled{
    $PcsPath = "$PSScriptRoot\pcs.ps1"
    If( -not (Test-Path $PcsPath) ) {
        write-serr "Missing precompiled script file ${PcsPath}" -Fatal
    }
    . "$PcsPath"
    write-smsg "included dependency: $PcsPath" -ok
   
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

$Script:Form.controls.AddRange(@($Script:Panel02,$Script:Panel01,$Script:Panel03,$Script:Panel04,$Script:Panel05,$Script:Panel06))
$Script:Panel01.controls.AddRange(@($Script:Label01,$Script:Button01,$Script:ListBox01,$Script:Button02,$Button03))
$Script:Panel02.controls.AddRange(@($Script:Label02,$Script:Button04))
$Script:Panel03.controls.AddRange(@($Script:Label03,$Script:Button05,$Script:Button06))
$Script:Panel04.controls.AddRange(@($Script:Label04,$Script:Button07))
$Script:Panel05.controls.AddRange(@($Script:Label05,$Script:Button08,$Script:Button09))
$Script:Panel06.controls.AddRange(@($Script:Label06,$Script:Button10,$Script:Button11,$Script:Button12,$Script:Button13,$Script:Button14))


#region gui events {
$Script:Button01.Add_Click( { 

    $Script:DATA_DRIVE  = $Script:ListBox01.SelectedItem
    write-smsg "DATA_DRIVE is $Script:DATA_DRIVE ..."

        
    $Script:PROGRAMS_PATH           = Join-Path "$Script:DATA_DRIVE" "Programs"
    $Script:MYDOCUMENTS_PATH        = Join-Path "$Script:DATA_DRIVE" "DOCUMENTS"
    $Script:MYPICTURES_PATH         = Join-Path "$Script:DATA_DRIVE" "Data\Pictures"
    $Script:MYVIDEOS_PATH           = Join-Path "$Script:DATA_DRIVE" "Data\Videos"
    $Script:SCREENSHOTS_PATH        = Join-Path "$Script:DATA_DRIVE" "Data\Pictures\Screenshots"
    $Script:DOWNLOAD_PATH           = Join-Path "$Script:DATA_DRIVE" "Data\Downloads"
    $Script:DESKTOP_PATH            = Join-Path "$Script:DATA_DRIVE" "Data\Windows\Desktop"


    Write-Title "WELL KNOWN PATHS (DOCUMENTS, PICTURES, ETC)"

    write-smsg "Desktop:         $Script:DESKTOP_PATH"
    write-smsg "Pictures:        $Script:MYPICTURES_PATH"
    write-smsg "Screenshots:     $Script:SCREENSHOTS_PATH"
    write-smsg "Download:        $Script:DOWNLOAD_PATH"
    write-smsg "Documents:       $Script:MYDOCUMENTS_PATH"
    write-smsg "Videos:          $Script:MYVIDEOS_PATH"



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

    } )
$Script:Button03.Add_Click( { } ) 
$Script:Button04.Add_Click( { } ) 
$Script:Button06.Add_Click( { } ) 
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

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(35,35)
$Button.Size = New-Object System.Drawing.Size(120,23)
$Button.Text = "Show Dialog Box"
$Button.Add_Click($Button_Click)


[void]$Script:Form.showdialog()


