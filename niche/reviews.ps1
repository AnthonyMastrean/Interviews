function Get-Review {
  [CmdletBinding()]
  param(
    [Parameter(
      Mandatory = $true, 
      Position = 0, 
      ValueFromPipeline = $true, 
      ValueFromPipelinebyPropertyName = $true)]
    [string[]] $InputObject
  )

  foreach ($item in $Input) {
    $processed++
    $completed = $processed / $Input.count * 100

    Write-Progress -Activity "Indexing College Reviews" -Status "Fetching URLs" -CurrentOperation $item -PercentComplete $completed

    $progressPreference = "SilentlyContinue"
    $content = (Invoke-WebRequest $item).Content
    $progressPreference = "Continue"

    $school, $reviews = $content -split "`n"
    $item | Select-Object -Property @{Name = "School"; Expression = {$school}}, @{Name = "Reviews"; Expression = {$reviews}}
  }

  Write-Progress -Activity "Indexing College Reviews" -Completed
}
