#Requires -Module Pester

BeforeAll {
    Import-Module 'PowerSugar' -DisableNameChecking -ErrorAction Stop
}

Describe 'Get-FileDateUniversal' {
    It 'is exported from PowerSugar' {
        (Get-Module 'PowerSugar').ExportedCommands.Keys | Should -Contain 'Get-FileDateUniversal'
    }
    It 'is aliased as "futctoday"' {
        Get-Alias -Definition 'Get-FileDateUniversal' -ErrorAction Ignore | Should -Be 'futctoday'
    }
    Context 'when invoking it via its alias' {
        It 'returns a string of the FileDateUniversal format' {
            $fileDateUniversal = futctoday
            $fileDateUniversal | Should -BeOfType ([string])
            $fileDateUniversal | Should -Match '^\d{4}\d{2}\d{2}Z$' -Because 'the FileDateUniversal format is "yyyymmddZ"'
        }
        It 'returns the current FileDateUniversal' {
            $olderFileDateUniversal = Get-Date -Format FileDateUniversal
            $currentFileDateUniversal = futctoday
            $newerFileDateUniversal = Get-Date -Format FileDateUniversal

            $currentFileDateUniversal | Should -BeGreaterOrEqual $olderFileDateUniversal
            $currentFileDateUniversal | Should -BeLessOrEqual $newerFileDateUniversal
        }
    }
}

AfterAll {
    Get-Module 'PowerSugar' -ErrorAction SilentlyContinue | Remove-Module
}
