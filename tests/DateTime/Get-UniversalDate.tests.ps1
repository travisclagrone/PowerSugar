#Requires -Module Pester

BeforeAll {
    Import-Module 'PowerSugar' -DisableNameChecking -ErrorAction Stop
}

Describe 'Get-UniversalDate' {
    It 'is exported from PowerSugar' {
        (Get-Module 'PowerSugar').ExportedCommands.Keys | Should -Contain 'Get-UniversalDate'
    }
    It 'is aliased as "utctoday"' {
        Get-Alias -Definition 'Get-UniversalDate' -ErrorAction Ignore | Should -Be 'utctoday'
    }
    Context 'when invoking it via its alias' {
        It 'returns a DateTime object of the Utc kind' {
            $UniversalDate = utctoday
            $UniversalDate | Should -BeOfType ([DateTime])
            $UniversalDate.Kind | Should -Match ([DateTimeKind]::Utc)
        }
        It 'returns the current UTC date' {
            $UniversalDateBefore = [DateTime]::UtcNow.Date
            $UniversalDate = utctoday
            $UniversalDateAfter = [DateTime]::UtcNow.Date

            $UniversalDate | Should -BeGreaterOrEqual $UniversalDateBefore
            $UniversalDate | Should -BeLessOrEqual $UniversalDateAfter
        }
    }
}

AfterAll {
    Get-Module 'PowerSugar' -ErrorAction SilentlyContinue | Remove-Module
}
