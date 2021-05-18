#Requires -Module Pester

BeforeAll {
    Import-Module 'PowerSugar' -DisableNameChecking -ErrorAction Stop
}

Describe 'Get-UniversalDateTime' {
    It 'is exported from PowerSugar' {
        (Get-Module 'PowerSugar').ExportedCommands.Keys | Should -Contain 'Get-UniversalDateTime'
    }
    It 'is aliased as "utcnow"' {
        Get-Alias -Definition 'Get-UniversalDateTime' -ErrorAction Ignore | Should -Be 'utcnow'
    }
    Context 'when invoking it via its alias' {
        It 'returns a DateTime object of the Utc kind' {
            $UniversalDateTime = utcnow
            $UniversalDateTime | Should -BeOfType ([DateTime])
            $UniversalDateTime.Kind | Should -Match ([DateTimeKind]::Utc)
        }
        It 'returns the current UTC datetime' {
            $UniversalDateTimeBefore = [DateTime]::UtcNow
            $UniversalDateTime = utcnow
            $UniversalDateTimeAfter = [DateTime]::UtcNow

            $UniversalDateTime | Should -BeGreaterOrEqual $UniversalDateTimeBefore
            $UniversalDateTime | Should -BeLessOrEqual $UniversalDateTimeAfter
        }
    }
}

AfterAll {
    Get-Module 'PowerSugar' -ErrorAction SilentlyContinue | Remove-Module
}
