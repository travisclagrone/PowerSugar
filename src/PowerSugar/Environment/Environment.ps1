New-Variable `
    -Name 'LineSep' `
    -Value $([System.Environment]::NewLine) `
    -Description '[System.Environment]::NewLine' `
    -Option ReadOnly `
    -Force `
    -WarningAction SilentlyContinue `
    -ErrorAction Continue
