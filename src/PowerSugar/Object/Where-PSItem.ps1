using namespace System.Diagnostics.CodeAnalysis

function Where-PSItem {
    <#
    .SYNOPSIS
        Selects objects from a collection based on their values.

    .DESCRIPTION
        The `Where-PSItem` command selects objects that have particular values from the collection of objects that is passed to it. The default parameter set (without any arguments other than InputObject), is equivalent to `Where-Object { $_ }`. `Where-PSItem` is aliased as `?_`.

    .EXAMPLE
        PS> -1..1 | Where-PSItem
        -1
        1

    .EXAMPLE
        PS> -1..1 | Where-PSItem -Not
        0

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -EQ 'a'
        a
        A

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -CEQ 'a'
        a

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -NE 'a'
        b
        B

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -CNE 'a'
        A
        b
        B

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -GT 'a'
        b
        B

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -CGT 'a'
        A
        B
        b

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -LT 'B'
        a
        A

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -CLT 'B'
        a
        A
        b

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -GE 'A'
        a
        A
        b
        B

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -CGE 'A'
        A
        b
        B

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -LE 'b'
        a
        A
        b
        B

    .EXAMPLE
        PS> 'a', 'A', 'b', 'B' | Where-PSItem -CLE 'b'
        a
        A
        b

    .EXAMPLE
        PS> 'zero', 'one', 'two' | Where-PSItem -Like '*o'
        zero
        two

    .EXAMPLE
        PS> 'zero', 'one', 'two' | Where-PSItem -NotLike '*o'
        one

    .EXAMPLE
        PS> 'UPPER', 'lower' | Where-PSItem -CLike '*R'
        UPPER

    .EXAMPLE
        PS> 'UPPER', 'lower' | Where-PSItem -CNotLike '*R'
        lower

    .EXAMPLE
        PS> 'zero', 'one', 'two' | Where-PSItem -Match '.*o$'
        zero
        two

    .EXAMPLE
        PS> 'zero', 'one', 'two' | Where-PSItem -NotMatch '.*o$'
        one

    .EXAMPLE
        PS> 'UPPER', 'lower' | Where-PSItem -CMatch '.*R$'
        UPPER

    .EXAMPLE
        PS> 'UPPER', 'lower' | Where-PSItem -CNotMatch '.*R$'
        lower

    .EXAMPLE
        PS> @(0, 1), @(1, 2), @(2, 3) | Where-PSItem -Contains 3
        2, 3

    .EXAMPLE
        PS> @(0, 1), @(1, 2), @(2, 3) | Where-PSItem -NotContains 3
        0, 1
        1, 2

    .EXAMPLE
        PS> @('UPPER', 'LOWER'), @('upper', 'lower') | Where-PSItem -CContains 'UPPER'
        UPPER, LOWER

    .EXAMPLE
        PS> @('UPPER', 'LOWER'), @('upper', 'lower') | Where-PSItem -CNotContains 'UPPER'
        upper, lower

    .EXAMPLE
        PS> -1, 1 | Where-PSItem -In 1..10
        1

    .EXAMPLE
        PS> -1, 1 | Where-PSItem -NotIn 1..10
        -1

    .EXAMPLE
        PS> 'uppercase', 'lowercase' | Where-PSItem -CIn 'UPPERCASE', 'lowercase'
        lowercase

    .EXAMPLE
        PS> 'uppercase', 'lowercase' | Where-PSItem -CNotIn 'UPPERCASE', 'lowercase'
        uppercase

    .EXAMPLE
        PS> 'one', 1 | Where-PSItem -Is string
        one

    .EXAMPLE
        PS> 'one', 1 | Where-PSItem -IsNot string
        1

    .NOTES
        The `Where-PSItem` command is similar to the `Where-Object` command. One difference is that `Where-PSItem` operates on input object values whereas `Where-Object` operates on input object property values. Another difference is that `Where-PSItem` accepts the comparison value directly through each faux-operator parameter, whereas `Where-Object` accepts the comparison value through a `-Value` parameter rather than the faux-operator parameters.

    .LINK
        Where-Object
    #>
    [Alias('?_')]
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='bool', RemotingCapability='None')]
    [SuppressMessage('PSUseApprovedVerbs', '', Justification = 'Used for syntactic sugar only in interactive sessions.')]
    param(
        # The input object to filter.
        [Parameter(ValueFromPipeline)]
        [PSObject]
        $InputObject,

        # Indicates that this command passes through input objects that are falsy.
        [Parameter(ParameterSetName='Not', Mandatory)]
        [switch]
        $Not,

        # The value against which to compare each input object for equality. Equal input objects are passed through.
        [Parameter(ParameterSetName='EQ', Mandatory)]
        [Alias('IEQ')]
        [PSObject]
        $EQ,

        # The value against which to compare each input object for case-sensitive equality. Case-sensitively equal input objects are passed through.
        [Parameter(ParameterSetName='CEQ', Mandatory)]
        [PSObject]
        $CEQ,

        # The value against which to compare each input object for inequality. Unequal input objects are passed through.
        [Parameter(ParameterSetName='NE', Mandatory)]
        [Alias('INE')]
        [PSObject]
        $NE,

        # The value against which to compare each input object for case-sensitive inequality. Case-sensitively unequal input objects are passed through.
        [Parameter(ParameterSetName='CNE', Mandatory)]
        [PSObject]
        $CNE,

        # The value against which to compare each input object for precedence. Greater input objects are passed through.
        [Parameter(ParameterSetName='GT', Mandatory)]
        [Alias('GIT')]
        [PSObject]
        $GT,

        # The value against which to compare each input object for case-sensitive precedence. Case-sensitively greater input objects are passed through.
        [Parameter(ParameterSetName='CGT', Mandatory)]
        [PSObject]
        $CGT,

        # The value against which to compare each input object for precedence. Lesser input objects are passed through.
        [Parameter(ParameterSetName='LT', Mandatory)]
        [Alias('ILT')]
        [PSObject]
        $LT,

        # The value against which to compare each input object for case-sensitive precedence. Case-sensitively lesser input objects are passed through.
        [Parameter(ParameterSetName='CLT', Mandatory)]
        [PSObject]
        $CLT,

        # The value against which to compare each input object for precedence or equality. Greater or equal input objects are passed through.
        [Parameter(ParameterSetName='GE', Mandatory)]
        [Alias('IGE')]
        [PSObject]
        $GE,

        # The value against which to compare each input object for case-sensitive precedence or equality. Case-sensitively greater or equal input objects are passed through.
        [Parameter(ParameterSetName='CGI', Mandatory)]
        [PSObject]
        $CGE,

        # The value against which to compare each input object for precedence or equality. Lesser or equal input objects are passed through.
        [Parameter(ParameterSetName='LE', Mandatory)]
        [Alias('ILE')]
        [PSObject]
        $LE,

        # The value against which to compare each input object for case-sensitive precedence or equality. Case-sensitively lesser or equal input objects are passed through.
        [Parameter(ParameterSetName='CLE', Mandatory)]
        [PSObject]
        $CLE,

        # The value against which to compare each input object for wildcard-similarity. Wildcard-similar input objects are passed through.
        [Parameter(ParameterSetName='Like', Mandatory)]
        [Alias('ILike')]
        [System.String]
        $Like,

        # The value against which to compare each input object for case-sensitive wildcard-similarity. Case-sensitively wildcard-similar input objects are passed through.
        [Parameter(ParameterSetName='CLike', Mandatory)]
        [System.String]
        $CLike,

        # The value against which to compare each input object for wildcard-similarity. Wildcard-similar input objects are passed through.
        [Parameter(ParameterSetName='NotLike', Mandatory)]
        [Alias('INotLike')]
        [System.String]
        $NotLike,

        # The value against which to compare each input object for case-sensitive wildcard-similarity. Case-sensitively wildcard-similar input objects are passed through.
        [Parameter(ParameterSetName='CNotLike', Mandatory)]
        [System.String]
        $CNotLike,

        # The value against which to compare each input object for pattern-matching. Pattern-matching input objects are passed through.
        [Parameter(ParameterSetName='Match', Mandatory)]
        [Alias('IMatch')]
        [System.Text.RegularExpressions.Regex]
        $Match,

        # The value against which to compare each input object for case-sensitive pattern-matching. Case-sensitively pattern-matching input objects are passed through.
        [Parameter(ParameterSetName='CMatch', Mandatory)]
        [System.Text.RegularExpressions.Regex]
        $CMatch,

        # The value against which to compare each input object for pattern-mismatching. Pattern-mismatching input objects are passed through.
        [Parameter(ParameterSetName='NotMatch', Mandatory)]
        [Alias('INotMatch')]
        [System.Text.RegularExpressions.Regex]
        $NotMatch,

        # The value against which to compare each input object for case-sensitive pattern-mismatching. Case-sensitively pattern-mismatching input objects are passed through.
        [Parameter(ParameterSetName='CNotMatch', Mandatory)]
        [System.Text.RegularExpressions.Regex]
        $CNotMatch,

        # The value against which to compare each input object for containment. Containing input objects are passed through.
        [Parameter(ParameterSetName='Contains', Mandatory)]
        [Alias('IContains')]
        [PSObject]
        $Contains,

        # The value against which to compare each input object for case-sensitive containment. Case-sensitively containing input objects are passed through.
        [Parameter(ParameterSetName='CContains', Mandatory)]
        [PSObject]
        $CContains,

        # The value against which to compare each input object for non-containment. Non-containing input objects are passed through.
        [Parameter(ParameterSetName='NotContains', Mandatory)]
        [Alias('INotContains')]
        [PSObject]
        $NotContains,

        # The value against which to compare each input object for case-sensitive non-containment. Case-sensitively non-containing input objects are passed through.
        [Parameter(ParameterSetName='CNotContains', Mandatory)]
        [PSObject]
        $CNotContains,

        # The value against which to compare each input object for membership. Member input objects are passed through.
        [Parameter(ParameterSetName='In', Mandatory)]
        [Alias('IIn')]
        [System.Collections.IList]
        $In,

        # The value against which to compare each input object for case-sensitive membership. Case-sensitive member input objects are passed through.
        [Parameter(ParameterSetName='CIn', Mandatory)]
        [System.Collections.IList]
        $CIn,

        # The value against which to compare each input object for nonmembership. Nonmember input objects are passed through.
        [Parameter(ParameterSetName='NotIn', Mandatory)]
        [Alias('INotIn')]
        [System.Collections.IList]
        $NotIn,

        # The value against which to compare each input object for case-sensitive nonmembership. Case-sensitive nonmember input objects are passed through.
        [Parameter(ParameterSetName='CNotIn', Mandatory)]
        [System.Collections.IList]
        $CNotIn,

        # The value against which to compare each input object for type-instantiation. Type-instance input objects are passed through.
        [Parameter(ParameterSetName='Is', Mandatory)]
        [System.Type]
        $Is,

        # The value against which to compare each input object for disjoint type-instantiation. Non-type-instance input objects are passed through.
        [Parameter(ParameterSetName='IsNot', Mandatory)]
        [System.Type]
        $IsNot
    )
    begin {
        try {
            $filter = switch ($PSCmdlet.ParameterSetName) {
                'bool'         {{ $_ }}
                'Not'          {{ -not $_ }}
                'EQ'           {{ $_ -eq $EQ }}
                'CEQ'          {{ $_ -ceq $CEQ }}
                'NE'           {{ $_ -ne $NE }}
                'CNE'          {{ $_ -cne $CNE }}
                'GT'           {{ $_ -gt $GT }}
                'CGT'          {{ $_ -cgt $CGT }}
                'LT'           {{ $_ -lt $LT }}
                'CLT'          {{ $_ -clt $CLT }}
                'GE'           {{ $_ -ge $GE }}
                'CGE'          {{ $_ -cge $CGE }}
                'LE'           {{ $_ -le $LE }}
                'CLE'          {{ $_ -cle $CLE }}
                'Like'         {{ $_ -like $Like }}
                'CLike'        {{ $_ -clike $CLike }}
                'NotLike'      {{ $_ -notlike $NotLike }}
                'CNotLike'     {{ $_ -cnotlike $CNotLike }}
                'Match'        {{ $_ -match $Match }}
                'CMatch'       {{ $_ -cmatch $CMatch }}
                'NotMatch'     {{ $_ -notmatch $NotMatch }}
                'CNotMatch'    {{ $_ -cnotmatch $CNotMatch }}
                'Contains'     {{ $_ -contains $Contains }}
                'CContains'    {{ $_ -ccontains $CContains }}
                'NotContains'  {{ $_ -notcontains $NotContains }}
                'CNotContains' {{ $_ -cnotcontains $CNotContains }}
                'In'           {{ $_ -in $In }}
                'CIn'          {{ $_ -cin $CIn }}
                'NotIn'        {{ $_ -notin $NotIn }}
                'CNotIn'       {{ $_ -cnotin $CNotIn }}
                'Is'           {{ $_ -is $Is }}
                'IsNot'        {{ $_ -isnot $IsNot }}
                default {
                    $message = "Unimplemented parameter set name: '$($PSCmdlet.ParameterSetName)'."
                    throw [NotImplementedException]::new($message)
                }
            }
            $wrappedParameters = @{ FilterScript = $filter }

            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Core\Where-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = { & $wrappedCmd @wrappedParameters }

            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }
    process {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }
    end {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
}

Set-Alias -Name '?_' -Value 'Where-PSItem' -ErrorAction SilentlyContinue
