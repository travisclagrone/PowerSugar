@{
    RootModule = 'PowerSugar.psm1'
    ModuleVersion = '0.0.4'
    GUID = '7243db9b-c472-4fea-8483-b85681426f7a'

    Author = 'Travis C. LaGrone'
    Copyright = '2020 (c) Travis C. LaGrone. All rights reserved.'
    Description = 'PowerShell "sugar", e.g. concisely aliased proxy functions for common command parameterizations. Intended for use in interactive sessions.'

    CompatiblePSEditions = 'Core'
    PowerShellVersion = '7.0'

    RequiredModules = @()
    RequiredAssemblies = @()

    TypesToProcess = @(
        './TimeSpan/TimeSpan.Types.ps1xml'
    )
    FormatsToProcess = @()
    ScriptsToProcess = @()

    NestedModules = @()

    FunctionsToExport = @(
        'Get-FileDateTimeUniversal'
        'Get-FileDateUniversal'
        'Measure-Object_All'
        'Measure-Object_AllStats'
        'Measure-Object_Any'
        'Measure-Object_Average'
        'Measure-Object_Character'
        'Measure-Object_Count'
        'Measure-Object_Line'
        'Measure-Object_Maximum'
        'Measure-Object_Minimum'
        'Measure-Object_StandardDeviation'
        'Measure-Object_Sum'
        'Measure-Object_Word'
        'Select-Object_First'
        'Select-Object_Index'
        'Select-Object_Last'
        'Select-Object_Skip'
        'Select-Object_SkipIndex'
        'Select-Object_SkipLast'
        'Where-PSItem'
    )
    AliasesToExport = @(
        'now'
        'today'
        'all'
        'stats'
        'any'
        'avg'
        'chars'
        'count'
        'lines'
        'max'
        'min'
        'stddev'
        'sum'
        'words'
        'first'
        'index'
        'last'
        'skip'
        'skipindex'
        'skiplast'
        '?_'
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    DscResourcesToExport = @()

    ModuleList = @()
    FileList = @()

    PrivateData = @{

        PSData = @{

            Tags = @('core', 'sugar', 'object', 'psitem', 'wrapper', 'proxy', 'alias', 'filedate', 'timespan')

            LicenseUri = 'https://raw.githubusercontent.com/travis-c-lagrone/PowerSugar/master/LICENSE.txt'
            ProjectUri = 'https://github.com/travis-c-lagrone/PowerSugar'
            # IconUri = ''

            # ReleaseNotes = ''  # TODO write release notes
            # Prerelease = ''  # TODO update prerelease timestamp

            RequireLicenseAcceptance = $false

            ExternalModuleDependencies = @()
        }
    }

    # HelpInfoURI = ''
}
