#Requires -Module Pester

BeforeAll {
    Import-Module 'PowerSugar' -DisableNameChecking -ErrorAction Stop
}

Describe 'Get-FileDateTimeUniversal' {
    It 'is exported from PowerSugar' {
        (Get-Module 'PowerSugar').ExportedCommands.Keys | Should -Contain 'Get-FileDateTimeUniversal'
    }
    It 'is aliased as "futcnow"' {
        Get-Alias -Definition 'Get-FileDateTimeUniversal' -ErrorAction Ignore | Should -Be 'futcnow'
    }
    Context 'when invoking it via its alias' {
        It 'returns a string of the FileDateTimeUniversal format' {
            $fileDateTimeUniversal = futcnow
            $fileDateTimeUniversal | Should -BeOfType ([string])
            $fileDateTimeUniversal | Should -MatchExactly '^\d{4}\d{2}\d{2}T\d{2}\d{2}\d{2}\d{4}Z$' -Because 'the FileDateTimeUniversal format is "yyyymmddThhmmssffffZ"'
        }
        It 'returns the current FileDateTimeUniversal' {
            $olderFileDateTimeUniversal = Get-Date -Format FileDateTimeUniversal
            $currentFileDateTimeUniversal = futcnow
            $newerFileDateTimeUniversal = Get-Date -Format FileDateTimeUniversal

            $currentFileDateTimeUniversal | Should -BeGreaterOrEqual $olderFileDateTimeUniversal
            $currentFileDateTimeUniversal | Should -BeLessOrEqual $newerFileDateTimeUniversal
        }
    }
}

AfterAll {
    Get-Module 'PowerSugar' -ErrorAction SilentlyContinue | Remove-Module
}
