function Get-FileDate {
    [Alias('ftoday')]
    [CmdletBinding()]
    [OutputType([string])]
    param()
    Get-Date -Format 'FileDate'
}
