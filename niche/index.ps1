$HTML_CODE = '&\w*;'
$PUNCTUATION = '[^\w\s]'

function Initialize-ReviewIndex {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [PSObject[]] $InputObject,
    [Parameter(Mandatory = $true, Position = 0)]
    [string[]] $StopWords = @()
  )

  BEGIN {
    $index = @{}
  }
  
  PROCESS {
    foreach($item in $InputObject) {
      $school, $reviews = (Get-Content $item) -split "`n"
      $keywords = $reviews `
        | %{ $_ -replace $HTML_CODE, '' } `
        | %{ $_ -replace $PUNCTUATION, '' } `
        | %{ -split $_ } `
        | ?{ $StopWords -notcontains $_ } `
        | Sort-Object `
        | Get-Unique

      foreach($keyword in $keywords) {
        Write-Progress -ParentId 1 -Id 3 -Activity "Indexing Reviews" -CurrentOperation $school

        if(-not $index[$keyword]) { 
          $index.Add($keyword, @{}) 
        }
        
        if(-not $index[$keyword][$school]) { 
          $index[$keyword].Add($school, 0) 
        }
        
        $index[$keyword][$school] += 1
      } 
    }
  }

  END {
    Write-Progress -Id 1 -Activity "Indexing College Reviews" -Completed

    $index
  }
  
}
