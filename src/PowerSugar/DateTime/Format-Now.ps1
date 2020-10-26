function Format-Now {
    [CmdletBinding(PositionalBinding = $false, DefaultParameterSetName = 'FileFormat')]
    param(
        [switch]
        $Utc,

        [Parameter(ParameterSetName = 'ExplicitFormat', Mandatory, Position = 0)]
        [ArgumentCompletions('d', 'D', 'f', 'F', 'g', 'G', 'm', 'o', 'r', 's', 't', 'T', 'u', 'U', 'y')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Format
    )
    process {
        $now = [DateTime]::Now
        if ($Utc) {
            $now = $now.ToUniversalTime()
        }
        if (-not $Format) {
            $Format = 'yyyyMMddThhmmss'
            if ($Utc) {
                $Format += 'Z'
            }
        }
        $now.ToString($Format)
    }
}

Set-Alias -Name 'fnow' -Value 'Format-Now' -Description 'Sugar'
