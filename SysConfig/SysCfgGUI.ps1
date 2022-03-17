
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

$Script:Form.controls.AddRange(@($RegistryPanel,$DebloatPanel,$CortanaPanel,$EdgePanel,$DarkThemePanel,$OtherPanel))
$Script:DebloatPanel.controls.AddRange(@($Debloat,$CustomizeBlacklist,$RemoveAllBloatware,$RemoveBlacklistedBloatware))
$Script:RegistryPanel.controls.AddRange(@($Registry,$RevertChanges))
$Script:CortanaPanel.controls.AddRange(@($Cortana,$EnableCortana,$DisableCortana))
$Script:EdgePanel.controls.AddRange(@($EnableEdgePDFTakeover,$DisableEdgePDFTakeover,$Edge))
$Script:DarkThemePanel.controls.AddRange(@($Theme,$DisableDarkMode,$EnableDarkMode))
$Script:OtherPanel.controls.AddRange(@($Other,$RemoveOnedrive,$InstallNet35,$UnpinStartMenuTiles,$DisableTelemetry,$RemoveRegkeys))

#region gui events {
$Script:CustomizeBlacklist.Add_Click( { } )
$Script:RemoveBlacklistedBloatware.Add_Click( { } ) 
$Script:RevertChanges.Add_Click( { } ) 
$Script:DisableCortana.Add_Click( { } ) 
$Script:DisableEdgePDFTakeover.Add_Click( { } )  
$Script:EnableCortana.Add_Click( { } )  
$Script:EnableEdgePDFTakeover.Add_Click( { } )  
$Script:DisableTelemetry.Add_Click( { } )   
$Script:RemoveRegkeys.Add_Click( { } )  
$Script:UnpinStartMenuTiles.Add_Click( { } )
$Script:RemoveOnedrive.Add_Click( { } ) 
$Script:InstallNet35.Add_Click( { } )
$Script:EnableDarkMode.Add_Click( { } ) 
$Script:DisableDarkMode.Add_Click( { } )


[void]$Script:Form.ShowDialog()




