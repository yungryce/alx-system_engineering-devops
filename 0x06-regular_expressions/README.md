# Regular Expressions

<p align="center">
  <img src="https://img.shields.io/badge/Regex-Patterns-green.svg" alt="Regex Patterns">
  <img src="https://img.shields.io/badge/Ruby-Implementation-red.svg" alt="Ruby Implementation">
  <img src="https://img.shields.io/badge/Pattern-Matching-blue.svg" alt="Pattern Matching">
  <img src="https://img.shields.io/badge/Text-Processing-orange.svg" alt="Text Processing">
</p>

## Project Overview

This repository provides an introduction to regular expressions (regex), focusing on pattern matching techniques, text extraction, and data validation. Regular expressions are a powerful tool used across programming languages for searching, replacing, and validating text based on pattern rules. In this project, we use Ruby to implement regex patterns for various text processing tasks.

## Learning Objectives

By the end of this project, you should be able to explain:

* What regular expressions are and their primary uses
* How to build regular expressions using various pattern elements
* How to use character classes, anchors, and quantifiers
* How to validate input strings against specific patterns
* How to extract data from text using capture groups
* How to implement regular expressions in Ruby
* How to test and debug regex patterns
* How to optimize regular expressions for performance
* Common regex use cases in system administration and development

## Requirements

* Ubuntu 20.04 LTS
* All Ruby files must be executable (`chmod +x filename`)
* All Ruby scripts will be interpreted on Ubuntu 20.04 LTS
* All regex must be built for the Oniguruma library (used by Ruby by default)
* Each script should be two lines long (shebang + code)

## Project Tasks

### 0. Simply matching School
**[0-simply_match_school.rb](0-simply_match_school.rb)**

Requirements:
- The regular expression must match "School"
- Using the project instructions, create a Ruby script that accepts one argument and pass it to a regular expression matching method

```ruby
#!/usr/bin/env ruby
puts ARGV[0].scan(/School/).join
```

### 1. Repetition Token #0
**[1-repetition_token_0.rb](1-repetition_token_0.rb)**

Requirements:
- Find the regular expression that will match specified patterns
- Using the project instructions, create a Ruby script that accepts one argument and pass it to a regular expression matching method

### 2. Repetition Token #1
**[2-repetition_token_1.rb](2-repetition_token_1.rb)**

Requirements:
- Find the regular expression that will match specified patterns
- Using the project instructions, create a Ruby script that accepts one argument and pass it to a regular expression matching method

### 3. Repetition Token #2
**[3-repetition_token_2.rb](3-repetition_token_2.rb)**

Requirements:
- Find the regular expression that will match specified patterns
- Using the project instructions, create a Ruby script that accepts one argument and pass it to a regular expression matching method

### 4. Repetition Token #3
**[4-repetition_token_3.rb](4-repetition_token_3.rb)**

Requirements:
- Find the regular expression that will match specified patterns
- Using the project instructions, create a Ruby script that accepts one argument and pass it to a regular expression matching method

### 5. Not quite HBTN yet
**[5-beginning_and_end.rb](5-beginning_and_end.rb)**

Requirements:
- The regular expression must be exactly matching a string that starts with 'h' ends with 'n' and can have any single character in between
- Using the project instructions, create a Ruby script that accepts one argument and pass it to a regular expression matching method

### 6. Call me maybe
**[6-phone_number.rb](6-phone_number.rb)**

Requirements:
- The regular expression must match a 10 digit phone number
- Using the project instructions, create a Ruby script that accepts one argument and pass it to a regular expression matching method

### 7. OMG WHY ARE YOU SHOUTING?
**[7-OMG_WHY_ARE_YOU_SHOUTING.rb](7-OMG_WHY_ARE_YOU_SHOUTING.rb)**

Requirements:
- The regular expression must be only matching capital letters
- Using the project instructions, create a Ruby script that accepts one argument and pass it to a regular expression matching method

### 8. TextMe
**[100-textme.rb](100-textme.rb)**

Requirements:
- Your script should output: `[SENDER],[RECEIVER],[FLAGS]`
- The sender phone number or name (including country code if present)
- The receiver phone number or name (including country code if present)
- The flags that were used
- Using the project instructions, create a Ruby script that accepts one argument and pass it to a regular expression matching method

## Regular Expression Basics

### What Is a Regular Expression?

A regular expression (regex or regexp) is a sequence of characters that define a search pattern. These patterns are used by string-searching algorithms for "find" or "find and replace" operations on strings, or for input validation.

Regular expressions are extremely powerful for:
- Validating text (e.g., emails, phone numbers)
- Searching for specific patterns in text
- Extracting information from text
- Replacing text based on patterns
- Splitting strings at specific delimiters

### Ruby Regex Implementation

In Ruby, regular expressions are represented by the `Regexp` class and can be created using the `/.../` literal syntax or the `Regexp.new` constructor. The most common regex operations in Ruby include:

