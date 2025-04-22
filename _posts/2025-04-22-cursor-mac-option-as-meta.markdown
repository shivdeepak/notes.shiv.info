---
layout: post
title:  "How to Use Mac's Option Key as Alt Key in Cursor Terminal"
date:   2025-04-21 23:53:39 -0700
categories: VSCode
---

I love using `⌥ + b` and `⌥ + f` to quickly navigate through words in the terminal. This simple keyboard shortcut significantly speeds up my workflow. While I've [already configured iTerm2](https://notes.shiv.info/devex/2024/08/10/better-defaults-for-iterm2/) to remap the Option (⌥) key to work as the Alt key, I wanted the same functionality in Cursor's (or VS Code Equivalent) integrated terminal. Here's how you can set this up too:

1. Open Cursor on your Mac
2. Press `Cmd+Shift+P` to open the Command Palette
3. Type "Preferences: Open Settings (JSON)" and select it
4. Add this single line to your settings.json file:

    ```json
    {
        "terminal.integrated.macOptionIsMeta": true
    }
    ```
5. Save the file

That's it! Your Option key will now function as the Alt/Meta key in Cursor's integrated terminal.

### What This Does

This setting instructs Cursor to treat the Option key as the Meta key (which is equivalent to Alt in many terminal applications). This means keyboard combinations like `⌥ + b` or `⌥ + f` will now work as expected for moving backward or forward by words in the terminal.
