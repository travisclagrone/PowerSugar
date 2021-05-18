function Measure-Any {
    end {
        foreach ($element in $Input) {
            if ($element) {
                return $true
            }
        }
        return $false
    }
}

# Alias name is "?any" instead of "any" in order to avoid overshadowing other modules' internal functions.
Set-Alias -Name '?any' -Value 'Measure-Any' -ErrorAction SilentlyContinue
