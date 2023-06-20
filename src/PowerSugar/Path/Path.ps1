New-Variable `
    -Name 'AltDirSep' `
    -Value $([System.IO.Path]::AltDirectorySeparatorChar) `
    -Description '[System.IO.Path]::AltDirectorySeparatorChar' `
    -Option ReadOnly `
    -Force `
    -WarningAction SilentlyContinue `
    -ErrorAction Continue

New-Variable `
    -Name 'DirSep' `
    -Value $([System.IO.Path]::DirectorySeparatorChar) `
    -Description '[System.IO.Path]::DirectorySeparatorChar' `
    -Option ReadOnly `
    -Force `
    -WarningAction SilentlyContinue `
    -ErrorAction Continue

New-Variable `
    -Name 'PathSep' `
    -Value $([System.IO.Path]::PathSeparator) `
    -Description '[System.IO.Path]::PathSeparator' `
    -Option ReadOnly `
    -Force `
    -WarningAction SilentlyContinue `
    -ErrorAction Continue

New-Variable `
    -Name 'VolSep' `
    -Value $([System.IO.Path]::VolumeSeparatorChar) `
    -Description '[System.IO.Path]::VolumeSeparatorChar' `
    -Option ReadOnly `
    -Force `
    -WarningAction SilentlyContinue `
    -ErrorAction Continue
