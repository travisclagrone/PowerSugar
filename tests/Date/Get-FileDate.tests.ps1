#Requires -Module Pester

BeforeAll {
    Import-Module 'PowerSugar' -DisableNameChecking -ErrorAction Stop
}

Describe 'Get-FileDate' {
    It 'is exported from PowerSugar' {
        (Get-Module 'PowerSugar').ExportedCommands.Keys | Should -Contain 'Get-FileDate'
    }
    It 'is aliased as "ftoday"' {
        Get-Alias -Definition 'Get-FileDate' -ErrorAction Ignore | Should -Be 'ftoday'
    }
    Context 'when invoking it via its alias' {
        It 'returns a string of the FileDate format' {
            $fileDate = ftoday
            $fileDate | Should -BeOfType ([string])
            $fileDate | Should -Match '^\d{4}\d{2}\d{2}$' -Because 'the FileDate format is "yyyymmdd"'
        }
        It 'returns the current FileDate' {
            $olderFileDate = Get-Date -Format FileDate
            $currentFileDate = ftoday
            $newerFileDate = Get-Date -Format FileDate

            $currentFileDate | Should -BeGreaterOrEqual $olderFileDate
            $currentFileDate | Should -BeLessOrEqual $newerFileDate
        }
    }
}

AfterAll {
    Get-Module 'PowerSugar' -ErrorAction SilentlyContinue | Remove-Module
}
