---
layout: post
title:  "Set up Python 3.x on macOS"
date:   2024-09-11 08:10:39 -0700
categories: python3 python macos miniconda anaconda conda
---

macOS Sanoma comes with preinstalled Python3, but I like to use miniconda (a minimal version of anaconda) 
to manage my python installation.

Why? Because I can manage multiple Python environments i.e. different versions of Python and also different
versions of Python Packages.

First, I will install `miniconda` from Homebrew.

```shell
brew install miniconda
```

Then, add the following line in your `~/.zshrc` (your shell init file):

```shell
eval "$(conda "shell.$(basename "${SHELL}")" hook)"
```

Now you can manage your Python installation on macOS with `conda`.
