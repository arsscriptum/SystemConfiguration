
<#
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

$Script:DebloatPanel                    = New-Object system.Windows.Forms.Panel
$Script:DebloatPanel.height             = 160
$Script:DebloatPanel.width              = 480
$Script:DebloatPanel.Anchor             = 'top,right,left'
$Script:DebloatPanel.location           = New-Object System.Drawing.Point(10,10)

$Script:RegistryPanel                   = New-Object system.Windows.Forms.Panel
$Script:RegistryPanel.height            = 80
$Script:RegistryPanel.width             = 480
$Script:RegistryPanel.Anchor            = 'top,right,left'
$Script:RegistryPanel.location          = New-Object System.Drawing.Point(10,180)

$Script:CortanaPanel                    = New-Object system.Windows.Forms.Panel
$Script:CortanaPanel.height             = 120
$Script:CortanaPanel.width              = 153
$Script:CortanaPanel.Anchor             = 'top,right,left'
$Script:CortanaPanel.location           = New-Object System.Drawing.Point(10,270)

$Script:EdgePanel                       = New-Object system.Windows.Forms.Panel
$Script:EdgePanel.height                = 120
$Script:EdgePanel.width                 = 154
$Script:EdgePanel.Anchor                = 'top,right,left'
$Script:EdgePanel.location              = New-Object System.Drawing.Point(173,270)
write-smsg "created EdgePanel" -ok
$Script:DarkThemePanel                  = New-Object system.Windows.Forms.Panel
$Script:DarkThemePanel.height           = 120
$Script:DarkThemePanel.width            = 153
$Script:DarkThemePanel.Anchor           = 'top,right,left'
$Script:DarkThemePanel.location         = New-Object System.Drawing.Point(337,270)
write-smsg "created DarkThemePanel" -ok
$Script:OtherPanel                      = New-Object system.Windows.Forms.Panel
$Script:OtherPanel.height               = 160
$Script:OtherPanel.width                = 480
$Script:OtherPanel.Anchor               = 'top,right,left'
$Script:OtherPanel.location             = New-Object System.Drawing.Point(10,400)
write-smsg "created OtherPanel" -ok
$Script:Script:Debloat                         = New-Object system.Windows.Forms.Label
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

$Script:Registry                        = New-Object system.Windows.Forms.Label
$Script:Registry.text                   = "REGISTRY CHANGES"
$Script:Registry.AutoSize               = $true
$Script:Registry.width                  = 457
$Script:Registry.height                 = 142
$Script:Registry.Anchor                 = 'top,right,left'
$Script:Registry.location               = New-Object System.Drawing.Point(10,10)
$Script:Registry.Font                   = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Registry.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:RevertChanges                    = New-Object system.Windows.Forms.Button
$Script:RevertChanges.FlatStyle          = 'Flat'
$Script:RevertChanges.text               = "REVERT REGISTRY CHANGES"
$Script:RevertChanges.width              = 460
$Script:RevertChanges.height             = 30
$Script:RevertChanges.Anchor             = 'top,right,left'
$Script:RevertChanges.location           = New-Object System.Drawing.Point(10,40)
$Script:RevertChanges.Font               = New-Object System.Drawing.Font('Consolas',9)
$Script:RevertChanges.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Cortana                         = New-Object system.Windows.Forms.Label
$Script:Cortana.text                    = "CORTANA"
$Script:Cortana.AutoSize                = $true
$Script:Cortana.width                   = 457
$Script:Cortana.height                  = 142
$Script:Cortana.Anchor                  = 'top,right,left'
$Script:Cortana.location                = New-Object System.Drawing.Point(10,10)
$Script:Cortana.Font                    = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Cortana.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

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

$Script:EnableEdgePDFTakeover           = New-Object system.Windows.Forms.Button
$Script:EnableEdgePDFTakeover.FlatStyle = 'Flat'
$Script:EnableEdgePDFTakeover.text      = "ENABLE"
$Script:EnableEdgePDFTakeover.width     = 134
$Script:EnableEdgePDFTakeover.height    = 30
$Script:EnableEdgePDFTakeover.Anchor    = 'top,right,left'
$Script:EnableEdgePDFTakeover.location  = New-Object System.Drawing.Point(10,40)
$Script:EnableEdgePDFTakeover.Font      = New-Object System.Drawing.Font('Consolas',9)
$Script:EnableEdgePDFTakeover.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:DisableEdgePDFTakeover             = New-Object system.Windows.Forms.Button
$Script:DisableEdgePDFTakeover.FlatStyle   = 'Flat'
$Script:DisableEdgePDFTakeover.text        = "DISABLE"
$Script:DisableEdgePDFTakeover.width       = 134
$Script:DisableEdgePDFTakeover.height      = 30
$Script:DisableEdgePDFTakeover.Anchor      = 'top,right,left'
$Script:DisableEdgePDFTakeover.location    = New-Object System.Drawing.Point(10,80)
$Script:DisableEdgePDFTakeover.Font        = New-Object System.Drawing.Font('Consolas',9)
$Script:DisableEdgePDFTakeover.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Theme                           = New-Object system.Windows.Forms.Label
$Script:Theme.text                      = "DARK THEME"
$Script:Theme.AutoSize                  = $true
$Script:Theme.width                     = 457
$Script:Theme.height                    = 142
$Script:Theme.Anchor                    = 'top,right,left'
$Script:Theme.location                  = New-Object System.Drawing.Point(10,10)
$Script:Theme.Font                      = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Theme.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

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

$Script:Other                           = New-Object system.Windows.Forms.Label
$Script:Other.text                      = "OTHER CHANGES & FIXES"
$Script:Other.AutoSize                  = $true
$Script:Other.width                     = 457
$Script:Other.height                    = 142
$Script:Other.Anchor                    = 'top,right,left'
$Script:Other.location                  = New-Object System.Drawing.Point(10,10)
$Script:Other.Font                      = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Other.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:RemoveOnedrive                  = New-Object system.Windows.Forms.Button
$Script:RemoveOnedrive.FlatStyle        = 'Flat'
$Script:RemoveOnedrive.text             = "UNINSTALL ONEDRIVE"
$Script:RemoveOnedrive.width            = 225
$Script:RemoveOnedrive.height           = 30
$Script:RemoveOnedrive.Anchor           = 'top,right,left'
$Script:RemoveOnedrive.location         = New-Object System.Drawing.Point(10,40)
$Script:RemoveOnedrive.Font             = New-Object System.Drawing.Font('Consolas',9)
$Script:RemoveOnedrive.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$UnpinStartMenuTiles             = New-Object system.Windows.Forms.Button
$UnpinStartMenuTiles.FlatStyle   = 'Flat'
$UnpinStartMenuTiles.text        = "UNPIN TILES FROM START MENU"
$UnpinStartMenuTiles.width       = 225
$UnpinStartMenuTiles.height      = 30
$UnpinStartMenuTiles.Anchor      = 'top,right,left'
$UnpinStartMenuTiles.location    = New-Object System.Drawing.Point(245,40)
$UnpinStartMenuTiles.Font        = New-Object System.Drawing.Font('Consolas',9)
$UnpinStartMenuTiles.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

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

#>