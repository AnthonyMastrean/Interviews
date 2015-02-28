$HTML_CODE = '&\w*;'
$PUNCTUATION = '[^\w\s]'

function Write-ReviewIndex { 
  [CmdletBinding()]
  param(
    [Parameter(
      Mandatory = $true, 
      Position = 0, 
      ValueFromPipeline = $true, 
      ValueFromPipelinebyPropertyName = $true)]
    [PSObject[]] $InputObject,
    [Parameter(
      Mandatory = $true,
      Position = 1)]
    [string[]] $StopWords = Get-Content stopWords.txt
  )

  $index = @{}
  foreach($item in $Input) {
    $processed++
    $completed = $processed / $Input.count * 100

    Write-Progress -Activity "Indexing College Reviews" -Status "Indexing Reviews" -CurrentOperation $item.School -PercentComplete $completed

    $item.Reviews `
      | %{ $_ -replace $HTML_CODE, ""  } `
      | %{ $_ -replace $PUNCTUATION, "" } `
      | %{ -split $_ } `
      | Sort-Object `
      | Get-Unique `
      | ?{ $stopwords -notcontains $_ } `
      | %{ 
        if(-not $index[$_]) { $index.Add($_, @{}) }
        if(-not $index[$_][$item.School]){ $index[$_].Add($item.School, 0) }
        $index[$_][$item.School] += 1 
      }
  }

  Write-Progress -Activity "Indexing College Reviews" -Completed

  $index
}
