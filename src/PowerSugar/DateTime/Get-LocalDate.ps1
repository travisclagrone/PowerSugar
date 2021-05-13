function Get-LocalDate {
    [Alias("today")]
    [CmdletBinding()]
    [OutputType([DateTime])]
    param()
    [DateTime]::Today
}
