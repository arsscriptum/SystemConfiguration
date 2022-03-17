

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(500,570)
$Form.StartPosition              = 'CenterScreen'
$Form.FormBorderStyle            = 'FixedSingle'
$Form.MinimizeBox                = $false
$Form.MaximizeBox                = $false
$Form.ShowIcon                   = $false
$Form.text                       = "Windows10Debloater"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#252525")

$DebloatPanel                    = New-Object system.Windows.Forms.Panel
$DebloatPanel.height             = 160
$DebloatPanel.width              = 480
$DebloatPanel.Anchor             = 'top,right,left'
$DebloatPanel.location           = New-Object System.Drawing.Point(10,10)

$RegistryPanel                   = New-Object system.Windows.Forms.Panel
$RegistryPanel.height            = 80
$RegistryPanel.width             = 480
$RegistryPanel.Anchor            = 'top,right,left'
$RegistryPanel.location          = New-Object System.Drawing.Point(10,180)

$CortanaPanel                    = New-Object system.Windows.Forms.Panel
$CortanaPanel.height             = 120
$CortanaPanel.width              = 153
$CortanaPanel.Anchor             = 'top,right,left'
$CortanaPanel.location           = New-Object System.Drawing.Point(10,270)

$EdgePanel                       = New-Object system.Windows.Forms.Panel
$EdgePanel.height                = 120
$EdgePanel.width                 = 154
$EdgePanel.Anchor                = 'top,right,left'
$EdgePanel.location              = New-Object System.Drawing.Point(173,270)

$DarkThemePanel                  = New-Object system.Windows.Forms.Panel
$DarkThemePanel.height           = 120
$DarkThemePanel.width            = 153
$DarkThemePanel.Anchor           = 'top,right,left'
$DarkThemePanel.location         = New-Object System.Drawing.Point(337,270)

$OtherPanel                      = New-Object system.Windows.Forms.Panel
$OtherPanel.height               = 160
$OtherPanel.width                = 480
$OtherPanel.Anchor               = 'top,right,left'
$OtherPanel.location             = New-Object System.Drawing.Point(10,400)

