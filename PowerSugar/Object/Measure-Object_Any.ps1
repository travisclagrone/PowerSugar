function Measure-Object_Any {
    end {
        foreach ($element in $Input) {
            if ($element) {
                return $true
            }
        }
        return $false
    }
}

Set-Alias -Name 'any' -Value 'Measure-Object_Any' -ErrorAction SilentlyContinue

Export-ModuleMember -Function 'Measure-Object_Any' -Alias 'any'
