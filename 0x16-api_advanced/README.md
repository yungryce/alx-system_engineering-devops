# API Advanced

<p align="center">
  <img src="https://img.shields.io/badge/API-Reddit-orange.svg" alt="Reddit API">
  <img src="https://img.shields.io/badge/Python-API_Requests-blue.svg" alt="Python API Requests">
  <img src="https://img.shields.io/badge/HTTP-REST-green.svg" alt="HTTP REST">
  <img src="https://img.shields.io/badge/JSON-Parsing-yellow.svg" alt="JSON Parsing">
</p>

## Project Overview

This repository provides a deep dive into advanced API interaction techniques, focusing on the Reddit API. Working with APIs is an essential skill for system engineers and developers, as it allows programmatic access to external services and data sources. Through this project, you'll learn how to query APIs, handle authentication, process JSON responses, and implement recursive data collection strategies.

## Learning Objectives

By the end of this project, you should be able to explain:

* How to read API documentation to find the endpoints you're looking for
* How to use an API with pagination
* How to parse JSON results from an API
* How to make a recursive API call
* How to sort a dictionary by value
* How to handle API rate limiting and authentication
* How to implement proper error handling for API requests
* How to work with the Reddit API specifically
* How to process and analyze data from API responses

## Requirements

* Ubuntu 20.04 LTS
* Python 3.4.3 or higher
* PEP 8 style (version 1.7.*)
* All Python files must be executable (`chmod +x filename`)
* Libraries: requests, sys
* Proper documentation for all modules, classes, and methods
* Error handling for all edge cases (invalid subreddits, network issues, etc.)

## Project Tasks

### 0. How many subscribers?
**[0-subs.py](0-subs.py)**

Requirements:
- Write a function that queries the Reddit API and returns the number of subscribers for a given subreddit
- If an invalid subreddit is given, the function should return 0
- Function prototype: `def number_of_subscribers(subreddit)`
- You must use the Reddit API's JSON format
- Format for User-Agent header must follow proper conventions

Example:
```python
#!/usr/bin/python3
"""
0-main
"""
import sys

if __name__ == '__main__':
    number_of_subscribers = __import__('0-subs').number_of_subscribers
    if len(sys.argv) < 2:
        print("Please pass an argument for the subreddit to search.")
    else:
        print("{:d}".format(number_of_subscribers(sys.argv[1])))
```

### 1. Top Ten
**[1-top_ten.py](1-top_ten.py)**

Requirements:
- Write a function that queries the Reddit API and prints the titles of the first 10 hot posts for a given subreddit
- If an invalid subreddit is given, the function should print None
- Function prototype: `def top_ten(subreddit)`
- You must use the Reddit API's JSON format
- Format for User-Agent header must follow proper conventions

Example:
```python
#!/usr/bin/python3
"""
1-main
"""
import sys

if __name__ == '__main__':
    top_ten = __import__('1-top_ten').top_ten
    if len(sys.argv) < 2:
        print("Please pass an argument for the subreddit to search.")
    else:
        top_ten(sys.argv[1])
```

### 2. Recurse it!
**[2-recurse.py](2-recurse.py)**

Requirements:
- Write a recursive function that queries the Reddit API and returns a list containing the titles of all hot articles for a given subreddit
- If no results are found for the given subreddit, the function should return None
- Function prototype: `def recurse(subreddit, hot_list=[])`
- You must use the Reddit API's JSON format
- Format for User-Agent header must follow proper conventions
- The function must implement pagination to collect all results regardless of limit
- Note: You may need to use recursion to efficiently handle the pagination

Example:
```python
#!/usr/bin/python3
"""
2-main
"""
import sys

if __name__ == '__main__':
    recurse = __import__('2-recurse').recurse
    if len(sys.argv) < 2:
        print("Please pass an argument for the subreddit to search.")
    else:
        result = recurse(sys.argv[1])
        if result is not None:
            print(len(result))
        else:
            print("None")
```

### 3. Count it!
**[100-count.py](100-count.py)**

Requirements:
- Write a recursive function that queries the Reddit API, parses the title of all hot articles, and prints a sorted count of given keywords
- If no posts match or the subreddit is invalid, print nothing
- Function prototype: `def count_words(subreddit, word_list)`
- Words with the same count should be sorted alphabetically
- Words in `word_list` are case-insensitive, and should be compared in lowercase
- Words with no matches should not be displayed
- Results should be printed in descending order, by count
- Format: `<word>: <count>`
- You must use recursion to efficiently handle large datasets

Example:
```python
#!/usr/bin/python3
"""
100-main
"""
import sys

if __name__ == '__main__':
    count_words = __import__('100-count').count_words
    if len(sys.argv) < 3:
        print("Usage: {} <subreddit> <list of keywords>".format(sys.argv[0]))
        print("Ex: {} programming 'python java javascript'".format(sys.argv[0]))
    else:
        result = count_words(sys.argv[1], [x for x in sys.argv[2].split()])
```

## Working with the Reddit API

### API Basics

The Reddit API is a RESTful API that returns JSON responses. To interact with it, you'll need to:

1. Format proper HTTP requests
2. Set appropriate User-Agent headers
3. Parse JSON responses
4. Handle pagination (using the "after" parameter)
5. Implement error handling for various HTTP status codes

### Authentication

While many Reddit API endpoints can be accessed without authentication, it's good practice to:

1. Create a Reddit account
2. Set a unique and descriptive User-Agent header to identify your application
3. Format: `<platform>:<app ID>:<version string> (by /u/<reddit username>)`

Example User-Agent:
```
python:alx.advanced.api:v1.0.0 (by /u/your_username)
```

### Rate Limiting

The Reddit API implements rate limiting to prevent abuse. Your application should:

1. Handle 429 (Too Many Requests) status codes
2. Implement exponential backoff for retries
3. Cache responses when appropriate
4. Limit request frequency

### Pagination

Reddit API responses are paginated, typically returning up to 25 items per request. To get all results:

1. Extract the "after" parameter from the response
2. Use it in the next request to get the next page
3. Continue until "after" is null or empty
4. Combine results from all pages

This is where recursion becomes particularly useful.

## Tips for API Success

1. **Read the Docs**: Familiarize yourself with the [Reddit API Documentation](https://www.reddit.com/dev/api/)
2. **Test with Postman**: Use Postman or similar tools to test API endpoints before coding
3. **Proper Headers**: Always include proper User-Agent headers
4. **Error Handling**: Implement robust error handling for network issues, invalid responses, etc.
5. **Rate Limiting**: Be mindful of rate limits and implement backoff strategies
6. **Pagination**: Remember that most API results are paginated and you need to handle this
7. **Caching**: Consider caching responses to reduce API calls
8. **Logging**: Implement logging to track API interactions and troubleshoot issues

## Resources

* [Reddit API Documentation](https://www.reddit.com/dev/api/)
* [Query String](https://en.wikipedia.org/wiki/Query_string)
* [Python Requests Library](https://requests.readthedocs.io/en/master/)
* [Python Recursion](https://realpython.com/python-recursion/)
* [Working with JSON in Python](https://realpython.com/python-json/)
* [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
* [API Rate Limiting Best Practices](https://nordicapis.com/everything-you-need-to-know-about-api-rate-limiting/)

---

*Project by ALX System Engineering & DevOps*
