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

# Alias name is "?all" instead of "all" in order to avoid overshadowing other modules' internal functions.
Set-Alias -Name '?all' -Value 'Measure-All' -ErrorAction SilentlyContinue
