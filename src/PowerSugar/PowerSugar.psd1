@{
    # Identification
    GUID = '7243db9b-c472-4fea-8483-b85681426f7a'
    ModuleVersion = '0.0.6'

    # Description
    Author = 'Travis C. LaGrone'
    CompanyName = $null
    Copyright = '2020 (c) Travis C. LaGrone. All rights reserved.'
    Description = 'PowerShell "sugar", e.g. concisely aliased proxy functions for common command parameterizations. Intended for use in interactive sessions.'

    # Compatibility Requirements
    CompatiblePSEditions = 'Core'
    PowerShellVersion = '7.1'  # Minimum version of the PowerShell engine required by this module
    PowerShellHostName = $null
    PowerShellHostVersion = $null  # Minimum version of the PowerShell host required by this module
    ProcessorArchitecture = $null  # Processor architecture (None, X86, Amd64) required by this module

    <# Dependencies
     # These dependencies are required to already exist in the _caller's_ session state when importing this module.
     # If they don't, then PSGet will attempt to automatically fulfill these requirements:
     # - E.g. installs for the user any required modules that are not installed; ONLY occurs during initial installation.
     # - E.g. imports into the caller's session state any required modules that are not imported.
     #>
    RequiredModules = @()
    RequiredAssemblies = @()

    <# PreProcessing
     # These resources are automatically processed in the _caller's_ session state when this module is imported,
     # but before this module's nested modules (if any) and/or root module (if any) are processed.
     #>
    ScriptsToProcess = @()
    TypesToProcess = @(
        'TimeSpan/TimeSpan.Types.ps1xml'
    )
    FormatsToProcess = @()

    <# Processing
     # These modules (assmeblies and scripts) are automatically processed inside a _new_ child session state when
     # this module is imported, but after all preprocessing (if any) of the caller's session state is completed.
     # 1. A new session state is created for this module.
     # 2. Nested modules and nested non-module scripts are processed in this module's new session state.
     #    - Nested modules create nested session state, but nested non-module scripts (*.ps1) do not.
     # 3. The root module is then processed in this module's session state.
     #>
    NestedModules = @()  # May also include non-module scripts (*.ps1).
    RootModule = 'PowerSugar.psm1'  # A single optional binary or script module.

    <# PostProcessing
     # After all nested modules/scripts and the root module (if any) are loaded, the following identifiers are
     # injected ("exported") from this module's session state into the caller's session state. The referenced members
     # (functions, aliases, variables, etc.) are accessible in the caller's session state, but are bound to and
     # resolved against this module's session state. (NOTE: It is the referenced objects that are tied to this
     # module's session state, not the exported identifiers themselves, which may be independently changed later.)
     #>
    FunctionsToExport = @(
        # DateTime/
        'Get-Now'
        'Get-Timestamp'
        'Get-Today'

        # Member/
        'Get-MemberType'

        # Object/
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

        # PSItem/
        'Where-PSItem'
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @(
        # DateTime/
        'now'        # Get-Now
        'timestamp'  # Get-Timestamp
        'today'      # Get-Today

        # Member/
        'gmt'  # Get-MemberType

        # Object/
        'all'     # Measure-Object_All
        'any'     # Measure-Object_Any
        'avg'     # Measure-Object_Average
        'chars'   # Measure-Object_Character
        'count'   # Measure-Object_Count
        'lines'   # Measure-Object_Line
        'max'     # Measure-Object_Maximum
        'min'     # Measure-Object_Minimum
        'stats'   # Measure-Object_AllStats
        'stddev'  # Measure-Object_StandardDeviation
        'sum'     # Measure-Object_Sum
        'words'   # Measure-Object_Word
        'first'      # Select-Object_First
        'index'      # Select-Object_Index
        'last'       # Select-Object_Last
        'skip'       # Select-Object_Skip
        'skipindex'  # Select-Object_SkipIndex
        'skiplast'   # Select-Object_SkipLast

        # PSItem/
        '?_'  # Where-PSItem
    )
    DscResourcesToExport = @()

    # Manifest of resources packaged with this module. (documentation only; never processed)
    ModuleList = @()
    FileList = @(
        'PowerSugar.psd1'
        'PowerSugar.psm1'

        'DateTime/Get-Now.ps1'
        'DateTime/Get-Timestamp.ps1'
        'DateTime/Get-Today.ps1'

        'Member/Get-MemberType.ps1'

        'Object/Measure-Object_All.ps1'
        'Object/Measure-Object_AllStats.ps1'
        'Object/Measure-Object_Any.ps1'
        'Object/Measure-Object_Average.ps1'
        'Object/Measure-Object_Character.ps1'
        'Object/Measure-Object_Count.ps1'
        'Object/Measure-Object_Line.ps1'
        'Object/Measure-Object_Maximum.ps1'
        'Object/Measure-Object_Minimum.ps1'
        'Object/Measure-Object_StandardDeviation.ps1'
        'Object/Measure-Object_Sum.ps1'
        'Object/Measure-Object_Word.ps1'
        'Object/Select-Object_First.ps1'
        'Object/Select-Object_Index.ps1'
        'Object/Select-Object_Last.ps1'
        'Object/Select-Object_Skip.ps1'
        'Object/Select-Object_SkipIndex.ps1'
        'Object/Select-Object_SkipLast.ps1'

        'PSItem/Where-PSItem.ps1'

        'TimeSpan/TimeSpan.Types.ps1xml'
    )

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{

        # Publication & Installation
        PSData = @{

            # Classification metadata to support discoverability by search.
            #   (e.g. tags are searchable across the PowerShellGallery repository)
            Tags = @(
                'alias'
                'core'
                'datetime'
                'object'
                'proxy'
                'psitem'
                'sugar'
                'timespan'
                'wrapper'
            )

            # Project metadata and resources.
            #   (e.g. legal matters, governance, branding, contributing, etc.)
            LicenseUri = 'https://raw.githubusercontent.com/travis-c-lagrone/PowerSugar/master/LICENSE.txt'
            ProjectUri = 'https://github.com/travis-c-lagrone/PowerSugar'
            IconUri = ''

            # Release metadata and documentation.
            Prerelease = ''  # Formally identifies the prerelease state (if any) of this module, e.g. "alpha.1"
            ReleaseNotes = ''  # Documents the changes made in this release.

            # Installation requirements external to PowerShell package management.
            #   (e.g. legal contracts, system-level dependencies, etc.)
            RequireLicenseAcceptance = $false
            ExternalModuleDependencies = @()
        }
    }

    # Integrations that configure how various commands built in to the core PowerShell runtime process this module.
    #   (e.g. links for online Get-Help, defaults for Import-Module parameters etc.)
    HelpInfoURI = ''
    DefaultCommandPrefix = ''
}
