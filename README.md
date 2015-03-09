# Niche Recruiting Challenges

## Indexing College Reviews

### Overview

Clone the Ruby branch of this repository.

```
$ git clone https://<username>@github.com/AnthonyMastrean/niche.git --branch ruby --single-branch niche
```

> This version is incomplete and depends on an existing cache of text files.

Pipe the list of cached reviews to the command and provide a keyword for searching.

```
$ ls .cache/*.txt | niche "baseball"
```

### Example Output

The results are sorted by count and name.

```
$ ls .cache/*.txt | niche "baseball"

Concordia University - Wisconsin: 2 reviews
Dawson Community College: 2 reviews
Ozark Christian College: 2 reviews
Avila University: 1 reviews
California Baptist University: 1 reviews
California State University - Chico: 1 reviews
```

You can limit the total output using normal bash commands. For example, the top 3 search results:

```
$ ls .cache/*.txt | niche "baseball" | head -3

Concordia University - Wisconsin: 2 reviews
Dawson Community College: 2 reviews
Ozark Christian College: 2 reviews
```
