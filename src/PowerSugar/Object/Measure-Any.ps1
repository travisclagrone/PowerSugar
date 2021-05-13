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

Set-Alias -Name 'any' -Value 'Measure-Any' -ErrorAction SilentlyContinue
