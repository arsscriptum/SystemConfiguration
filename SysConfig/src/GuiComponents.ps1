
Register-Assemblies
# This form was created using POSHGUI.com  a free online gui designer for PowerShell
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


$Script:Form                            = New-Object system.Windows.Forms.Form
$Script:Form.ClientSize                 = New-Object System.Drawing.Point(500,570)
$Script:Form.StartPosition              = 'CenterScreen'
$Script:Form.FormBorderStyle            = 'FixedSingle'
$Script:Form.MinimizeBox                = $false
$Script:Form.MaximizeBox                = $false
$Script:Form.ShowIcon                   = $false
$Script:Form.text                       = "Windows10Label01er"
$Script:Form.TopMost                    = $false
$Script:Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#252525")

$Script:PanelObj01                    = New-Object system.Windows.Forms.Panel
$Script:PanelObj01.height             = 160
$Script:PanelObj01.width              = 480
$Script:PanelObj01.Anchor             = 'top,right,left'
$Script:PanelObj01.location           = New-Object System.Drawing.Point(10,10)

$Script:PanelObj02                   = New-Object system.Windows.Forms.Panel
$Script:PanelObj02.height            = 80
$Script:PanelObj02.width             = 480
$Script:PanelObj02.Anchor            = 'top,right,left'
$Script:PanelObj02.location          = New-Object System.Drawing.Point(10,180)

$Script:PanelObj04                    = New-Object system.Windows.Forms.Panel
$Script:PanelObj04.height             = 120
$Script:PanelObj04.width              = 153
$Script:PanelObj04.Anchor             = 'top,right,left'
$Script:PanelObj04.location           = New-Object System.Drawing.Point(10,270)

$Script:PanelObj05                       = New-Object system.Windows.Forms.Panel
$Script:PanelObj05.height                = 120
$Script:PanelObj05.width                 = 154
$Script:PanelObj05.Anchor                = 'top,right,left'
$Script:PanelObj05.location              = New-Object System.Drawing.Point(173,270)

$Script:PanelObj06                  = New-Object system.Windows.Forms.Panel
$Script:PanelObj06.height           = 120
$Script:PanelObj06.width            = 153
$Script:PanelObj06.Anchor           = 'top,right,left'
$Script:PanelObj06.location         = New-Object System.Drawing.Point(337,270)

$Script:PanelObj07                      = New-Object system.Windows.Forms.Panel
$Script:PanelObj07.height               = 160
$Script:PanelObj07.width                = 480
$Script:PanelObj07.Anchor               = 'top,right,left'
$Script:PanelObj07.location             = New-Object System.Drawing.Point(10,400)

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

$Script:Label03                        = New-Object system.Windows.Forms.Label
$Script:Label03.text                   = "REGISTRY CHANGES"
$Script:Label03.AutoSize               = $true
$Script:Label03.width                  = 457
$Script:Label03.height                 = 142
$Script:Label03.Anchor                 = 'top,right,left'
$Script:Label03.location               = New-Object System.Drawing.Point(10,10)
$Script:Label03.Font                   = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label03.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button04                    = New-Object system.Windows.Forms.Button
$Script:Button04.FlatStyle          = 'Flat'
$Script:Button04.text               = "REVERT REGISTRY CHANGES"
$Script:Button04.width              = 460
$Script:Button04.height             = 30
$Script:Button04.Anchor             = 'top,right,left'
$Script:Button04.location           = New-Object System.Drawing.Point(10,40)
$Script:Button04.Font               = New-Object System.Drawing.Font('Consolas',9)
$Script:Button04.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label04                         = New-Object system.Windows.Forms.Label
$Script:Label04.text                    = "CORTANA"
$Script:Label04.AutoSize                = $true
$Script:Label04.width                   = 457
$Script:Label04.height                  = 142
$Script:Label04.Anchor                  = 'top,right,left'
$Script:Label04.location                = New-Object System.Drawing.Point(10,10)
$Script:Label04.Font                    = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label04.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

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

