# Project Manifest: API

## Project Identity
- **Name**: API (Application Programming Interfaces)
- **Type**: Educational
- **Scope**: API Integration and Data Processing
- **Status**: Completed

## Technology Signature
- **Core**: Python
- **Environment**: Unix/Linux
- **Libraries**: requests, json, csv
- **API Platform**: JSONPlaceholder
- **Style Guide**: PEP8
- **Data Formats**: JSON, CSV

## Demonstrated Competencies
- REST API Consumption
- HTTP Request Handling
- JSON Parsing and Processing
- Data Serialization/Deserialization
- CSV Export Implementation
- JSON File Creation
- Command-line Argument Processing
- API Response Handling
- Script Parameterization
- Data Format Conversion
- Error Handling

## System Context
This component builds upon system administration knowledge by introducing programmatic interaction with web services through APIs. It demonstrates the transition from shell scripting to Python for more complex data processing tasks, focusing on retrieving, manipulating, and exporting data from external services.

## Development Requirements
- Python 3.4.3 or later
- Ubuntu 14.04 LTS
- PEP8 compliant code style (version 1.7.*)
- Access to the JSONPlaceholder API (https://jsonplaceholder.typicode.com/)
- requests library (`pip3 install requests`)

## Development Workflow
1. Read project specifications and requirements
2. Understand the JSONPlaceholder API structure
3. Design Python scripts to retrieve data
4. Parse and format API responses
5. Implement data export in specified formats
6. Test scripts with different employee IDs
7. Ensure proper error handling
8. Document the code
9. Submit for automated and peer review

## Maintenance Notes
- All Python scripts include proper shebang line (#!/usr/bin/python3)
- Each script includes a module docstring describing its functionality
- Scripts have proper execution permissions
- Code follows PEP8 style guidelines
- API endpoint URLs are consistent across scripts
- Error handling is implemented to handle connection issues

## Implementation Specifics

### Employee TODO Progress
- **Gather Data**: [0-gather_data_from_an_API.py](./0-gather_data_from_an_API.py)
  - Retrieves employee TODO list progress using employee ID
  - Displays employee name and completed tasks count
  - Lists completed task titles

### Data Export
- **Export to CSV**: [1-export_to_CSV.py](./1-export_to_CSV.py)
  - Exports employee TODO list in CSV format
  - Creates file named `USER_ID.csv`
  - Uses CSV format: "USER_ID","USERNAME","TASK_COMPLETED_STATUS","TASK_TITLE"

- **Export to JSON**: [2-export_to_JSON.py](./2-export_to_JSON.py)
  - Exports employee TODO list in JSON format
  - Creates file named `USER_ID.json`
  - JSON format: {"USER_ID":{"tasks":[{"task":"TASK_TITLE","completed":TASK_COMPLETED_STATUS,"username":"USERNAME"}]}}

- **Dictionary of List of Dictionaries**: [3-dictionary_of_list_of_dictionaries.py](./3-dictionary_of_list_of_dictionaries.py)
  - Exports all employees' TODO lists to a single JSON file
  - Creates file named `todo_all_employees.json`
  - JSON format: {"USER_ID":[{"username":"USERNAME","task":"TASK_TITLE","completed":TASK_COMPLETED_STATUS}]}