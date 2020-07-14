function Get-FileDateTimeUniversal {
    Get-Date -Format 'FileDateTimeUniversal'
}

Set-Alias -Name 'now' -Value 'Get-FileDateTimeUniversal' -ErrorAction SilentlyContinue
