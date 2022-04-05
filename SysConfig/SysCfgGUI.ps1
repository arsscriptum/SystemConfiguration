
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
$Script:Label01                         = New-Object system.Windows.Forms.Label
$Script:Label01.text                    = "DEBLOAT OPTIONS"
$Script:Label01.AutoSize                = $true
$Script:Label01.width                   = 457
$Script:Label01.height                  = 142
$Script:Label01.Anchor                  = 'top,right,left'
$Script:Label01.location                = New-Object System.Drawing.Point(10,9)
$Script:Label01.Font                    = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label01.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button01             = New-Object system.Windows.Forms.Button
$Script:Button01.FlatStyle   = 'Flat'
$Script:Button01.text        = "CUSTOMISE BLOCKLIST"
$Script:Button01.width       = 460
$Script:Button01.height      = 30
$Script:Button01.Anchor      = 'top,right,left'
$Script:Button01.location    = New-Object System.Drawing.Point(10,40)
$Script:Button01.Font        = New-Object System.Drawing.Font('Consolas',9)
$Script:Button01.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button02              = New-Object system.Windows.Forms.Button
$Script:Button02.FlatStyle    = 'Flat'
$Script:Button02.text         = "REMOVE ALL BLOATWARE"
$Script:Button02.width        = 460
$Script:Button02.height       = 30
$Script:Button02.Anchor       = 'top,right,left'
$Script:Button02.location     = New-Object System.Drawing.Point(10,80)
$Script:Button02.Font         = New-Object System.Drawing.Font('Consolas',9)
$Script:Button02.ForeColor    = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button03                 = New-Object system.Windows.Forms.Button
$Script:Button03.FlatStyle       = 'Flat'
$Script:Button03.text            = "REMOVE BLOATWARE WITH CUSTOM BLOCKLIST"
$Script:Button03.width           = 460
$Script:Button03.height          = 30
$Script:Button03.Anchor          = 'top,right,left'
$Script:Button03.location        = New-Object System.Drawing.Point(10,120)
$Script:Button03.Font            = New-Object System.Drawing.Font('Consolas',9)
$Script:Button03.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label02                        = New-Object system.Windows.Forms.Label
$Script:Label02.text                   = "REGISTRY CHANGES"
$Script:Label02.AutoSize               = $true
$Script:Label02.width                  = 457
$Script:Label02.height                 = 142
$Script:Label02.Anchor                 = 'top,right,left'
$Script:Label02.location               = New-Object System.Drawing.Point(10,10)
$Script:Label02.Font                   = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label02.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button04                    = New-Object system.Windows.Forms.Button
$Script:Button04.FlatStyle          = 'Flat'
$Script:Button04.text               = "REVERT REGISTRY CHANGES"
$Script:Button04.width              = 460
$Script:Button04.height             = 30
$Script:Button04.Anchor             = 'top,right,left'
$Script:Button04.location           = New-Object System.Drawing.Point(10,40)
$Script:Button04.Font               = New-Object System.Drawing.Font('Consolas',9)
$Script:Button04.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label03                         = New-Object system.Windows.Forms.Label
$Script:Label03.text                    = "CORTANA"
$Script:Label03.AutoSize                = $true
$Script:Label03.width                   = 457
$Script:Label03.height                  = 142
$Script:Label03.Anchor                  = 'top,right,left'
$Script:Label03.location                = New-Object System.Drawing.Point(10,10)
$Script:Label03.Font                    = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label03.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button05                   = New-Object system.Windows.Forms.Button
$Script:Button05.FlatStyle         = 'Flat'
$Script:Button05.text              = "ENABLE"
$Script:Button05.width             = 133
$Script:Button05.height            = 30
$Script:Button05.Anchor            = 'top,right,left'
$Script:Button05.location          = New-Object System.Drawing.Point(10,40)
$Script:Button05.Font              = New-Object System.Drawing.Font('Consolas',9)
$Script:Button05.ForeColor         = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button06                  = New-Object system.Windows.Forms.Button
$Script:Button06.FlatStyle        = 'Flat'
$Script:Button06.text             = "DISABLE"
$Script:Button06.width            = 133
$Script:Button06.height           = 30
$Script:Button06.Anchor           = 'top,right,left'
$Script:Button06.location         = New-Object System.Drawing.Point(10,80)
$Script:Button06.Font             = New-Object System.Drawing.Font('Consolas',9)
$Script:Button06.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

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

$Script:Button07             = New-Object system.Windows.Forms.Button
$Script:Button07.FlatStyle   = 'Flat'
$Script:Button07.text        = "DISABLE"
$Script:Button07.width       = 134
$Script:Button07.height      = 30
$Script:Button07.Anchor      = 'top,right,left'
$Script:Button07.location    = New-Object System.Drawing.Point(10,80)
$Script:Button07.Font        = New-Object System.Drawing.Font('Consolas',9)
$Script:Button07.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label05                           = New-Object system.Windows.Forms.Label
$Script:Label05.text                      = "DARK THEME"
$Script:Label05.AutoSize                  = $true
$Script:Label05.width                     = 457
$Script:Label05.height                    = 142
$Script:Label05.Anchor                    = 'top,right,left'
$Script:Label05.location                  = New-Object System.Drawing.Point(10,10)
$Script:Label05.Font                      = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label05.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button09                  = New-Object system.Windows.Forms.Button
$Script:Button09.FlatStyle        = 'Flat'
$Script:Button09.text             = "ENABLE"
$Script:Button09.width            = 133
$Script:Button09.height           = 30
$Script:Button09.Anchor           = 'top,right,left'
$Script:Button09.location         = New-Object System.Drawing.Point(10,40)
$Script:Button09.Font             = New-Object System.Drawing.Font('Consolas',9)
$Script:Button09.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button08                 = New-Object system.Windows.Forms.Button
$Script:Button08.FlatStyle       = 'Flat'
$Script:Button08.text            = "DISABLE"
$Script:Button08.width           = 133
$Script:Button08.height          = 30
$Script:Button08.Anchor          = 'top,right,left'
$Script:Button08.location        = New-Object System.Drawing.Point(10,80)
$Script:Button08.Font            = New-Object System.Drawing.Font('Consolas',9)
$Script:Button08.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

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
$Script:Panel01.controls.AddRange(@($Script:Label01,$Script:Button01,$Script:Button02,$Button03))
$Script:Panel02.controls.AddRange(@($Script:Label02,$Script:Button04))
$Script:Panel03.controls.AddRange(@($Script:Label03,$Script:Button05,$Script:Button06))
$Script:Panel04.controls.AddRange(@($Script:Label04,$Script:Button07))
$Script:Panel05.controls.AddRange(@($Script:Label05,$Script:Button08,$Script:Button09))
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


