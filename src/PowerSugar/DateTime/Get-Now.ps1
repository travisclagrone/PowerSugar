function Get-Now {
    param(
        [switch]
        $Utc
    )
    process {
        if ($Utc) {
            [DateTime]::UtcNow
        }
        else {
            [DateTime]::Now
        }
    }
}

Set-Alias -Name 'now' -Value 'Get-Now' -Description 'Sugar'
