## The Bigram Parsing Problem

Create an application that can take as input any text file and output a
histogram of the bigrams in the text.

### Description

A bigram is any two adjacent words in the text. A histogram is the count of how
many times that particular bigram occurred in the text.

A well formed submission will be runnable from command line and have
accompanying unit tests for the bigram parsing and counting code. You may do
this in any language you wish and use any framework or data structures you wish
to handle reading the files, building up the output, and running the unit
tests. However the bigram parsing and counting code must be implemented by
yourself.

### Example

Given the text: “The quick brown fox and the quick blue hare.” The bigrams with
their counts would be.

 * “the quick” 2
 * “quick brown” 1
 * “brown fox” 1
 * “fox and” 1
 * “and the” 1
 * “quick blue” 1
 * “blue hare” 1

### Tests

Tests are written using [Pester](https://github.com/pester/Pester). Clone the
module to your PowerShell Modules directory and ensure it's loaded in the
current session.

```powershell
PS> Import-Module Pester
```

Run all tests by invoking Pester.

```powershell
PS> Invoke-Pester
```

### Usage

Import the module to gain access to these cmdlets in the current session.

```powershell
PS> Import-Module ./ngrams
```

You can pipe text directly from the console.

```powershell
PS> "The quick brown fox and the quick blue hare." | Get-NGrams | Format-Histogram

Name  Value
----  -----
and   x
blue  x
brown x
fox   x
hare  x
quick xx
The   xx
```

Or use the `Get-Content` cmdlet.

```powershell
PS> Get-Content .\random.txt | Get-NGrams | Format-Histogram

Name           Value
----           -----
a              xxxxxxxxx
add            xxx
also           xx
and            xxxxxxxxx
another        x
appears        x
apply          x
before         x
best           x
box            x
...
```

### Simple Usage

While the above describes "idiomatic" PowerShell (that is cmdlets provided by
modules and chaining those cmdlets in a pipeline), I have provided a convencience
bigrams batch file (`bigrams.bat`).

This accepts a file path as the first and only parameter.

```
> bigrams.bat .\random.txt
```

### Performance

The cmdlet, `Get-Ngrams`, and the cmdlets it calls interally, `Split-Text`
and `Select-Window`, properly stream input from the PowerShell pipeline. This
means that they should perform well (if input is uniform) and should begin
processing input as soon as possible (in the case of `Select-Window`, that is
dependent on the window size).

You should provide input to `Get-NGrams` in a pipeline/streaming compatible way.
The `Get-Content` cmdlet provides file content line-by-line, for example.

Necessarily, any grouping, comparisons, or sorting will "collect" the pipeline
and block progress and consume more resources (like memory) than any single
execution of the pipeline. This means, if you pipe to `Format-Histogram`, you'll
experience delays and resource constraints.

Examples:

 * The `random.txt`, provided in this project, is just over 1KB and returns a
   bigram histogram almost immediately.

 * The text of 20,000 Leagues Under the Sea is 500KB and returns a bigram
   histgram in about 5 minutes.

 * The text of War & Peace is nearly 5MB and _does not_ return a bigram
   histogram in any reasonable amount of time!

Despite not returning, at no time does the largest input crash the system or 
consume memory in a linear or greater fashion. The memory use only approaches
the size of the input.

### References

 * [Skeleton Project](https://bitbucket.org/vaeinc/testenginterview/src)
 * [Sample Text Files](http://www.textfiles.com/etext/FICTION/)
