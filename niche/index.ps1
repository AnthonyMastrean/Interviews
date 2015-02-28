$HTML_CODE = '&\w*;'
$PUNCTUATION = '[^\w\s]'

function Invoke-ParseReview {
  param(
    [string] $target
  )

  $school, $reviews = (Get-Content $target) -split "`n"
  $target | Select-Object -Property @{Name = "School"; Expression = {$school}}, @{Name = "Reviews"; Expression = {$reviews}}
}

function Invoke-IndexReview {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [PSObject[]] $InputObject,
    [Parameter(Mandatory = $true)]
    [string[]] $StopWords = (Get-Content .\stopWords.txt)
  )

  $index = @{}
  $Input `
    | %{ $_ -replace $HTML_CODE, ""  } `
    | %{ $_ -replace $PUNCTUATION, "" } `
    | %{ -split $_ } `
    | Sort-Object `
    | Get-Unique `
    | ?{ $StopWords -notcontains $_ } `
    | %{ 
      Write-Progress -Activity "Indexing College Reviews" -Status "Indexing Reviews" -CurrentOperation $review.School

      if(-not $index[$_]) { $index.Add($_, @{}) }
      if(-not $index[$_][$review.School]){ $index[$_].Add($review.School, 0) }
      $index[$_][$review.School] += 1 
    }

  $index
}
