
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



$Script:Form.controls.AddRange(@($Script:Panel02,$Script:Panel01,$Script:Panel03,$Script:Panel04,$Script:Panel05,$Script:Panel06))
$Script:Panel01.controls.AddRange(@($Script:Label01,$Script:Button01,$Script:Button02,$Button03))
$Script:Panel02.controls.AddRange(@($Script:Label02,$Script:Button04))
$Script:Panel03.controls.AddRange(@($Script:Label03,$Script:Button05,$Script:Button06))
$Script:Panel04.controls.AddRange(@($Script:Label04,$Script:Button07))
$Script:Panel05.controls.AddRange(@($Script:Label05,$Script:Button08,$Script:Button09))
$Script:Panel06.controls.AddRange(@($Script:Label06,$Script:Button10,$Script:Button11,$Script:Button12,$Script:Button13,$Script:Button14))


#region gui events {
$Script:Button01.Add_Click( { } )
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


