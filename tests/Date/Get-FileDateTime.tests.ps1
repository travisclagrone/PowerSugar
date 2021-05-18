#Requires -Module Pester

BeforeAll {
    Import-Module 'PowerSugar' -DisableNameChecking -ErrorAction Stop
}

Describe 'Get-FileDateTime' {
    It 'is exported from PowerSugar' {
        (Get-Module 'PowerSugar').ExportedCommands.Keys | Should -Contain 'Get-FileDateTime'
    }
    It 'is aliased as "fnow"' {
        Get-Alias -Definition 'Get-FileDateTime' -ErrorAction Ignore | Should -Be 'fnow'
    }
    Context 'when invoking it via its alias' {
        It 'returns a string of the FileDateTime format' {
            $fileDateTime = fnow
            $fileDateTime | Should -BeOfType ([string])
            $fileDateTime | Should -MatchExactly '^\d{4}\d{2}\d{2}T\d{2}\d{2}\d{2}\d{4}$' -Because 'the FileDateTime format is "yyyymmddThhmmssffff"'
        }
        It 'returns the current FileDateTime' {
            $olderFileDateTime = Get-Date -Format FileDateTime
            $currentFileDateTime = fnow
            $newerFileDateTime = Get-Date -Format FileDateTime

            $currentFileDateTime | Should -BeGreaterOrEqual $olderFileDateTime
            $currentFileDateTime | Should -BeLessOrEqual $newerFileDateTime
        }
    }
}

AfterAll {
    Get-Module 'PowerSugar' -ErrorAction SilentlyContinue | Remove-Module
}
