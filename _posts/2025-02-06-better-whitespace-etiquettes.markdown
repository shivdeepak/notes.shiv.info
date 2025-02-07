---
layout: post
title:  "Better Whitespace Etiquettes"
date:   2025-02-06 17:52:39 -0700
categories: devex
---

I can't tell how many times I've come across codebases where hidden or missing
whitespace characters made pull requests messy, and git-blames difficult to read.

So, I always try to do these two things:

1. Trim trailing whitespaces on every line of the file.
2. And add a final new line character at the end of the file.

And there is no reason to remember this. I use the following editor (vscode / cursor)
config to handle this for me on save!

```json
{
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true
}
```

To access your editor config, open command palette `(cmd + shift + p)` and
type `Preferences: Open User Settings (JSON)`.
