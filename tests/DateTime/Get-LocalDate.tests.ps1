#Requires -Module Pester

BeforeAll {
    Import-Module 'PowerSugar' -DisableNameChecking -ErrorAction Stop
}

Describe 'Get-LocalDate' {
    It 'is exported from PowerSugar' {
        (Get-Module 'PowerSugar').ExportedCommands.Keys | Should -Contain 'Get-LocalDate'
    }
    It 'is aliased as "today"' {
        Get-Alias -Definition 'Get-LocalDate' -ErrorAction Ignore | Should -Be 'today'
    }
    Context 'when invoking it via its alias' {
        It 'returns a DateTime object of the Local kind' {
            $LocalDate = today
            $LocalDate | Should -BeOfType ([DateTime])
            $LocalDate.Kind | Should -Match ([DateTimeKind]::Local)
        }
        It 'returns the current local date' {
            $LocalDateBefore = [DateTime]::Today
            $LocalDate = today
            $LocalDateAfter = [DateTime]::Today

            $LocalDate | Should -BeGreaterOrEqual $LocalDateBefore
            $LocalDate | Should -BeLessOrEqual $LocalDateAfter
            $LocalDate.TimeOfDay | Should -Be ([TimeSpan]::Zero) -Because 'a "date" should not have a time component'
        }
    }
}

AfterAll {
    Get-Module 'PowerSugar' -ErrorAction SilentlyContinue | Remove-Module
}
