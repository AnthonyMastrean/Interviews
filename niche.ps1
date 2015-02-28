# Let's say we have an entry point like this...
#
#   PS> niche "foo"
# 
# And a data structure like this...
# 
# @{
#   "keyword": @(
#     @{"School A", <count>},
#     @{"School B", <count>},
#   )
# }
# 

$stop_words = Get-Content "stopWords.txt"
$urls = Get-Content "urls.txt"

$urls_fetched = 0
$urls | %{
  $urls_fetched++
  Write-Progress -Activity "Indexing College Reviews" -Status "Fetching URLs" -CurrentOperation $_ -PercentComplete ($urls_fetched/$urls.length * 100)
  
  $progressPreference = "SilentlyContinue"
  Invoke-WebRequest $_ | Out-Null
  $progressPreference = "Continue"
}
