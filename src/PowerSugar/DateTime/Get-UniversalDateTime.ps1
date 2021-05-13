function Get-UniversalDateTime {
    [Alias("utcnow")]
    [CmdletBinding()]
    [OutputType([DateTime])]
    param()
    [DateTime]::UtcNow
}
