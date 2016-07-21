function Get-Review([string] $url, [string] $item) {
  $progressPreference = "SilentlyContinue"
  (Invoke-WebRequest $url).Content | Set-Content $item
  $progressPreference = "Continue"
}

function Initialize-ReviewCache {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string[]] $InputObject
  )

  Write-Progress -Activity "Indexing College Reviews"

  foreach($url in $Input) {
    $progress++
    $completed = $progress / $Input.count * 100

    $item = Join-Path $CACHE_DIR (Split-Path $url -Leaf)

    if(-not(Test-Path $item)) {
      Get-Review $url $item
    }

    if((Get-ChildItem $item).LastWriteTime -le $CACHE_EXPIRY) {
      Get-Review $url $item
    }

    Write-Progress -Activity "Indexing College Reviews" -Status "Fetching Reviews" -CurrentOperation $url -PercentComplete $completed
    $item
  }

  Write-Progress -Activity "Indexing College Reviews" -Completed
}
