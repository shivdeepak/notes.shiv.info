---
layout: post
title:  "Better Defaults iTerm 2"
date:   2024-08-09 21:45:39 -0700
categories: iterm2 macos cli
---
[iTerm2](https://iterm2.com/) is a near perfect [Terminal.app](https://en.wikipedia.org/wiki/Terminal_(macOS)) replacement for MacOS.

There are two key configurations I make on a new iTerm2 installation.

## Change Option Key (⌥) Mapping from Meta to +Esc

Why? The default behaviour of Option (⌥) key allows you to input diacritics and other special characters.

But I never need that. However, when it's mapped to +Esc, it enables a very powerful feature.

With +Esc mapping, your Option (⌥) key becomes a powerful modifier key that lets you navigate through commonds, code, and text very quickly.

Eg:

1. `⌥ + f` and `⌥ + b` let you jump one word at a time, instead of one character with `←` and `→`.
2. `⌥ + delete` let you delete one word at a time, instead of one character with `delete`.

This is super powerful if you use command line a lot.

This setting can be found at: `Settings > Profiles > Keys > General`

## Increase Font Size

iTerm2's default font size is 12, which is super tiny for a retina display. I like it when it's 36, but it may be too large for your taste.

This setting can be found at: `Settings > Profiles > Text > Font`
