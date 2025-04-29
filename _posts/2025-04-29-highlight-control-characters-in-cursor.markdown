---
layout: post
title:  "How to highlight control character in Cursor"
date:   2025-04-29 12:05:39 -0700
categories: vscode
---

When debugging HTTP requests and responses, it's crucial to spot control characters like `\r\n` that separate headers and body content. Having these characters visually highlighted in your editor can save you hours of troubleshooting malformed requests or parsing issues.

So, how to do it.

I found [`Highlight (fabiospampinato.vscode-highlight)`](https://marketplace.visualstudio.com/items?itemName=fabiospampinato.vscode-highlight) extension to be the best way to do this. This extension allows you to add custom regex patterns and apply custom styles to the matched text.

So, once I installed this extension, I added the following to my `settings.json`, that started highlighting `\r` as `^M` in Cursor.

```json
{
    "highlight.regexes": {
        "(\\r)": {
            "decorations": [
                {
                    "color": "#FF0000",
                    "after": {
                        "contentText": "^M",
                        "color": "#FF0000"
                    }
                }
            ]
        }
    }
}
```

I also like to highlight if soft tabs or hard tabs are used in my code. This can be achieved by adding the following to `settings.json`.

```
{
    "editor.renderWhitespace": "all",
}
```