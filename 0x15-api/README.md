# 0x15. API

<p align="center">
  <img src="https://img.shields.io/badge/API-Integration-blue.svg" alt="API Integration">
  <img src="https://img.shields.io/badge/Python-Scripts-green.svg" alt="Python Scripts">
  <img src="https://img.shields.io/badge/Data-Processing-orange.svg" alt="Data Processing">
  <img src="https://img.shields.io/badge/REST-API-red.svg" alt="REST API">
</p>

## Project Overview

This repository focuses on API integration, specifically retrieving data from a REST API, processing it, and exporting it to various data formats (CSV, JSON). The project demonstrates how to interact with external services programmatically, extract relevant information, and transform it for different use cases.

## Background Context

In modern software development, interactions between services commonly happen through APIs (Application Programming Interfaces). APIs allow for programmatic access to data and functionality of external systems. This project provides a practical introduction to consuming REST APIs using Python.

Old-school system administrators often rely on Bash scripting for system tasks, but more modern approaches leverage higher-level languages like Python to interact with APIs and process complex data structures. This transition from Bash to Python for certain tasks represents a shift towards more maintainable and scalable solutions.

## Learning Objectives

By the end of this project, you should be able to explain:

* What Bash scripting should not be used for
* What is an API and its purpose
* What is a REST API and its characteristics
* What are microservices and their benefits
* What is the CSV format and its common uses
* What is the JSON format and its advantages
* The Python coding style and how to check code with PEP8

## Requirements

* Ubuntu 20.04 LTS
* Python 3.8.5
* Libraries: requests, json, csv
* Code should follow PEP8 style (version 2.8.0)
* All files must be executable
* All modules should have proper documentation
* Use `if __name__ == "__main__":` to ensure code is not executed when imported

## Project Tasks

### 0. Gather data from an API
**[0-gather_data_from_an_API.py](0-gather_data_from_an_API.py)**

Requirements:
- Write a Python script that returns information about an employee's TODO list progress
- Use the REST API: https://jsonplaceholder.typicode.com/
- Script must accept an integer as a parameter, which is the employee ID
- Display the employee TODO list progress in the format:
  ```
  Employee NAME is done with tasks(NUMBER_DONE/TOTAL_NUMBER):
     TASK_TITLE
     TASK_TITLE
     ...
  ```
- Only display completed tasks

### 1. Export to CSV
**[1-export_to_CSV.py](1-export_to_CSV.py)**

Requirements:
- Extend the previous script to export data in CSV format
- Records all tasks owned by the employee
- Format: `"USER_ID","USERNAME","TASK_COMPLETED_STATUS","TASK_TITLE"`
- File name must be: `USER_ID.csv`

### 2. Export to JSON
**[2-export_to_JSON.py](2-export_to_JSON.py)**

Requirements:
- Extend the script to export data in JSON format
- Records all tasks owned by the employee
- Format:
  ```json
  {
    "USER_ID": [
      {
        "task": "TASK_TITLE",
        "completed": TASK_COMPLETED_STATUS,
        "username": "USERNAME"
      },
      {
        "task": "TASK_TITLE",
        "completed": TASK_COMPLETED_STATUS,
        "username": "USERNAME"
      },
      ...
    ]
  }
  ```
- File name must be: `USER_ID.json`

### 3. Dictionary of list of dictionaries
**[3-dictionary_of_list_of_dictionaries.py](3-dictionary_of_list_of_dictionaries.py)**

Requirements:
- Extend the script to export data in JSON format for all employees
- Records all tasks from all employees
- Format:
  ```json
  {
    "USER_ID": [
      {
        "username": "USERNAME",
        "task": "TASK_TITLE",
        "completed": TASK_COMPLETED_STATUS
      },
      {
        "username": "USERNAME",
        "task": "TASK_TITLE",
        "completed": TASK_COMPLETED_STATUS
      },
      ...
    ],
    "USER_ID": [
      {
        "username": "USERNAME",
        "task": "TASK_TITLE",
        "completed": TASK_COMPLETED_STATUS
      },
      ...
    ]
  }
  ```
- File name must be: `todo_all_employees.json`

## APIs and REST Architecture

### What is an API?

An API (Application Programming Interface) is a set of rules and protocols that allows different software applications to communicate with each other. APIs define the methods and data formats that applications can use to request and exchange information.

Key benefits of APIs:
- Enable integration between different systems
- Allow access to functionality without exposing underlying implementation
- Promote modular development and microservices architecture
- Facilitate third-party development on top of existing platforms

### REST API Principles

REST (Representational State Transfer) is an architectural style for designing networked applications. RESTful APIs adhere to the following principles:

