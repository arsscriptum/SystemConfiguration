

function BuildToString{
    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        [Parameter(Mandatory=$true,Position=0)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "File or folder does not exist"
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "The Path argument must be a file. Directory paths are not allowed."
            }
            return $true 
        })]        
        [string]$Script
    )

    $sname = (Get-Item $Script).Name
    $base = (Get-Item $Script).Basename

    $Content = Get-Content -Path $Script -Raw
    $CompressedContent = Convert-ToBase64CompressedScriptBlock $Content
    $StringDecl = "# ------------------------------------`n"
    $StringDecl += "# Script file - $Base - `n"
    $StringDecl += "# ------------------------------------`n"
    $StringDecl += '$' + "$Base = `"" + $CompressedContent + '"'
    $StringDecl += "`n"
    $StringDecl += '$Null = $ScriptList.Add($' + "$Base)`n`n" 

    return $StringDecl
}

function BuildToFile{
    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        [Parameter(Mandatory=$true,Position=0)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "File or folder does not exist"
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "The Path argument must be a file. Directory paths are not allowed."
            }
            return $true 
        })]        
        [string]$Script
    )

    $OutputPath = Join-Path (Get-Location).Path 'out'
    $Null = New-Item -Path $OutputPath -ItemType 'Directory' -Force

    $sname = (Get-Item $Script).Name
    $base = (Get-Item $Script).Basename
    $OutputScript = Join-Path $OutputPath $sname

    $Content = Get-Content -Path $Script -Raw
    $CompressedContent = Convert-ToBase64CompressedScriptBlock $Content
    $StringDecl = "# ------------------------------------`n"
    $StringDecl += "# Script file - $Base - `n"
    $StringDecl += "# ------------------------------------`n"
    $StringDecl += '$' + "$Base = `"" + $CompressedContent + '"'
    $StringDecl += "`n"
    $StringDecl += '$Null = $ScriptList.Add(' + "$Base )`n`n" 

    Set-Content -Path $OutputScript -Value "`n`n$StringDecl`n"
    Write-Output "Wrote $OutputScript`nDone."
}


function BuildFilesInPath{
    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        [Parameter(Mandatory=$true,Position=0)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "File or folder does not exist"
            }
            if(-Not ($_ | Test-Path -PathType Container) ){
                throw "The Path argument must be a directory. File paths are not allowed."
            }
            return $true 
        })]        
        [string]$Path,
        [switch]$Validate
    )
    $SrcFiles = (gci -Path $Path -File -Filter '*.ps1').Fullname
    $IncludesPath = Join-Path (Get-Location).Path 'Includes'
    #$OutputPath = Join-Path (Get-Location).Path 'out'
    $OutputPath = (Get-Location).Path 
    $Null = Remove-Item -Path $OutputPath -Force -Recurse
    $Null = New-Item -Path $OutputPath -ItemType 'Directory' -Force    
    $OutputScript = Join-Path $OutputPath 'pcs.ps1'

    [int]$i=0
    $footer = Get-Content -Path "$IncludesPath\Footer.ps1"
    $header = Get-Content -Path "$IncludesPath\Header.ps1"
    $Null = Set-Content $OutputScript -Value $header
    foreach($f in $SrcFiles){
        $i++
        if($Validate){
            Write-Output "Checking script $f"
            . "$f"
            Write-Output "Ok!"    
        }
        Write-Output "`nBuilding $f..."
        $Str = BuildToString $f

        Write-Output "Ok!`n`nAdd to output file."
        $Null = Add-Content -Path $OutputScript -Value "`n`n$Str`n"
    }

    $Null = Add-Content $OutputScript -Value $footer
    Write-Output "Done. Added $i files.`nOutput file is $OutputScript"
}
