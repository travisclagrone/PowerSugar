function Measure-Count {
    <#
    .Synopsis
        Measures the count of the input objects.

    .Description
        Measures the count of all input objects--or one or more properties thereof--that are non-null. Null objects and properties are ignored. If there are zero non-null input objects, then the count is zero.

    .Parameter Property
        Specifies one or more properties to measure. If so, then for each property the count of objects with that property (whose value may be null) is measured. If not, then the count of non-null objects is measured, which may be zero.

    .Inputs
        System.Management.Automation.PSObject
            You can pipe objects to `Measure-Count`.

    .Outputs
        System.Int32, Microsoft.PowerShell.Commands.GenericMeasureInfo
            If more than one property is specified, then the command returns a GenericMeasureInfo object for each property. Otherwise, it returns an int.

    .Notes
        The InputObject parameter should not be invoked directly. Rather, input should piped to this command.

        This command is a wrapper function of `Measure-Object`.

    .Link
        Measure-Object
    #>

    [CmdletBinding(RemotingCapability='None')]
    [OutputType([System.Int32], [Microsoft.PowerShell.Commands.GenericMeasureInfo])]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [PSObject]
        $InputObject,

        [Parameter(Position=0)]
        [ValidateNotNullOrEmpty()]
        [PSPropertyExpression[]]
        $Property
    )

    end {
        try {
            $genericMeasureInfo =
                if ($PSBoundParameters.ContainsKey('Property')) {
                    $Input | Measure-Object -Property:$Property
                } else {
                    $Input | Measure-Object
                }

            if ($Property.Count -gt 1) {
                $genericMeasureInfo
            } else {
                $genericMeasureInfo.Count
            }
        } catch {
            throw
        }
    }
}

Set-Alias -Name 'count' -Value 'Measure-Count' -ErrorAction SilentlyContinue
