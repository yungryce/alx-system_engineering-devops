# Project Manifest: API Advanced

## Project Identity
- **Name**: API Advanced
- **Type**: Educational
- **Scope**: API Interaction and Data Processing
- **Status**: Completed

## Technology Signature
- **Core**: Python
- **Environment**: Ubuntu 20.04 LTS
- **Libraries**: Requests
- **APIs**: Reddit API
- **Style Guide**: PEP 8 (version 1.7.*)
- **Documentation Standard**: docstrings for all modules, classes, and methods

## Demonstrated Competencies
- API Documentation Navigation
- HTTP Request Construction
- JSON Data Parsing
- Recursive API Data Collection
- Pagination Implementation
- Error Handling in API Contexts
- User-Agent Configuration
- Rate Limit Management
- Keyword Counting and Sorting
- Advanced String Processing
- Query Parameter Manipulation
- Data Aggregation Techniques
- RESTful API Best Practices

## System Context
This component enhances system administration capabilities by providing methods to programmatically interact with web APIs, extract and process data from external services, and implement proper error handling for network requests - skills essential for monitoring, automation, and data collection in modern infrastructure environments.

## Development Requirements
- Python 3.4.3 or higher
- Requests library
- Internet access for API calls
- Reddit API knowledge
- Understanding of JSON data structures
- Knowledge of recursion principles
- Familiarity with HTTP status codes

## Development Workflow
1. Read API documentation to understand endpoints
2. Design functions to interact with specific API endpoints
3. Implement proper headers and authentication if required
4. Handle potential errors and edge cases
5. Implement pagination for collecting complete datasets
6. Process and transform data as needed
7. Test with various subreddits including invalid ones
8. Optimize for performance and reliability

## Maintenance Notes
- All Python scripts have proper shebang line (#!/usr/bin/python3)
- Every file includes comprehensive documentation
- Functions implement proper error handling
- Code follows PEP 8 style guidelines
- User-Agent headers are properly configured
- Rate limiting considerations are implemented
- Recursive functions have proper base cases

## Implementation Specifics

### Basic API Interaction
- **Subscriber Count**: [0-subs.py](./0-subs.py)
  - Queries the Reddit API for subscriber count
  - Handles invalid subreddits
  - Properly formats User-Agent header

### Intermediate API Data Processing
- **Top Ten Posts**: [1-top_ten.py](./1-top_ten.py)
  - Retrieves and prints the top 10 hot posts
  - Handles invalid subreddits gracefully
  - Implements error checking

### Advanced Recursive API Collection
- **Complete Hot Articles**: [2-recurse.py](./2-recurse.py)
  - Recursively collects all hot articles
  - Implements pagination handling
  - Manages 'after' token for continuation
  - Builds complete dataset through recursion

### Complex Data Analysis
- **Keyword Counting**: [100-count.py](./100-count.py)
  - Parses article titles for keywords
  - Implements case-insensitive matching
  - Counts occurrences of each keyword
  - Sorts results by count and alphabetically
  - Handles complete pagination through recursion