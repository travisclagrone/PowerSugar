function Get-Timestamp {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [switch]
        $Humanize,

        [switch]
        $Milliseconds
    )
    process {
        $utcNow = [DateTime]::UtcNow
        $format =
            if ($Humanize) {
                if ($Milliseconds) {
                    'yyyy-MM-dd hh:mm:ss.FFFF \U\T\C'
                } else {
                    'yyyy-MM-dd hh:mm:ss \U\T\C'
                }
            } else {
                if ($Milliseconds) {
                    'yyyyMMddThhmmssffffZ'
                } else {
                    'yyyyMMddThhmmssZ'
                }
            }
        Write-Debug "`$format = $format"
        $utcNow.ToString($format)
    }
}

Set-Alias -Name 'timestamp' -Value 'Get-Timestamp' -Description 'Sugar'
