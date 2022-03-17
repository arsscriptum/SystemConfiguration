
$ErrorActionPreference = 'SilentlyContinue'


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

Import-PreCompiled

$Script:Form.controls.AddRange(@($RegistryPanel,$Label01Panel,$PanelObj04,$PanelObj05,$PanelObj06,$PanelObj07))
$Script:Label01Panel.controls.AddRange(@($Label01,$Button01,$Button02,$Button03))
$Script:Label03Panel.controls.AddRange(@($Registry,$Button04))
$Script:PanelObj04.controls.AddRange(@($Label04,$Button05,$Button06))
$Script:PanelObj05.controls.AddRange(@($Button07,$Button08,$Label05))
$Script:PanelObj06.controls.AddRange(@($Label06,$Button10,$Button09))
$Script:PanelObj07.controls.AddRange(@($Label07,$Button11,$Button15,$Button12,$Button13,$Button14))

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


[void]$Script:Form.ShowDialog()