1. **Client-Server Architecture**: Separation of concerns between client and server
2. **Statelessness**: Each request contains all information needed to complete it
3. **Cacheability**: Responses should define themselves as cacheable or non-cacheable
4. **Uniform Interface**: Resources are identified in requests, are manipulated through representations, messages are self-descriptive, and HATEOAS (Hypermedia as the Engine of Application State)
5. **Layered System**: Client cannot tell whether it's connected directly to the server or intermediary
6. **Code on Demand** (optional): Servers can temporarily extend client functionality

### HTTP Methods in REST APIs

RESTful APIs typically use standard HTTP methods for different operations:

| Method | Purpose | Safe | Idempotent |
|--------|---------|------|------------|
| GET | Retrieve resource(s) | Yes | Yes |
| POST | Create a new resource | No | No |
| PUT | Update a resource completely | No | Yes |
| PATCH | Update a resource partially | No | No |
| DELETE | Remove a resource | No | Yes |
| HEAD | Like GET but no response body | Yes | Yes |
| OPTIONS | Get allowed HTTP methods | Yes | Yes |

## Data Formats

### CSV (Comma-Separated Values)

CSV is a simple file format used to store tabular data, such as a spreadsheet or database. Each line represents a row of data, with fields separated by commas.

Characteristics:
- Text-based and human-readable
- Widely supported by different applications
- Easy to process and generate
- Not standardized (variations exist)
- Limited to flat, tabular data
- No support for data types or nested structures

Example CSV:
```csv
id,name,email,active
1,John Doe,john@example.com,true
2,Jane Smith,jane@example.com,false
```

### JSON (JavaScript Object Notation)

JSON is a lightweight data-interchange format that is easy for humans to read and write and easy for machines to parse and generate. It's based on a subset of JavaScript syntax.

Characteristics:
- Text-based and relatively human-readable
- Language-independent
- Supports nested structures
- Supports multiple data types
- Widely used in web APIs
- Well-standardized

Example JSON:
```json
{
  "users": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "active": true,
      "roles": ["admin", "editor"]
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "email": "jane@example.com",
      "active": false,
      "roles": ["viewer"]
    }
  ]
}
```

## Python API Integration Best Practices

### Using the Requests Library

The requests library simplifies HTTP requests in Python:

```python
import requests

# Making a GET request
response = requests.get('https://api.example.com/users')
users = response.json()  # Parse JSON response

# Making a POST request with data
new_user = {'name': 'John', 'email': 'john@example.com'}
response = requests.post('https://api.example.com/users', json=new_user)
```

### Error Handling

Always implement proper error handling when working with APIs:

```python
import requests

try:
    response = requests.get('https://api.example.com/users')
    response.raise_for_status()  # Raise an exception for 4XX/5XX responses
    users = response.json()
except requests.exceptions.HTTPError as err:
    print(f"HTTP error occurred: {err}")
except requests.exceptions.ConnectionError:
    print("Connection error occurred")
except requests.exceptions.Timeout:
    print("Request timed out")
except requests.exceptions.RequestException as err:
    print(f"Error occurred: {err}")
except ValueError:  # Includes JSONDecodeError
    print("Invalid JSON response")
```

### Authentication

Many APIs require authentication:

```python
# Basic Authentication
response = requests.get('https://api.example.com/users', 
                       auth=('username', 'password'))

# API Key (as query parameter)
response = requests.get('https://api.example.com/users', 
                       params={'api_key': 'your_api_key'})

# API Key (in header)
headers = {'Authorization': 'Bearer your_api_token'}
response = requests.get('https://api.example.com/users', headers=headers)
```

### Rate Limiting and Pagination

Implement techniques to handle API limitations:

```python
# Pagination example
all_data = []
page = 1
while True:
    response = requests.get('https://api.example.com/users', 
                           params={'page': page, 'per_page': 100})
    data = response.json()
    if not data:  # No more data
        break
    all_data.extend(data)
    page += 1
    
    # Simple rate limiting
    time.sleep(1)  # Wait 1 second between requests
```

## Resources

* [RESTful API Design: Best Practices](https://restfulapi.net/)
* [Python Requests Library Documentation](https://docs.python-requests.org/en/latest/)
* [Working with JSON in Python](https://docs.python.org/3/library/json.html)
* [CSV File Reading and Writing in Python](https://docs.python.org/3/library/csv.html)
* [Introduction to APIs (Mozilla)](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Introduction)
* [JSON Placeholder API Documentation](https://jsonplaceholder.typicode.com/) - The API used in this project
* [Understanding REST and RESTful APIs](https://www.codecademy.com/article/what-is-rest)
* [Python PEP8 Style Guide](https://www.python.org/dev/peps/pep-0008/)

---

*Project by ALX System Engineering & DevOps*
