---
layout: post
title:  "Better Defaults Terminal App"
date:   2024-10-06 21:21:39 -0700
categories: terminal macos cli
---
I have started to prefer [Terminal.app](https://en.wikipedia.org/wiki/Terminal_(macOS)) over [iTerm2](https://iterm2.com/) 
because of the latest updates of iTerm2 have increased UI clutter.

Here are the configurations I would do a new Terminal.app to make it fit into my workflow.

1. Change Default Profile

    I switched to "Pro" profile from "Basic" profile.

    To make the switch, go to `Preferences > Profiles` and select "Pro" profile, and click on `Default` in the bottom.

    Pro has a translucent background. You might want to make it opaque. `Preferences > Profiles > Text` and click on `Color & Effects` and set Opacity to 100%.

    I like the "Pro" profile because it has dark theme.


2. Use Option (⌥) as Meta Key

    Go to `Preferences > Profiles > Keyboard` and check `Use Option as Meta key` option.
 
    This lets you use Option (⌥) as a meta key which gives richer readline shortcuts which wouldn't be possible otherwise.


3. Increase Font Size and enable Antialiasing

    Go to `Preferences > Profiles > Text` and increase the font size to 18.

    Also, enable `Use antialiasing` option.

    Optionally, change the font to 'Mononoki'.

    Install 'Mononoki' with Homebrew beforehand:

    ```shell
    brew install --cask font-mononoki
    ```

4. When shell exits, exit the shell.

    Go to `Preferences > Profiles > Shell` and update `When shell exits` to `Close if shell exited cleanly`.


5. Bell

    I don't like audible bell. What is this, year 2000?

    Go to `Preferences > Profiles > Advanced`. Uncheck `Audible bell`, check `Visual bell`, and uncheck `Only when bell is muted`.


And that's it.