- `match`: Tests if a pattern matches a string
- `scan`: Returns all matches of a pattern in a string
- `gsub`: Replaces all occurrences of a pattern
- `split`: Divides a string by a pattern

Example:
```ruby
"hello".match(/[aeiou]/)    # Matches "e"
"hello".scan(/[aeiou]/)     # Returns ["e", "o"]
"hello".gsub(/[aeiou]/, '*') # Returns "h*ll*"
"hello".split(/[aeiou]/)    # Returns ["h", "ll", ""]
```

## Regular Expression Syntax

### Basic Characters

| Character | Description |
|-----------|-------------|
| `a`, `b`, etc. | Match the exact character |
| `.` | Matches any character except newline |
| `\` | Escapes special characters |

### Character Classes

| Expression | Description |
|------------|-------------|
| `[abc]` | Matches any character in the brackets |
| `[^abc]` | Matches any character not in the brackets |
| `[a-z]` | Matches any character in the range |
| `\d` | Matches digits (equivalent to `[0-9]`) |
| `\w` | Matches word characters (equivalent to `[a-zA-Z0-9_]`) |
| `\s` | Matches whitespace characters |
| `\D` | Matches non-digits |
| `\W` | Matches non-word characters |
| `\S` | Matches non-whitespace characters |

### Anchors and Boundaries

| Expression | Description |
|------------|-------------|
| `^` | Matches beginning of line |
| `$` | Matches end of line |
| `\b` | Matches word boundary |
| `\B` | Matches non-word boundary |

### Quantifiers

| Expression | Description |
|------------|-------------|
| `*` | Matches 0 or more repetitions |
| `+` | Matches 1 or more repetitions |
| `?` | Matches 0 or 1 repetition (makes preceding token optional) |
| `{n}` | Matches exactly n repetitions |
| `{n,}` | Matches n or more repetitions |
| `{n,m}` | Matches between n and m repetitions |

### Greedy vs. Lazy Matching

By default, quantifiers are "greedy" and match as much as possible. Adding a `?` after a quantifier makes it "lazy" or "non-greedy" (matches as little as possible).

| Expression | Description |
|------------|-------------|
| `*?` | Lazy version of `*` |
| `+?` | Lazy version of `+` |
| `??` | Lazy version of `?` |
| `{n}?` | Lazy version of `{n}` |
| `{n,}?` | Lazy version of `{n,}` |
| `{n,m}?` | Lazy version of `{n,m}` |

### Grouping and Capturing

| Expression | Description |
|------------|-------------|
| `(...)` | Groups patterns and captures matched text |
| `(?:...)` | Groups patterns without capturing (non-capturing group) |
| `\1`, `\2`, etc. | Backreferences to captured groups |

### Alternation

| Expression | Description |
|------------|-------------|
| `a\|b` | Matches either "a" or "b" |

## Common Regex Patterns

### Email Validation
```
/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
```

### Phone Number Validation (US Format)
```
/^(\+\d{1,2}\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$/
```

### URL Validation
```
/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/
```

### Date Validation (YYYY-MM-DD)
```
/^([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))$/
```

### Strong Password Validation
```
/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/
```

## Testing and Debugging Regular Expressions

When working with regular expressions, it's helpful to use online tools for testing and debugging:

1. **Rubular** (https://rubular.com/) - A Ruby regular expression editor and tester
2. **Regex101** (https://regex101.com/) - A multi-language regex tester with detailed explanation
3. **RegExr** (https://regexr.com/) - An online tool to learn, build, and test regular expressions

## Optimizing Regular Expressions

Regular expressions can sometimes become computationally expensive. Here are some optimization tips:

1. **Be specific**: The more specific your regex, the faster it will run
2. **Avoid unnecessary capturing groups**: Use non-capturing groups `(?:...)` when you don't need the matched text
3. **Use anchors**: Anchoring with `^` and `$` can prevent unnecessary searching
4. **Avoid nested quantifiers**: Patterns like `(a+)+` can lead to catastrophic backtracking
5. **Use atomic groups**: `(?>...)` can prevent backtracking
6. **Validate input before applying regex**: Pre-filter data when possible

## Resources

* [Regular expressions - basics](https://www.regular-expressions.info/tutorial.html)
* [Regular expressions - advanced](https://www.regular-expressions.info/advanced.html)
* [Rubular: a Ruby regular expression editor](https://rubular.com/)
* [Ruby Regexp Documentation](https://ruby-doc.org/core/Regexp.html)
* [RegexOne - Learn Regular Expressions](https://regexone.com/)
* [The Bastards Book of Regular Expressions](http://regex.bastardsbook.com/)
* [Regular Expressions Cookbook](https://www.oreilly.com/library/view/regular-expressions-cookbook/9781449327453/)

---

*Project by ALX System Engineering & DevOps*
