function Invoke-IteratedFunction {
    [Alias('iterate')]
    [CmdletBinding(PositionalBinding = $false)]
    param(
        # The stateless process scriptblock / filter function to iterate over each input item.
        # All of $_, $PSItem, and $Input are bound within the process scriptblock / filter function.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNull()]
        [scriptblock]
        $Process,

        # The initial value to input to $Process.
        [Parameter(Mandatory, ValueFromPipeline)]
        [object]
        [AllowNull()]
        [Alias('InputObject')]
        $Seed,

        # Predicate of one input that determines whether to continue after each iteration.
        # The seed value is not tested; i.e. $Process will be invoked at least once.
        [Parameter()]
        [scriptblock]
        [ValidateNotNull()]
        $While = { $true },

        # Returns $Seed prior to the first invocation of $Process.
        [Parameter()]
        [switch]
        $PassThru,

        # Does not allow any output to be enumerated when written to the pipeline.
        # Applies to both $Seed (if -PassThru) as well as the output of each invocation of $Process.
        # Outputs of separate iterations of $Process are always written to the pipeline separately, regardless of -NoEnumerate.
        [Parameter()]
        [switch]
        $NoEnumerate
    )
    process {
        if ($PassThru) {
            Write-Output $Seed -NoEnumerate:$NoEnumerate
        }

        # ForEach-Object MUST be used to invoke $Process to get proper binding for _all_ automatic input variables.
        try {
            do {
                $Seed = ForEach-Object $Process -InputObject $Seed
                Write-Output $Seed -NoEnumerate:$NoEnumerate
            } while (ForEach-Object $While -InputObject $Seed)
        }
        catch {
            Write-Error -Exception $_
        }
    }
}
