<#
  ╓──────────────────────────────────────────────────────────────────────────────────────
  ║   GuiComponents.ps1      
  ║   
  ║   
  ╙──────────────────────────────────────────────────────────────────────────────────────
 #>

$Script:TextBackColor               = [System.Drawing.ColorTranslator]::FromHtml("#7d7d7d")
$Script:TextForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#000000")

$Script:LabelTestFont               = New-Object System.Drawing.Font("Microsoft Sans Serif", 8, [System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point))
$Script:LabelSmallFont              = New-Object System.Drawing.Font('Consolas',10,     [System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:LabelMediumFont             = New-Object System.Drawing.Font('Consolas',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Script:ButtonSmallFont             = New-Object System.Drawing.Font('Consolas',7)

$Script:ButtonBigFont               = New-Object System.Drawing.Font('Consolas',16)
#$Script:ButtonNerdFont             = New-Object System.Drawing.Font('3270Medium Nerd Font Mono',12)
$Script:ButtonNerdFont              = New-Object System.Drawing.Font('3270SemiNarrow Nerd Font',10)
$Script:ButtonMediumFont            = ButtonNerdFont # New-Object System.Drawing.Font('Consolas',12)

function New-SimpleButton([int]$x,[int]$y){
    $NewBtn = New-Object system.Windows.Forms.Button
    $NewBtn.FlatStyle               = 'Flat'
    $NewBtn.text                    = "Create wellknown paths"
    $NewBtn.width                   = 260
    $NewBtn.height                  = 30
    $NewBtn.Anchor                  = 'top,right,left'
    $NewBtn.location                = New-Object System.Drawing.Point($x,$y)
    $NewBtn.Font                    = $Script:ButtonSmallFont
    $NewBtn.ForeColor               = $Script:ButtonTextColor
    return $NewBtn
}

$Script:Form                        = New-Object system.Windows.Forms.Form
$Script:Form.ClientSize             = New-Object System.Drawing.Point(550,300)
$Script:Form.StartPosition          = 'CenterScreen'
$Script:Form.FormBorderStyle        = 'FixedSingle'
$Script:Form.MinimizeBox            = $false
$Script:Form.MaximizeBox            = $false
$Script:Form.ShowIcon               = $false
$Script:Form.text                   = "System Configurator"
$Script:Form.TopMost                = $false
$Script:Form.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#202020")
$Script:ButtonTextColor             = [System.Drawing.ColorTranslator]::FromHtml("#eeeeee")

if($Script:TEST_MODE){
    $Script:Form.BackColor          = [System.Drawing.ColorTranslator]::FromHtml("#24aa99")  
    $Script:ButtonTextColor         = [System.Drawing.ColorTranslator]::FromHtml("#101010")
    $Script:Form.text               = "System Configurator *TEST MODE*"  
}
$Script:Panel01                     = New-Object system.Windows.Forms.Panel
$Script:Panel01.height              = 160
$Script:Panel01.width               = 480
$Script:Panel01.Anchor              = 'top,right,left'
$Script:Panel01.location            = New-Object System.Drawing.Point(10,10)

$Script:Panel02                     = New-Object system.Windows.Forms.Panel
$Script:Panel02.height              = 80
$Script:Panel02.width               = 480
$Script:Panel02.Anchor              = 'top,right,left'
$Script:Panel02.location            = New-Object System.Drawing.Point(10,180)

$Script:Panel03                     = New-Object system.Windows.Forms.Panel
$Script:Panel03.height              = 120
$Script:Panel03.width               = 153
$Script:Panel03.Anchor              = 'top,right,left'
$Script:Panel03.location            = New-Object System.Drawing.Point(10,270)

$Script:Panel04                     = New-Object system.Windows.Forms.Panel
$Script:Panel04.height              = 120
$Script:Panel04.width               = 154
$Script:Panel04.Anchor              = 'top,right,left'
$Script:Panel04.location            = New-Object System.Drawing.Point(173,270)

$Script:Panel05                     = New-Object system.Windows.Forms.Panel
$Script:Panel05.height              = 120
$Script:Panel05.width               = 153
$Script:Panel05.Anchor              = 'top,right,left'
$Script:Panel05.location            = New-Object System.Drawing.Point(337,270)

$Script:Panel06                     = New-Object system.Windows.Forms.Panel
$Script:Panel06.height              = 160
$Script:Panel06.width               = 480
$Script:Panel06.Anchor              = 'top,right,left'
$Script:Panel06.location            = New-Object System.Drawing.Point(10,400)

$Script:Label01                     = New-Object system.Windows.Forms.Label
$Script:Label01.text                = "well known paths and pwsh directories"
$Script:Label01.AutoSize            = $true
$Script:Label01.width               = 457
$Script:Label01.height              = 142
$Script:Label01.Anchor              = 'top,right,left'
$Script:Label01.location            = New-Object System.Drawing.Point(10,9)
$Script:Label01.Font                = $Script:LabelSmallFont
$Script:Label01.ForeColor           = $Script:ButtonTextColor



$Script:Button01                    = New-Object system.Windows.Forms.Button
$Script:Button01.FlatStyle          = 'Flat'
$Script:Button01.text               = "Create wellknown paths"
$Script:Button01.width              = 260
$Script:Button01.height             = 30
$Script:Button01.Anchor             = 'top,right,left'
$Script:Button01.location           = New-Object System.Drawing.Point(210,40)
$Script:Button01.Font               = $Script:ButtonSmallFont
$Script:Button01.ForeColor          = $Script:ButtonTextColor

$Script:ListBox01                   = New-Object System.Windows.Forms.ListBox
$Script:ListBox01.FlatStyle         = 'Flat'
$Script:ListBox01.width             = 133
$Script:ListBox01.height            = 40
$Script:ListBox01.Anchor            = 'top,right,left'
$Script:ListBox01.location          = New-Object System.Drawing.Point(10,40)
$Script:ListBox01.Font              = $Script:ButtonBigFont
$Script:ListBox01.ForeColor         = $Script:ButtonTextColor


$Script:TextBox01                   = New-Object System.Windows.Forms.TextBox
$Script:TextBox01.FlatStyle         = 'Flat'
$Script:TextBox01.width             = 133
$Script:TextBox01.height            = 40
$Script:TextBox01.Anchor            = 'top,right,left'
$Script:TextBox01.location          = New-Object System.Drawing.Point(10,80)
$Script:TextBox01.Font              = $Script:ButtonBigFont
$Script:TextBox01.ForeColor         = $Script:TextForeColor
$Script:TextBox01.BackColor         = $Script:TextBackColor

$Script:Button02                    = New-Object system.Windows.Forms.Button
$Script:Button02.FlatStyle          = 'Flat'
$Script:Button02.text               = "Registry Organisation Root"
$Script:Button02.width              = 260
$Script:Button02.height             = 30
$Script:Button02.Anchor             = 'top,right,left'
$Script:Button02.location           = New-Object System.Drawing.Point(210,80)
$Script:Button02.Font               = $Script:ButtonSmallFont
$Script:Button02.ForeColor          = $Script:ButtonTextColor


$Script:Button03                    = New-Object system.Windows.Forms.Button
$Script:Button03.FlatStyle          = 'Flat'
$Script:Button03.text               = "create pwsh dir"
$Script:Button03.width              = 225
$Script:Button03.height             = 30
$Script:Button03.Anchor             = 'top,right,left'
$Script:Button03.location           = New-Object System.Drawing.Point(10,120)
$Script:Button03.Font               = $Script:ButtonSmallFont
$Script:Button03.ForeColor          = $Script:ButtonTextColor

$Script:Button31                    = New-Object system.Windows.Forms.Button
$Script:Button31.FlatStyle          = 'Flat'
$Script:Button31.text               = "sync pwsh profile"
$Script:Button31.width              = 225
$Script:Button31.height             = 30
$Script:Button31.Anchor             = 'top,right,left'
$Script:Button31.location           = New-Object System.Drawing.Point(245,120)
$Script:Button31.Font               = $Script:ButtonSmallFont
$Script:Button31.ForeColor          = $Script:ButtonTextColor

$Script:Label02                     = New-Object system.Windows.Forms.Label
$Script:Label02.text                = "Label02"
$Script:Label02.AutoSize            = $true
$Script:Label02.width               = 457
$Script:Label02.height              = 142
$Script:Label02.Anchor              = 'top,right,left'
$Script:Label02.location            = New-Object System.Drawing.Point(10,10)
$Script:Label02.Font                = $Script:LabelSmallFont
$Script:Label02.ForeColor           = $Script:ButtonTextColor

$Script:Button04                    = New-Object system.Windows.Forms.Button
$Script:Button04.FlatStyle          = 'Flat'
$Script:Button04.text               = "SystemEnvironmentValues"
$Script:Button04.width              = 460
$Script:Button04.height             = 30
$Script:Button04.Anchor             = 'top,right,left'
$Script:Button04.location           = New-Object System.Drawing.Point(10,40)
$Script:Button04.Font               = $Script:ButtonSmallFont
$Script:Button04.ForeColor          = $Script:ButtonTextColor

$Script:Label03                     = New-Object system.Windows.Forms.Label
$Script:Label03.text                = "Label 03"
$Script:Label03.AutoSize            = $true
$Script:Label03.width               = 457
$Script:Label03.height              = 142
$Script:Label03.Anchor              = 'top,right,left'
$Script:Label03.location            = New-Object System.Drawing.Point(10,10)
$Script:Label03.Font                = $Script:LabelSmallFont
$Script:Label03.ForeColor           = $Script:ButtonTextColor


$Script:Button05                    = New-Object system.Windows.Forms.Button
$Script:Button05.FlatStyle          = 'Flat'
$Script:Button05.text               = "Button05"
$Script:Button05.width              = 133
$Script:Button05.height             = 30
$Script:Button05.Anchor             = 'top,right,left'
$Script:Button05.location           = New-Object System.Drawing.Point(10,40)
$Script:Button05.Font               = $Script:ButtonSmallFont
$Script:Button05.ForeColor          = $Script:ButtonTextColor

$Script:Button06                    = New-Object system.Windows.Forms.Button
$Script:Button06.FlatStyle          = 'Flat'
$Script:Button06.text               = "06"
$Script:Button06.width              = 133
$Script:Button06.height             = 30
$Script:Button06.Anchor             = 'top,right,left'
$Script:Button06.location           = New-Object System.Drawing.Point(10,80)
$Script:Button06.Font               = $Script:ButtonSmallFont
$Script:Button06.ForeColor          = $Script:ButtonTextColor

$Script:Label99                     = New-Object system.Windows.Forms.Label
$Script:Label99.text                = "Label 99"
$Script:Label99.AutoSize            = $true
$Script:Label99.width               = 457
$Script:Label99.height              = 142
$Script:Label99.Anchor              = 'top,right,left'
$Script:Label99.location            = New-Object System.Drawing.Point(10,10)
$Script:Label99.Font                = $Script:LabelSmallFont
$Script:Label99.ForeColor           = $Script:ButtonTextColor

$Script:Label04                     = New-Object system.Windows.Forms.Button
$Script:Label04.FlatStyle           = 'Flat'
$Script:Label04.text                = "label4"
$Script:Label04.width               = 134
$Script:Label04.height              = 30
$Script:Label04.Anchor              = 'top,right,left'
$Script:Label04.location            = New-Object System.Drawing.Point(10,40)
$Script:Label04.Font                = $Script:ButtonSmallFont
$Script:Label04.ForeColor           = $Script:ButtonTextColor

$Script:Button07                    = New-Object system.Windows.Forms.Button
$Script:Button07.FlatStyle          = 'Flat'
$Script:Button07.text               = "7"
$Script:Button07.width              = 134
$Script:Button07.height             = 30
$Script:Button07.Anchor             = 'top,right,left'
$Script:Button07.location           = New-Object System.Drawing.Point(10,80)
$Script:Button07.Font               = $Script:ButtonSmallFont
$Script:Button07.ForeColor          = $Script:ButtonTextColor

$Script:Label05                     = New-Object system.Windows.Forms.Label
$Script:Label05.text                = "LAbel 5"
$Script:Label05.AutoSize            = $true
$Script:Label05.width               = 457
$Script:Label05.height              = 142
$Script:Label05.Anchor              = 'top,right,left'
$Script:Label05.location            = New-Object System.Drawing.Point(10,10)
$Script:Label05.Font                = $Script:LabelSmallFont
$Script:Label05.ForeColor           = $Script:ButtonTextColor

$Script:Button09                    = New-Object system.Windows.Forms.Button
$Script:Button09.FlatStyle          = 'Flat'
$Script:Button09.text               = "09"
$Script:Button09.width              = 133
$Script:Button09.height             = 30
$Script:Button09.Anchor             = 'top,right,left'
$Script:Button09.location           = New-Object System.Drawing.Point(10,40)
$Script:Button09.Font               = $Script:ButtonSmallFont
$Script:Button09.ForeColor          = $Script:ButtonTextColor

$Script:Button08                    = New-Object system.Windows.Forms.Button
$Script:Button08.FlatStyle          = 'Flat'
$Script:Button08.text               = "Create PowerShell Directories"
$Script:Button08.width              = 133
$Script:Button08.height             = 30
$Script:Button08.Anchor             = 'top,right,left'
$Script:Button08.location           = New-Object System.Drawing.Point(10,80)
$Script:Button08.Font               = $Script:ButtonSmallFont
$Script:Button08.ForeColor          = $Script:ButtonTextColor

$Script:Label06                     = New-Object system.Windows.Forms.Label
$Script:Label06.text                = "06"
$Script:Label06.AutoSize            = $true
$Script:Label06.width               = 457
$Script:Label06.height              = 142
$Script:Label06.Anchor              = 'top,right,left'
$Script:Label06.location            = New-Object System.Drawing.Point(10,10)
$Script:Label06.Font                = $Script:LabelSmallFont
$Script:Label06.ForeColor           = $Script:ButtonTextColor

$Script:Button10                    = New-Object system.Windows.Forms.Button
$Script:Button10.FlatStyle          = 'Flat'
$Script:Button10.text               = "10"
$Script:Button10.width              = 225
$Script:Button10.height             = 30
$Script:Button10.Anchor             = 'top,right,left'
$Script:Button10.location           = New-Object System.Drawing.Point(10,40)
$Script:Button10.Font               = $Script:ButtonSmallFont
$Script:Button10.ForeColor          = $Script:ButtonTextColor

$Script:Button12                    = New-Object system.Windows.Forms.Button
$Script:Button12.FlatStyle          = 'Flat'
$Script:Button12.text               = "Refresh Environment Variables"
$Script:Button12.width              = 225
$Script:Button12.height             = 30
$Script:Button12.Anchor             = 'top,right,left'
$Script:Button12.location           = New-Object System.Drawing.Point(245,40)
$Script:Button12.Font               = $Script:ButtonSmallFont
$Script:Button12.ForeColor          = $Script:ButtonTextColor

$Script:Button13                    = New-Object system.Windows.Forms.Button
$Script:Button13.FlatStyle          = 'Flat'
$Script:Button13.text               = "13"
$Script:Button13.width              = 225
$Script:Button13.height             = 30
$Script:Button13.Anchor             = 'top,right,left'
$Script:Button13.location           = New-Object System.Drawing.Point(10,80)
$Script:Button13.Font               = $Script:ButtonSmallFont
$Script:Button13.ForeColor          = $Script:ButtonTextColor

$Script:Button14                    = New-Object system.Windows.Forms.Button
$Script:Button14.FlatStyle          = 'Flat'
$Script:Button14.text               = "14"
$Script:Button14.width              = 225
$Script:Button14.height             = 30
$Script:Button14.Anchor             = 'top,right,left'
$Script:Button14.location           = New-Object System.Drawing.Point(245,80)
$Script:Button14.Font               = $Script:ButtonSmallFont
$Script:Button14.ForeColor          = $Script:ButtonTextColor

$Script:Button11                    = New-Object system.Windows.Forms.Button
$Script:Button11.FlatStyle          = 'Flat'
$Script:Button11.text               = "11"
$Script:Button11.width              = 460
$Script:Button11.height             = 30
$Script:Button11.Anchor             = 'top,right,left'
$Script:Button11.location           = New-Object System.Drawing.Point(10,120)
$Script:Button11.Font               = $Script:ButtonSmallFont
$Script:Button11.ForeColor          = $Script:ButtonTextColor
