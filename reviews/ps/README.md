# Recruiting Challenges

## Indexing College Reviews

Import the module to kickoff indexing and provide access to search functions.

```
PS> Import-Module main.psm1
```

### Overview

The module provides a few external commands. The short command `reviewsfor` combines searching and pretty-printing.

```
PS> Get-Command -Module Main

CommandType     Name                                               ModuleName
-----------     ----                                               ----------
Function        reviewsfor                                         main
Function        Format-ReviewIndex                                 main
Function        Search-ReviewIndex                                 main
```

### Example Output

With the reviews cached, you're ready to search!

```
PS> Search-ReviewIndex "baseball"

School                               Count
------                               -----
Tacoma Community College                 1
Northern State University                1
Lake Michigan College                    1
Mercer County Community College          1
Concordia University - Wisconsin         2
California State University - Fresno     1
Ozark Christian College                  2
University of Wisconsin - Stout          1
Avila University                         1
California Baptist University            1
```

You can pipe that output through a pretty printer to sort and format the data.

```
PS> Search-ReviewIndex "baseball" | Format-ReviewIndex

School                                          Count
------                                          -----
Concordia University - Wisconsin                    2
Dawson Community College                            2
Ozark Christian College                             2
Avila University                                    1
California Baptist University                       1
California State University - Chico                 1
California State University - Fresno                1
City Colleges of Chicago - Kennedy-King College     1
Columbia College Chicago                            1
Concordia University Irvine                         1
```

Use the common `Select-Object` cmdlet to limit the output to a reasonable length.

```
PS> Search-ReviewIndex "baseball" | Format-ReviewIndex | Select-Object -First 3

School                                          Count
------                                          -----
Concordia University - Wisconsin                    2
Dawson Community College                            2
Ozark Christian College                             2
```
