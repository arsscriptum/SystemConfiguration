
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



$Script:Form                            = New-Object system.Windows.Forms.Form
$Script:Form.ClientSize                 = New-Object System.Drawing.Point(500,570)
$Script:Form.StartPosition              = 'CenterScreen'
$Script:Form.FormBorderStyle            = 'FixedSingle'
$Script:Form.MinimizeBox                = $false
$Script:Form.MaximizeBox                = $false
$Script:Form.ShowIcon                   = $false
$Script:Form.text                       = "Windows10Debloater"
$Script:Form.TopMost                    = $false
$Script:Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#252525")

$Script:Panel01                    = New-Object system.Windows.Forms.Panel
$Script:Panel01.height             = 160
$Script:Panel01.width              = 480
$Script:Panel01.Anchor             = 'top,right,left'
$Script:Panel01.location           = New-Object System.Drawing.Point(10,10)

$Script:Panel02                   = New-Object system.Windows.Forms.Panel
$Script:Panel02.height            = 80
$Script:Panel02.width             = 480
$Script:Panel02.Anchor            = 'top,right,left'
$Script:Panel02.location          = New-Object System.Drawing.Point(10,180)

$Script:Panel03                    = New-Object system.Windows.Forms.Panel
$Script:Panel03.height             = 120
$Script:Panel03.width              = 153
$Script:Panel03.Anchor             = 'top,right,left'
$Script:Panel03.location           = New-Object System.Drawing.Point(10,270)

