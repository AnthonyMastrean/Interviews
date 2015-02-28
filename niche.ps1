# Let's say we have an entry point like this...
#
#   PS> niche "foo"
# 
# And a data structure like this...
# 
#   @{
#     "keyword" = @{
#       "School A" = 10;
#       "School B" = 2;
#     }
#   }
#
# We can search the index like...
#
#   $idx["keyword"] | %{ Write-Host "Matches ${count} reviews for ${school}" }
# 

Get-ChildItem niche\*.ps1 | %{ . $_ }

$stop_words = Get-Content stopWords.txt
$urls = Get-Content urls.txt

$idx = $urls | Get-Review | Write-ReviewIndex
