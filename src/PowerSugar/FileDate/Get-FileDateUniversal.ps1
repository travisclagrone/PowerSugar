function Get-FileDateUniversal {
    Get-Date -Format 'FileDateUniversal'
}

Set-Alias -Name 'today' -Value 'Get-FileDateUniversal' -ErrorAction SilentlyContinue
