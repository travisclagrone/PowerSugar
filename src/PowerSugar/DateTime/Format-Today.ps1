function Format-Today {
    [CmdletBinding(PositionalBinding = $false, DefaultParameterSetName = 'FileFormat')]
    param(
        [switch]
        $Utc,

        [Parameter(ParameterSetName = 'ExplicitFormat', Mandatory, Position = 0)]
        [ArgumentCompletions('d', 'D', 'm', 'y')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Format
    )
    process {
        $today = [DateTime]::Today
        if ($Utc) {
            $today = $today.ToUniversalTime()
        }
        if (-not $Format) {
            $Format = 'yyyyMMdd'
            if ($Utc) {
                $Format += 'Z'
            }
        }
        $today.ToString($Format)
    }
}

Set-Alias -Name 'ftoday' -Value 'Format-Today' -Description 'Sugar'
