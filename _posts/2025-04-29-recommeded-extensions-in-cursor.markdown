---
layout: post
title:  "How to specify recommended extensions in your Cursor Project"
date:   2025-04-29 11:51:39 -0700
categories: vscode
---

Adding recommended extensions is a great a way to setup consistent development environment for yourself or your team.

This goes very much hand-in-hand with configs stored in your project's `.vscode/settings.json` file because you may have extension specific settings, which won't work and your code editor will show warnings.

For example, I like to configure [ruff](https://shivdeepak.com/posts/python-dev-on-cursor/) for my python projects, and  [ESLint](https://notes.shiv.info/javascript/2025/04/21/typescript-cursor-linter-formatter/) for javascript projects. And, I do provide custom ruff or ESLint settings in my project's `.vscode/settings.json` [file](https://github.com/shivdeepak/mcp-sniffer/blob/main/.vscode/settings.json).

So, how to add recommended extensions list to your project? All you need to do is add `extensions.json` file along side `.vscode/settings.json` file.

Here is a sample content of `extensions.json` file I use in the [mcp-sniffer](https://github.com/shivdeepak/mcp-sniffer/blob/main/.vscode/extensions.json) project.

```json
{
    "recommendations": [
        "ms-python.python",
        "ms-python.vscode-pylance",
        "ms-python.debugpy",
        "fabiospampinato.vscode-highlight",
        "dbaeumer.vscode-eslint",
        "charliermarsh.ruff",
        "ms-azuretools.vscode-docker",
        "ms-vscode-remote.remote-containers"
    ]
}
```
