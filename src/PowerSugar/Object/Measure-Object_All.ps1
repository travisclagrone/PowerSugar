function Measure-Object_All {
    end {
        foreach ($element in $Input) {
            if (-not $element) {
                return $false
            }
        }
        return $true
    }
}

Set-Alias -Name 'all' -Value 'Measure-Object_All' -ErrorAction SilentlyContinue
