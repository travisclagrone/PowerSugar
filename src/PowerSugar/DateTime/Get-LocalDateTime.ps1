function Get-LocalDateTime {
    [Alias("now")]
    [CmdletBinding()]
    [OutputType([DateTime])]
    param()
    [DateTime]::Now
}
