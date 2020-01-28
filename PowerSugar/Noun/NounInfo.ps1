class NounInfo {
    [string] $Noun
    [System.Management.Automation.CommandInfo[]] $Commands
    [string[]] $Verbs
    [System.Management.Automation.PSModuleInfo[]] $Modules

    NounInfo([string] $noun, [System.Management.Automation.CommandInfo[]] $commands) {
        $this.Noun = $noun
        $this.Commands = $commands
        $this.Verbs = $commands.Verb | Where-Object { $_ } | Sort-Object -Unique
        $this.Modules = $commands.Module | Where-Object { $_ } | Sort-Object -Unique
    }
}
