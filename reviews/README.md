# Recruiting Challenges

This task is not designed to test your ability to code exotic data structures to support full-text search. Your program only needs to support searches for single, complete, whitespace-separated, alpha-numeric keywords. We would like to see that you understand where latency exists and that you have techniques to mitigate it, as well as code organization and structure. You may implement your solution in any language you like, but you should pick one that is well-suited for the task at hand.

## Indexing College Reviews

Your program should allow the user to search many times once the index is created. You should try to minimize the amount of time the user has to wait before they can start searching the first time the program is run. Once the index has been created and the user starts searching, the results for each subsequent search should be returned “instantly.”

### Overview

Your task is to write a program that creates a basic index of user reviews of colleges and, once finished, allows the user to search these reviews by keyword.

There are roughly a thousand text files on one of our web servers that we would like to be able to search through. The first line of each text file is the name of a college in our system. The rest of the lines in each file are reviews about the college from users who have attended the school (one review per line).

The URLs for each of these “review files” are specified in a file that we will provide, called `urls.txt`, containing one URL per line.

Your program will read the URLs from `urls.txt`, download the review files, build a search index, ask the user to input a search keyword, and then return the names of all of the colleges containing that keyword.

### Example Output

```
indexing
http://niche­recruiting­reviews.appspot.com/FFE91BED0E9841B28906D20C215FF84B.txt
indexing
http://niche­recruiting­reviews.appspot.com/FFEDAA3CAD704665A78294741630C287.txt
Finished.
Enter a keyword to search: baseball
In 2 reviews for University of New Hampshire at Manchester
In 2 reviews for University of Miami
In 2 reviews for Dawson Community College
In 1 review for Tacoma Community College
In 1 review for Lake Michigan College
In 1 review for Mercer County Community College
In 1 review for Concordia University ­ Wisconsin
In 1 review for California State University ­ Fresno
In 1 review for University of Wisconsin ­ StoutIn 1 review for Avila University
In 1 review for Franklin & Marshall College
In 1 review for North Greenville University
In 1 review for City Colleges of Chicago ­ Kennedy­King College
In 1 review for Manhattanville College
In 1 review for Northwood University ­ West Palm Beach
In 1 review for California State University ­ Chico
In 1 review for North Dakota State University
In 1 review for University of South Alabama
```

### Contents

 * `urls.txt`: A list of URLs for review files, one per line.
 * `stopWords.txt`: A list of very common words, one per line, that you may wish to exclude from indexing.
