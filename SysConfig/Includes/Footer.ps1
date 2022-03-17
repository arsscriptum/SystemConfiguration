


# ------------------------------------
# Loader
# ------------------------------------
function ConvertFrom-Base64CompressedScriptBlock {

    [CmdletBinding()] param(
        [String]
        $ScriptBlock
    )

    # Take my B64 string and do a Base64 to Byte array conversion of compressed data
    $ScriptBlockCompressed = [System.Convert]::FromBase64String($ScriptBlock)

    # Then decompress script's data
    $InputStream = New-Object System.IO.MemoryStream(, $ScriptBlockCompressed)
    $GzipStream = New-Object System.IO.Compression.GzipStream $InputStream, ([System.IO.Compression.CompressionMode]::Decompress)
    $StreamReader = New-Object System.IO.StreamReader($GzipStream)
    $ScriptBlockDecompressed = $StreamReader.ReadToEnd()
    # And close the streams
    $GzipStream.Close()
    $InputStream.Close()

    $ScriptBlockDecompressed
}

# For each scripts in the module, decompress and load it.
# Set a flag in the Script Scope so that the scripts know we are loading a module
# so he can have a specific logic
$Script:LoadingState = $True
$ScriptList | ForEach-Object {
    $ScriptData = $_
     
    $ClearScript = ConvertFrom-Base64CompressedScriptBlock -ScriptBlock $ScriptData
    try{
        $ClearScript | Invoke-Expression
    }catch{
        Show-ExceptionDetails $_ -ShowStack
    }
}
$Script:LoadingState = $False



