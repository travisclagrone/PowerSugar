function Get-Today {
    param(
        [switch]
        $Utc
    )
    process {
        $today = [DateTime]::Today
        if ($Utc) {
            $today = $today.ToUniversalTime()
        }
        $today
    }
}

Set-Alias -Name 'today' -Value 'Get-Today' -Description 'Sugar'
