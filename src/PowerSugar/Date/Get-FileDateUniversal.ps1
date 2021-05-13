function Get-FileDateUniversal {
    [Alias('futctoday')]
    [CmdletBinding()]
    [OutputType([string])]
    param()
    Get-Date -Format 'FileDateUniversal'
}