$Script:Label05                            = New-Object system.Windows.Forms.Label
$Script:Label05.text                       = "EDGE PDF"
$Script:Label05.AutoSize                   = $true
$Script:Label05.width                      = 457
$Script:Label05.height                     = 142
$Script:Label05.Anchor                     = 'top,right,left'
$Script:Label05.location                   = New-Object System.Drawing.Point(10,10)
$Script:Label05.Font                       = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label05.ForeColor                  = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button07           = New-Object system.Windows.Forms.Button
$Script:Button07.FlatStyle = 'Flat'
$Script:Button07.text      = "ENABLE"
$Script:Button07.width     = 134
$Script:Button07.height    = 30
$Script:Button07.Anchor    = 'top,right,left'
$Script:Button07.location  = New-Object System.Drawing.Point(10,40)
$Script:Button07.Font      = New-Object System.Drawing.Font('Consolas',9)
$Script:Button07.ForeColor  = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button08             = New-Object system.Windows.Forms.Button
$Script:Button08.FlatStyle   = 'Flat'
$Script:Button08.text        = "DISABLE"
$Script:Button08.width       = 134
$Script:Button08.height      = 30
$Script:Button08.Anchor      = 'top,right,left'
$Script:Button08.location    = New-Object System.Drawing.Point(10,80)
$Script:Button08.Font        = New-Object System.Drawing.Font('Consolas',9)
$Script:Button08.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label06                           = New-Object system.Windows.Forms.Label
$Script:Label06.text                      = "DARK THEME"
$Script:Label06.AutoSize                  = $true
$Script:Label06.width                     = 457
$Script:Label06.height                    = 142
$Script:Label06.Anchor                    = 'top,right,left'
$Script:Label06.location                  = New-Object System.Drawing.Point(10,10)
$Script:Label06.Font                      = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label06.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button09                  = New-Object system.Windows.Forms.Button
$Script:Button09.FlatStyle        = 'Flat'
$Script:Button09.text             = "ENABLE"
$Script:Button09.width            = 133
$Script:Button09.height           = 30
$Script:Button09.Anchor           = 'top,right,left'
$Script:Button09.location         = New-Object System.Drawing.Point(10,40)
$Script:Button09.Font             = New-Object System.Drawing.Font('Consolas',9)
$Script:Button09.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button10                 = New-Object system.Windows.Forms.Button
$Script:Button10.FlatStyle       = 'Flat'
$Script:Button10.text            = "DISABLE"
$Script:Button10.width           = 133
$Script:Button10.height          = 30
$Script:Button10.Anchor          = 'top,right,left'
$Script:Button10.location        = New-Object System.Drawing.Point(10,80)
$Script:Button10.Font            = New-Object System.Drawing.Font('Consolas',9)
$Script:Button10.ForeColor       = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Label07                           = New-Object system.Windows.Forms.Label
$Script:Label07.text                      = "OTHER CHANGES & FIXES"
$Script:Label07.AutoSize                  = $true
$Script:Label07.width                     = 457
$Script:Label07.height                    = 142
$Script:Label07.Anchor                    = 'top,right,left'
$Script:Label07.location                  = New-Object System.Drawing.Point(10,10)
$Script:Label07.Font                      = New-Object System.Drawing.Font('Consolas',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:Label07.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button11                  = New-Object system.Windows.Forms.Button
$Script:Button11.FlatStyle        = 'Flat'
$Script:Button11.text             = "UNINSTALL ONEDRIVE"
$Script:Button11.width            = 225
$Script:Button11.height           = 30
$Script:Button11.Anchor           = 'top,right,left'
$Script:Button11.location         = New-Object System.Drawing.Point(10,40)
$Script:Button11.Font             = New-Object System.Drawing.Font('Consolas',9)
$Script:Button11.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Button12             = New-Object system.Windows.Forms.Button
$Button12.FlatStyle   = 'Flat'
$Button12.text        = "UNPIN TILES FROM START MENU"
$Button12.width       = 225
$Button12.height      = 30
$Button12.Anchor      = 'top,right,left'
$Button12.location    = New-Object System.Drawing.Point(245,40)
$Button12.Font        = New-Object System.Drawing.Font('Consolas',9)
$Button12.ForeColor   = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button13                = New-Object system.Windows.Forms.Button
$Script:Button13.FlatStyle      = 'Flat'
$Script:Button13.text           = "DISABLE TELEMETRY / TASKS"
$Script:Button13.width          = 225
$Script:Button13.height         = 30
$Script:Button13.Anchor         = 'top,right,left'
$Script:Button13.location       = New-Object System.Drawing.Point(10,80)
$Script:Button13.Font           = New-Object System.Drawing.Font('Consolas',9)
$Script:Button13.ForeColor      = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button14                   = New-Object system.Windows.Forms.Button
$Script:Button14.FlatStyle         = 'Flat'
$Script:Button14.text              = "REMOVE BLOATWARE REGKEYS"
$Script:Button14.width             = 225
$Script:Button14.height            = 30
$Script:Button14.Anchor            = 'top,right,left'
$Script:Button14.location          = New-Object System.Drawing.Point(245,80)
$Script:Button14.Font              = New-Object System.Drawing.Font('Consolas',9)
$Script:Button14.ForeColor         = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

$Script:Button15                    = New-Object system.Windows.Forms.Button
$Script:Button15.FlatStyle          = 'Flat'
$Script:Button15.text               = "INSTALL .NET V3.5"
$Script:Button15.width              = 460
$Script:Button15.height             = 30
$Script:Button15.Anchor             = 'top,right,left'
$Script:Button15.location           = New-Object System.Drawing.Point(10,120)
$Script:Button15.Font               = New-Object System.Drawing.Font('Consolas',9)
$Script:Button15.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")
