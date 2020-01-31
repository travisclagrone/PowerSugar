function Measure-Object_AllStats {
    <#
    .Synopsis
        Measures common statistics of the input objects.

    .Description
        Measures common statistics of all input objects--or one or more properties thereof--that are non-null. Null objects and properties are ignored. If there are zero non-null input objects, then a single partial result is returned.

        The statistics measured are:

        1. Average
        2. Count
        3. Maximum
        4. Minimum
        5. StandardDeviation
        6. Sum

    .Parameter Property
        Specifies one or more numeric properties to measure. If no properties are specified, then either the object itself (if it is numeric) or the Count property of the object (if it is non-numeric), is measured.

    .Inputs
        System.Management.Automation.PSObject
            You can pipe objects to `Measure-Object_AllStats`.

    .Outputs
        Microsoft.PowerShell.Commands.GenericMeasureInfo
            If any properties are specified, then this command returns a GenericMeasureInfo object for each property. Otherwise, this command returns a single GenericMeasureInfo object.

            If there are zero non-null input objects, then a single GenericMeasureInfo object is returned wherein each measured statistic is either zero or null (depending on which is more appropriate for the measurement). The measurements that are zero are Count, StandardDeviation, and Sum. The measurements that are null are Average, Maximum, and Minimum.

    .Notes
        The InputObject parameter should not be invoked directly. Rather, input should piped to this command.

        This command is a wrapper function of `Measure-Object`.

    .Link
        Measure-Object
    #>

    [CmdletBinding(RemotingCapability='None')]
    [OutputType([Microsoft.PowerShell.Commands.GenericMeasureInfo])]
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
            if ($PSBoundParameters.ContainsKey('Property')) {
                $Input | Measure-Object -AllStats -Property:$Property
            } else {
                $Input | Measure-Object -AllStats
            }
        } catch {
            throw
        }
    }
}

Set-Alias -Name 'stats' -Value 'Measure-Object_AllStats' -ErrorAction SilentlyContinue
