function Get-FileDateTimeUniversal {
    [Alias('futcnow')]
    [CmdletBinding()]
    [OutputType([string])]
    param()
    Get-Date -Format 'FileDateTimeUniversal'
}
