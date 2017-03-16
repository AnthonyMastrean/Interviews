function Split-Text {

    [CmdletBinding()]
    Param(
        [Alias('Text')]
        [Parameter(ValueFromPipeline = $true)]
        [string[]] $InputObject = ''
    )

    Begin {}

    Process {
        foreach($text in $InputObject) {
            $text `
                | Select-String -Pattern '\w+' -AllMatches `
                | Select-Object -ExpandProperty Matches `
                | Select-Object -ExpandProperty Value
        }
    }

    End {}

}

function Select-Window {

    [CmdletBinding()]
    Param(
        [Alias('Sequence')]
        [Parameter(ValueFromPipeline = $true)]
        [PSObject[]] $InputObject = @(),

        [Parameter()]
        [int] $Size = 1
    )

    Begin {
        $queue = New-Object -TypeName 'System.Collections.Queue' -ArgumentList $Size
    }

    Process {
        foreach($item in $InputObject) {
            $queue.Enqueue($item)
            if($queue.Count -eq $Size) {
                try {
                    ,$queue.ToArray()
                } finally {
                    [void]$queue.Dequeue()
                }
            }
        }
    }

    End {}

}

function Get-NGrams {

    [CmdletBinding()]
    Param(
        [Alias('Text')]
        [Parameter(ValueFromPipeline = $true)]
        [string[]] $InputObject = '',

        [Parameter()]
        [int] $N = 1
    )

    Begin {}

    Process {
        foreach($text in $InputObject) {
            $text `
                | Split-Text `
                | Select-Window -Size $N `
                | %{ $_ -join ' ' }
        }
    }

    End {}
}

function Format-Histogram {

    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline = $true)]
        [PSObject[]] $InputObject
    )

    $Input `
        | Group-Object `
        | Sort-Object Name `
        | Select-Object Name,@{Name='Value';Expression={'x' * $_.Count}} `
        | Format-Table -AutoSize

}

Export-ModuleMember -Function *
