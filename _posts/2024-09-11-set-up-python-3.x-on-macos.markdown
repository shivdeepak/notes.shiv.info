---
layout: post
title:  "Set up Python, Ruby or Nodejs on macOS"
date:   2024-09-11 08:10:39 -0700
categories: devex
---

The best way to install Python, Ruby or Nodejs on macOS is through homebrew.

Infact, homebrew almost always has the most recent stable versions of the languages.

## Python

```shell
# Search for Available Versions
brew search python

# Install Python
brew install python@3.13
```

## Ruby

```shell
# Search for Available Versions
brew search ruby

# Install Ruby
brew install ruby@3.3
```

## Nodejs

```shell
# Search for Available Versions
brew search node

# Install Nodejs
brew install node@22
```

## Why Homebrew?

Using Homebrew provides a consistent and predictable way to
install and manage these languages.

Homebrew also handles dependencies and ensures that the
languages are installed in the correct locations. Moreover, other
homebrew packages know where to find these languages.

Also, when I configure my development environment in VS Code,
I know where to find the exectuatble regardless of the language.
