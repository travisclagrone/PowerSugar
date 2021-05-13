function Get-UniversalDate {
    [Alias("utctoday")]
    [CmdletBinding()]
    [OutputType([DateTime])]
    param()
    [DateTime]::UtcNow.Date
}
