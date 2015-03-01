# Niche Recruiting Challenges

## Indexing College Reviews

### Overview

Clone the Ruby branch of this repository.

```
$ git clone https://github.com/AnthonyMastrean/niche.git --branch ruby --single-branch niche
```

Pipe the list of cached reviews to the command and provide a keyword for searching.

```
$ ls .cache/*.txt | niche "baseball"
```

### Example Output

```
$ ls .cache/*.txt | niche "baseball"

Concordia University - Wisconsin: 2 reviews
Dawson Community College: 2 reviews
Ozark Christian College: 2 reviews
Avila University: 1 reviews
California Baptist University: 1 reviews
California State University - Chico: 1 reviews
```
