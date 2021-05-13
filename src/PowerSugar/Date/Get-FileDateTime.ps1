function Get-FileDateTime {
    [Alias('fnow')]
    [CmdletBinding()]
    [OutputType([string])]
    param()
    Get-Date -Format 'FileDateTime'
}
