function Measure-All {
    end {
        foreach ($element in $Input) {
            if (-not $element) {
                return $false
            }
        }
        return $true
    }
}

Set-Alias -Name 'all' -Value 'Measure-All' -ErrorAction SilentlyContinue
