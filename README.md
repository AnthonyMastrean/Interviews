# Niche Recruiting Challenges

## Indexing College Reviews

Clone the PowerShell branch of this repository.

```
PS> git clone git@github.com:AnthonyMastrean/niche.git --branch ps --single-branch niche
```

Import the Niche module to access the functions.

```
PS> Import-Module .\niche\niche.psm1
```

### Overview

The module provides a few external commands.

```
PS> Get-Command -Module Niche

CommandType     Name                                               ModuleName
-----------     ----                                               ----------
Function        Print-ReviewIndex                                  niche
Function        Refresh-ReviewIndex                                niche
Function        Search-ReviewIndex                                 niche
```

Start by Refreshing the review index, which should take a few minutes (depending on your connection speed). You will see progress on your screen. A cache of reviews will be stored locally in `.\.cache\`. The index will be created as a "dotfile" at `.\.index.xml`

### Example Output

With the cache prepared and index created, you're ready to search!

```
PS> Search-ReviewIndex "baseball"

Name   Value
----   -----
```

And we have provided a pretty-printing function that sorts, limits, and formats the table. This and other interaction/design choices have been influenced by PowerShell idioms: passing objects, formatting by piping to print functions, etc.

```
PS> Search-ReviewIndex "baseball" | Print-ReviewIndex

Name   Value
----   -----

```
