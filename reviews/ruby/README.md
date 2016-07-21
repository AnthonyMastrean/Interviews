# Recruiting Challenges

## Indexing College Reviews

> This version is incomplete and depends on an existing cache of text files.

### Overview

Pipe the list of cached reviews to the command and provide a keyword for searching.

```
$ ls .cache/*.txt | ./main "baseball"
```

### Example Output

The results are sorted by count and name.

```
$ ls .cache/*.txt | ./main "baseball"

Concordia University - Wisconsin: 2 reviews
Dawson Community College: 2 reviews
Ozark Christian College: 2 reviews
Avila University: 1 reviews
California Baptist University: 1 reviews
California State University - Chico: 1 reviews
```

You can limit the total output using normal bash commands. For example, the top 3 search results:

```
$ ls .cache/*.txt | ./main "baseball" | head -3

Concordia University - Wisconsin: 2 reviews
Dawson Community College: 2 reviews
Ozark Christian College: 2 reviews
```

### Installing

If you're running on Windows and have Ruby 1.9.3+ and a POSIX shell (I recommend Git Bash in the Git for Windows package), you're ready to go!

If not, you can download Git and Ruby using the [Chocolatey](http://chocolatey.org) package manager. Remember to restart your shell so that the `ruby` executable is in your PATH.

```
> choco install git
> choco install ruby -version 1.9.3.55100
```

If you're really in a bind, you can install Vagrant and Virtualbox.

```
> choco install vagrant
> choco install virtualbox
```

Boot up the provided box and hop inside. You'll be in an Ubuntu 14 environment with Ruby 1.9.3 installed.

```
$ vagrant up
$ vagrant ssh
$ cd /vagrant
```

The examples here have been tested in both environments. Any other options are at your own risk! For example, I just tested from PowerShell (which should work, because Ruby is ostensibly cross-platform :P)

```
PS> Get-ChildItem .cache/*.txt | Select-Object -ExpandProperty FullName | ruby .\main "baseball"
```