$Script:Panel04                       = New-Object system.Windows.Forms.Panel
$Script:Panel04.height                = 120
$Script:Panel04.width                 = 154
$Script:Panel04.Anchor                = 'top,right,left'
$Script:Panel04.location              = New-Object System.Drawing.Point(173,270)
write-smsg "created EdgePanel" -ok
$Script:Panel05                  = New-Object system.Windows.Forms.Panel
$Script:Panel05.height           = 120
$Script:Panel05.width            = 153
$Script:Panel05.Anchor           = 'top,right,left'
$Script:Panel05.location         = New-Object System.Drawing.Point(337,270)
write-smsg "created DarkThemePanel" -ok
$Script:Panel06                      = New-Object system.Windows.Forms.Panel
$Script:Panel06.height               = 160
$Script:Panel06.width                = 480
$Script:Panel06.Anchor               = 'top,right,left'
$Script:Panel06.location             = New-Object System.Drawing.Point(10,400)
write-smsg "created OtherPanel" -ok
$Script:Debloat                         = New-Object system.Windows.Forms.Label
$Script:Debloat.text                    = "DEBLOAT OPTIONS"
$Script:Debloat.AutoSize                = $true
$Script:Debloat.width                   = 457
$Script:Debloat.height                  = 142
$Script:Debloat.Anchor                  = 'top,right,left'
$Script:Debloat.location                = New-Object System.Drawing.Point(10,9)
$Script:Debloat.Font                    = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Debloat.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:CustomizeBlacklist             = New-Object system.Windows.Forms.Button
$Script:CustomizeBlacklist.FlatStyle   = 'Flat'
$Script:CustomizeBlacklist.text        = "CUSTOMISE BLOCKLIST"
$Script:CustomizeBlacklist.width       = 460
$Script:CustomizeBlacklist.height      = 30
$Script:CustomizeBlacklist.Anchor      = 'top,right,left'
$Script:CustomizeBlacklist.location    = New-Object System.Drawing.Point(10,40)
$Script:CustomizeBlacklist.Font        = New-Object System.Drawing.Font('Consolas',9)
$Script:CustomizeBlacklist.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:RemoveAllBloatware              = New-Object system.Windows.Forms.Button
$Script:RemoveAllBloatware.FlatStyle    = 'Flat'
$Script:RemoveAllBloatware.text         = "REMOVE ALL BLOATWARE"
$Script:RemoveAllBloatware.width        = 460
$Script:RemoveAllBloatware.height       = 30
$Script:RemoveAllBloatware.Anchor       = 'top,right,left'
$Script:RemoveAllBloatware.location     = New-Object System.Drawing.Point(10,80)
$Script:RemoveAllBloatware.Font         = New-Object System.Drawing.Font('Consolas',9)
$Script:RemoveAllBloatware.ForeColor    = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:RemoveBlacklistedBloatware                 = New-Object system.Windows.Forms.Button
$Script:RemoveBlacklistedBloatware.FlatStyle       = 'Flat'
$Script:RemoveBlacklistedBloatware.text            = "REMOVE BLOATWARE WITH CUSTOM BLOCKLIST"
$Script:RemoveBlacklistedBloatware.width           = 460
$Script:RemoveBlacklistedBloatware.height          = 30
$Script:RemoveBlacklistedBloatware.Anchor          = 'top,right,left'
$Script:RemoveBlacklistedBloatware.location        = New-Object System.Drawing.Point(10,120)
$Script:RemoveBlacklistedBloatware.Font            = New-Object System.Drawing.Font('Consolas',9)
$Script:RemoveBlacklistedBloatware.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label02                        = New-Object system.Windows.Forms.Label
$Script:Label02.text                   = "REGISTRY CHANGES"
$Script:Label02.AutoSize               = $true
$Script:Label02.width                  = 457
$Script:Label02.height                 = 142
$Script:Label02.Anchor                 = 'top,right,left'
$Script:Label02.location               = New-Object System.Drawing.Point(10,10)
$Script:Label02.Font                   = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label02.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:RevertChanges                    = New-Object system.Windows.Forms.Button
$Script:RevertChanges.FlatStyle          = 'Flat'
$Script:RevertChanges.text               = "REVERT REGISTRY CHANGES"
$Script:RevertChanges.width              = 460
$Script:RevertChanges.height             = 30
$Script:RevertChanges.Anchor             = 'top,right,left'
$Script:RevertChanges.location           = New-Object System.Drawing.Point(10,40)
$Script:RevertChanges.Font               = New-Object System.Drawing.Font('Consolas',9)
$Script:RevertChanges.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label03                         = New-Object system.Windows.Forms.Label
$Script:Label03.text                    = "CORTANA"
$Script:Label03.AutoSize                = $true
$Script:Label03.width                   = 457
$Script:Label03.height                  = 142
$Script:Label03.Anchor                  = 'top,right,left'
$Script:Label03.location                = New-Object System.Drawing.Point(10,10)
$Script:Label03.Font                    = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label03.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:EnableCortana                   = New-Object system.Windows.Forms.Button
$Script:EnableCortana.FlatStyle         = 'Flat'
$Script:EnableCortana.text              = "ENABLE"
$Script:EnableCortana.width             = 133
$Script:EnableCortana.height            = 30
$Script:EnableCortana.Anchor            = 'top,right,left'
$Script:EnableCortana.location          = New-Object System.Drawing.Point(10,40)
$Script:EnableCortana.Font              = New-Object System.Drawing.Font('Consolas',9)
$Script:EnableCortana.ForeColor         = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:DisableCortana                  = New-Object system.Windows.Forms.Button
$Script:DisableCortana.FlatStyle        = 'Flat'
$Script:DisableCortana.text             = "DISABLE"
$Script:DisableCortana.width            = 133
$Script:DisableCortana.height           = 30
$Script:DisableCortana.Anchor           = 'top,right,left'
$Script:DisableCortana.location         = New-Object System.Drawing.Point(10,80)
$Script:DisableCortana.Font             = New-Object System.Drawing.Font('Consolas',9)
$Script:DisableCortana.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Edge                            = New-Object system.Windows.Forms.Label
$Script:Edge.text                       = "EDGE PDF"
$Script:Edge.AutoSize                   = $true
$Script:Edge.width                      = 457
$Script:Edge.height                     = 142
$Script:Edge.Anchor                     = 'top,right,left'
$Script:Edge.location                   = New-Object System.Drawing.Point(10,10)
$Script:Edge.Font                       = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Edge.ForeColor                  = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label04           = New-Object system.Windows.Forms.Button
$Script:Label04.FlatStyle = 'Flat'
$Script:Label04.text      = "ENABLE"
$Script:Label04.width     = 134
$Script:Label04.height    = 30
$Script:Label04.Anchor    = 'top,right,left'
$Script:Label04.location  = New-Object System.Drawing.Point(10,40)
$Script:Label04.Font      = New-Object System.Drawing.Font('Consolas',9)
$Script:Label04.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:DisableEdgePDFTakeover             = New-Object system.Windows.Forms.Button
$Script:DisableEdgePDFTakeover.FlatStyle   = 'Flat'
$Script:DisableEdgePDFTakeover.text        = "DISABLE"
$Script:DisableEdgePDFTakeover.width       = 134
$Script:DisableEdgePDFTakeover.height      = 30
$Script:DisableEdgePDFTakeover.Anchor      = 'top,right,left'
$Script:DisableEdgePDFTakeover.location    = New-Object System.Drawing.Point(10,80)
$Script:DisableEdgePDFTakeover.Font        = New-Object System.Drawing.Font('Consolas',9)
$Script:DisableEdgePDFTakeover.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label05                           = New-Object system.Windows.Forms.Label
$Script:Label05.text                      = "DARK THEME"
$Script:Label05.AutoSize                  = $true
$Script:Label05.width                     = 457
$Script:Label05.height                    = 142
$Script:Label05.Anchor                    = 'top,right,left'
$Script:Label05.location                  = New-Object System.Drawing.Point(10,10)
$Script:Label05.Font                      = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label05.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:EnableDarkMode                  = New-Object system.Windows.Forms.Button
$Script:EnableDarkMode.FlatStyle        = 'Flat'
$Script:EnableDarkMode.text             = "ENABLE"
$Script:EnableDarkMode.width            = 133
$Script:EnableDarkMode.height           = 30
$Script:EnableDarkMode.Anchor           = 'top,right,left'
$Script:EnableDarkMode.location         = New-Object System.Drawing.Point(10,40)
$Script:EnableDarkMode.Font             = New-Object System.Drawing.Font('Consolas',9)
$Script:EnableDarkMode.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:DisableDarkMode                 = New-Object system.Windows.Forms.Button
$Script:DisableDarkMode.FlatStyle       = 'Flat'
$Script:DisableDarkMode.text            = "DISABLE"
$Script:DisableDarkMode.width           = 133
$Script:DisableDarkMode.height          = 30
$Script:DisableDarkMode.Anchor          = 'top,right,left'
$Script:DisableDarkMode.location        = New-Object System.Drawing.Point(10,80)
$Script:DisableDarkMode.Font            = New-Object System.Drawing.Font('Consolas',9)
$Script:DisableDarkMode.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label06                           = New-Object system.Windows.Forms.Label
$Script:Label06.text                      = "OTHER CHANGES & FIXES"
$Script:Label06.AutoSize                  = $true
$Script:Label06.width                     = 457
$Script:Label06.height                    = 142
$Script:Label06.Anchor                    = 'top,right,left'
$Script:Label06.location                  = New-Object System.Drawing.Point(10,10)
$Script:Label06.Font                      = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label06.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:RemoveOnedrive                  = New-Object system.Windows.Forms.Button
$Script:RemoveOnedrive.FlatStyle        = 'Flat'
$Script:RemoveOnedrive.text             = "UNINSTALL ONEDRIVE"
$Script:RemoveOnedrive.width            = 225
$Script:RemoveOnedrive.height           = 30
$Script:RemoveOnedrive.Anchor           = 'top,right,left'
$Script:RemoveOnedrive.location         = New-Object System.Drawing.Point(10,40)
$Script:RemoveOnedrive.Font             = New-Object System.Drawing.Font('Consolas',9)
$Script:RemoveOnedrive.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:UnpinStartMenuTiles             = New-Object system.Windows.Forms.Button
$Script:UnpinStartMenuTiles.FlatStyle   = 'Flat'
$Script:UnpinStartMenuTiles.text        = "UNPIN TILES FROM START MENU"
$Script:UnpinStartMenuTiles.width       = 225
$Script:UnpinStartMenuTiles.height      = 30
$Script:UnpinStartMenuTiles.Anchor      = 'top,right,left'
$Script:UnpinStartMenuTiles.location    = New-Object System.Drawing.Point(245,40)
$Script:UnpinStartMenuTiles.Font        = New-Object System.Drawing.Font('Consolas',9)
$Script:UnpinStartMenuTiles.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:DisableTelemetry                = New-Object system.Windows.Forms.Button
$Script:DisableTelemetry.FlatStyle      = 'Flat'
$Script:DisableTelemetry.text           = "DISABLE TELEMETRY / TASKS"
$Script:DisableTelemetry.width          = 225
$Script:DisableTelemetry.height         = 30
$Script:DisableTelemetry.Anchor         = 'top,right,left'
$Script:DisableTelemetry.location       = New-Object System.Drawing.Point(10,80)
$Script:DisableTelemetry.Font           = New-Object System.Drawing.Font('Consolas',9)
$Script:DisableTelemetry.ForeColor      = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:RemoveRegkeys                   = New-Object system.Windows.Forms.Button
$Script:RemoveRegkeys.FlatStyle         = 'Flat'
$Script:RemoveRegkeys.text              = "REMOVE BLOATWARE REGKEYS"
$Script:RemoveRegkeys.width             = 225
$Script:RemoveRegkeys.height            = 30
$Script:RemoveRegkeys.Anchor            = 'top,right,left'
$Script:RemoveRegkeys.location          = New-Object System.Drawing.Point(245,80)
$Script:RemoveRegkeys.Font              = New-Object System.Drawing.Font('Consolas',9)
$Script:RemoveRegkeys.ForeColor         = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:InstallNet35                    = New-Object system.Windows.Forms.Button
$Script:InstallNet35.FlatStyle          = 'Flat'
$Script:InstallNet35.text               = "INSTALL .NET V3.5"
$Script:InstallNet35.width              = 460
$Script:InstallNet35.height             = 30
$Script:InstallNet35.Anchor             = 'top,right,left'
$Script:InstallNet35.location           = New-Object System.Drawing.Point(10,120)
$Script:InstallNet35.Font               = New-Object System.Drawing.Font('Consolas',9)
$Script:InstallNet35.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
$Script:Form.controls.AddRange(@($Script:Panel02,$Label01Panel,$PanelObj04,$PanelObj05,$PanelObj06,$PanelObj07))

$Form.controls.AddRange(@($Script:Panel02,$Script:Panel01,$Script:Panel03,$Script:Panel04,$Script:Panel05,$Script:Panel06))
$Script:Panel01.controls.AddRange(@($Script:Debloat,$Script:CustomizeBlacklist,$Script:RemoveAllBloatware,$RemoveBlacklistedBloatware))
$Script:Panel02.controls.AddRange(@($Script:Label02,$Script:RevertChanges))
$Script:Panel03.controls.AddRange(@($Script:Label03,$Script:EnableCortana,$Script:DisableCortana))
$Script:Panel04.controls.AddRange(@($Script:Label04,$Script:DisableEdgePDFTakeover))
$Script:Panel05.controls.AddRange(@($Script:Label05,$Script:DisableDarkMode,$Script:EnableDarkMode))
$Script:Panel06.controls.AddRange(@($Script:Label06,$Script:RemoveOnedrive,$Script:InstallNet35,$Script:UnpinStartMenuTiles,$Script:DisableTelemetry,$RemoveRegkeys))


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

[void]$Script:Form.Controls.Add($Script:Button10)


[void]$Script:Form.showdialog()


