#Requires -Module Pester

BeforeAll {
    Import-Module 'PowerSugar' -DisableNameChecking -ErrorAction Stop
}

Describe 'Get-LocalDateTime' {
    It 'is exported from PowerSugar' {
        (Get-Module 'PowerSugar').ExportedCommands.Keys | Should -Contain 'Get-LocalDateTime'
    }
    It 'is aliased as "now"' {
        Get-Alias -Definition 'Get-LocalDateTime' -ErrorAction Ignore | Should -Be 'now'
    }
    Context 'when invoking it via its alias' {
        It 'returns a DateTime object of the Local kind' {
            $LocalDateTime = now
            $LocalDateTime | Should -BeOfType ([DateTime])
            $LocalDateTime.Kind | Should -Match ([DateTimeKind]::Local)
        }
        It 'returns the current local datetime' {
            $LocalDateTimeBefore = [DateTime]::Now
            $LocalDateTime = now
            $LocalDateTimeAfter = [DateTime]::Now

            $LocalDateTime | Should -BeGreaterThan $LocalDateTimeBefore
            $LocalDateTime | Should -BeLessThan $LocalDateTimeAfter
        }
    }
}

AfterAll {
    Get-Module 'PowerSugar' -ErrorAction SilentlyContinue | Remove-Module
}