$Debloat                         = New-Object system.Windows.Forms.Label
$Debloat.text                    = "DEBLOAT OPTIONS"
$Debloat.AutoSize                = $true
$Debloat.width                   = 457
$Debloat.height                  = 142
$Debloat.Anchor                  = 'top,right,left'
$Debloat.location                = New-Object System.Drawing.Point(10,9)
$Debloat.Font                    = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Debloat.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$CustomizeBlacklist             = New-Object system.Windows.Forms.Button
$CustomizeBlacklist.FlatStyle   = 'Flat'
$CustomizeBlacklist.text        = "CUSTOMISE BLOCKLIST"
$CustomizeBlacklist.width       = 460
$CustomizeBlacklist.height      = 30
$CustomizeBlacklist.Anchor      = 'top,right,left'
$CustomizeBlacklist.location    = New-Object System.Drawing.Point(10,40)
$CustomizeBlacklist.Font        = New-Object System.Drawing.Font('Consolas',9)
$CustomizeBlacklist.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$RemoveAllBloatware              = New-Object system.Windows.Forms.Button
$RemoveAllBloatware.FlatStyle    = 'Flat'
$RemoveAllBloatware.text         = "REMOVE ALL BLOATWARE"
$RemoveAllBloatware.width        = 460
$RemoveAllBloatware.height       = 30
$RemoveAllBloatware.Anchor       = 'top,right,left'
$RemoveAllBloatware.location     = New-Object System.Drawing.Point(10,80)
$RemoveAllBloatware.Font         = New-Object System.Drawing.Font('Consolas',9)
$RemoveAllBloatware.ForeColor    = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$RemoveBlacklistedBloatware                 = New-Object system.Windows.Forms.Button
$RemoveBlacklistedBloatware.FlatStyle       = 'Flat'
$RemoveBlacklistedBloatware.text            = "REMOVE BLOATWARE WITH CUSTOM BLOCKLIST"
$RemoveBlacklistedBloatware.width           = 460
$RemoveBlacklistedBloatware.height          = 30
$RemoveBlacklistedBloatware.Anchor          = 'top,right,left'
$RemoveBlacklistedBloatware.location        = New-Object System.Drawing.Point(10,120)
$RemoveBlacklistedBloatware.Font            = New-Object System.Drawing.Font('Consolas',9)
$RemoveBlacklistedBloatware.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Registry                        = New-Object system.Windows.Forms.Label
$Registry.text                   = "REGISTRY CHANGES"
$Registry.AutoSize               = $true
$Registry.width                  = 457
$Registry.height                 = 142
$Registry.Anchor                 = 'top,right,left'
$Registry.location               = New-Object System.Drawing.Point(10,10)
$Registry.Font                   = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Registry.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$RevertChanges                    = New-Object system.Windows.Forms.Button
$RevertChanges.FlatStyle          = 'Flat'
$RevertChanges.text               = "REVERT REGISTRY CHANGES"
$RevertChanges.width              = 460
$RevertChanges.height             = 30
$RevertChanges.Anchor             = 'top,right,left'
$RevertChanges.location           = New-Object System.Drawing.Point(10,40)
$RevertChanges.Font               = New-Object System.Drawing.Font('Consolas',9)
$RevertChanges.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Cortana                         = New-Object system.Windows.Forms.Label
$Cortana.text                    = "CORTANA"
$Cortana.AutoSize                = $true
$Cortana.width                   = 457
$Cortana.height                  = 142
$Cortana.Anchor                  = 'top,right,left'
$Cortana.location                = New-Object System.Drawing.Point(10,10)
$Cortana.Font                    = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Cortana.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$EnableCortana                   = New-Object system.Windows.Forms.Button
$EnableCortana.FlatStyle         = 'Flat'
$EnableCortana.text              = "ENABLE"
$EnableCortana.width             = 133
$EnableCortana.height            = 30
$EnableCortana.Anchor            = 'top,right,left'
$EnableCortana.location          = New-Object System.Drawing.Point(10,40)
$EnableCortana.Font              = New-Object System.Drawing.Font('Consolas',9)
$EnableCortana.ForeColor         = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$DisableCortana                  = New-Object system.Windows.Forms.Button
$DisableCortana.FlatStyle        = 'Flat'
$DisableCortana.text             = "DISABLE"
$DisableCortana.width            = 133
$DisableCortana.height           = 30
$DisableCortana.Anchor           = 'top,right,left'
$DisableCortana.location         = New-Object System.Drawing.Point(10,80)
$DisableCortana.Font             = New-Object System.Drawing.Font('Consolas',9)
$DisableCortana.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Edge                            = New-Object system.Windows.Forms.Label
$Edge.text                       = "EDGE PDF"
$Edge.AutoSize                   = $true
$Edge.width                      = 457
$Edge.height                     = 142
$Edge.Anchor                     = 'top,right,left'
$Edge.location                   = New-Object System.Drawing.Point(10,10)
$Edge.Font                       = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Edge.ForeColor                  = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$EnableEdgePDFTakeover           = New-Object system.Windows.Forms.Button
$EnableEdgePDFTakeover.FlatStyle = 'Flat'
$EnableEdgePDFTakeover.text      = "ENABLE"
$EnableEdgePDFTakeover.width     = 134
$EnableEdgePDFTakeover.height    = 30
$EnableEdgePDFTakeover.Anchor    = 'top,right,left'
$EnableEdgePDFTakeover.location  = New-Object System.Drawing.Point(10,40)
$EnableEdgePDFTakeover.Font      = New-Object System.Drawing.Font('Consolas',9)
$EnableEdgePDFTakeover.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$DisableEdgePDFTakeover             = New-Object system.Windows.Forms.Button
$DisableEdgePDFTakeover.FlatStyle   = 'Flat'
$DisableEdgePDFTakeover.text        = "DISABLE"
$DisableEdgePDFTakeover.width       = 134
$DisableEdgePDFTakeover.height      = 30
$DisableEdgePDFTakeover.Anchor      = 'top,right,left'
$DisableEdgePDFTakeover.location    = New-Object System.Drawing.Point(10,80)
$DisableEdgePDFTakeover.Font        = New-Object System.Drawing.Font('Consolas',9)
$DisableEdgePDFTakeover.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Theme                           = New-Object system.Windows.Forms.Label
$Theme.text                      = "DARK THEME"
$Theme.AutoSize                  = $true
$Theme.width                     = 457
$Theme.height                    = 142
$Theme.Anchor                    = 'top,right,left'
$Theme.location                  = New-Object System.Drawing.Point(10,10)
$Theme.Font                      = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Theme.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$EnableDarkMode                  = New-Object system.Windows.Forms.Button
$EnableDarkMode.FlatStyle        = 'Flat'
$EnableDarkMode.text             = "ENABLE"
$EnableDarkMode.width            = 133
$EnableDarkMode.height           = 30
$EnableDarkMode.Anchor           = 'top,right,left'
$EnableDarkMode.location         = New-Object System.Drawing.Point(10,40)
$EnableDarkMode.Font             = New-Object System.Drawing.Font('Consolas',9)
$EnableDarkMode.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$DisableDarkMode                 = New-Object system.Windows.Forms.Button
$DisableDarkMode.FlatStyle       = 'Flat'
$DisableDarkMode.text            = "DISABLE"
$DisableDarkMode.width           = 133
$DisableDarkMode.height          = 30
$DisableDarkMode.Anchor          = 'top,right,left'
$DisableDarkMode.location        = New-Object System.Drawing.Point(10,80)
$DisableDarkMode.Font            = New-Object System.Drawing.Font('Consolas',9)
$DisableDarkMode.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Other                           = New-Object system.Windows.Forms.Label
$Other.text                      = "OTHER CHANGES & FIXES"
$Other.AutoSize                  = $true
$Other.width                     = 457
$Other.height                    = 142
$Other.Anchor                    = 'top,right,left'
$Other.location                  = New-Object System.Drawing.Point(10,10)
$Other.Font                      = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Other.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$RemoveOnedrive                  = New-Object system.Windows.Forms.Button
$RemoveOnedrive.FlatStyle        = 'Flat'
$RemoveOnedrive.text             = "UNINSTALL ONEDRIVE"
$RemoveOnedrive.width            = 225
$RemoveOnedrive.height           = 30
$RemoveOnedrive.Anchor           = 'top,right,left'
$RemoveOnedrive.location         = New-Object System.Drawing.Point(10,40)
$RemoveOnedrive.Font             = New-Object System.Drawing.Font('Consolas',9)
$RemoveOnedrive.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$UnpinStartMenuTiles             = New-Object system.Windows.Forms.Button
$UnpinStartMenuTiles.FlatStyle   = 'Flat'
$UnpinStartMenuTiles.text        = "UNPIN TILES FROM START MENU"
$UnpinStartMenuTiles.width       = 225
$UnpinStartMenuTiles.height      = 30
$UnpinStartMenuTiles.Anchor      = 'top,right,left'
$UnpinStartMenuTiles.location    = New-Object System.Drawing.Point(245,40)
$UnpinStartMenuTiles.Font        = New-Object System.Drawing.Font('Consolas',9)
$UnpinStartMenuTiles.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$DisableTelemetry                = New-Object system.Windows.Forms.Button
$DisableTelemetry.FlatStyle      = 'Flat'
$DisableTelemetry.text           = "DISABLE TELEMETRY / TASKS"
$DisableTelemetry.width          = 225
$DisableTelemetry.height         = 30
$DisableTelemetry.Anchor         = 'top,right,left'
$DisableTelemetry.location       = New-Object System.Drawing.Point(10,80)
$DisableTelemetry.Font           = New-Object System.Drawing.Font('Consolas',9)
$DisableTelemetry.ForeColor      = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$RemoveRegkeys                   = New-Object system.Windows.Forms.Button
$RemoveRegkeys.FlatStyle         = 'Flat'
$RemoveRegkeys.text              = "REMOVE BLOATWARE REGKEYS"
$RemoveRegkeys.width             = 225
$RemoveRegkeys.height            = 30
$RemoveRegkeys.Anchor            = 'top,right,left'
$RemoveRegkeys.location          = New-Object System.Drawing.Point(245,80)
$RemoveRegkeys.Font              = New-Object System.Drawing.Font('Consolas',9)
$RemoveRegkeys.ForeColor         = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$InstallNet35                    = New-Object system.Windows.Forms.Button
$InstallNet35.FlatStyle          = 'Flat'
$InstallNet35.text               = "INSTALL .NET V3.5"
$InstallNet35.width              = 460
$InstallNet35.height             = 30
$InstallNet35.Anchor             = 'top,right,left'
$InstallNet35.location           = New-Object System.Drawing.Point(10,120)
$InstallNet35.Font               = New-Object System.Drawing.Font('Consolas',9)
$InstallNet35.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")