---
layout: post
title:  "TypeScript Linting and Formatting in Cursor"
date:   2025-04-21 00:17:39 -0700
categories: JavaScript
---

As TypeScript projects grow in complexity, maintaining consistent code quality becomes increasingly important. In this guide, we'll set up a professional linting and formatting workflow in Cursor (or VS Code Equivalent) that will help you catch errors early and ensure your codebase remains clean and consistent.

### 1. Installing and Configuring ESLint for TypeScript

ESLint is a powerful static analysis tool that helps identify and fix problems in your JavaScript and TypeScript code. Let's get it set up:

**1.1. Install Required Packages**

First, let's install ESLint and the TypeScript-specific plugins:

```bash
# Navigate to your project folder
cd your-typescript-project

# Install ESLint
npm install --save-dev eslint
```

**1.2. Create ESLint Configuration File**

Create a ESLint config file by running:

```shell
npx eslint --init

# Select the following options:

# @eslint/create-config: v1.8.1

# ✔ What do you want to lint? · javascript, json
# ✔ How would you like to use ESLint? · problems
# ✔ What type of modules does your project use? · esm
# ✔ Which framework does your project use? · none
# ✔ Does your project use TypeScript? · no / yes
# ✔ Where does your code run? · node
# The config that you've selected requires the following dependencies:

# eslint, @eslint/js, globals, typescript-eslint, @eslint/json
# ✔ Would you like to install them now? · No / Yes
# ✔ Which package manager do you want to use? · npm
```

By going through the `eslint --init` wizard, a `eslint.config.js` file will be created with following content:

```javascript
import js from '@eslint/js';
import json from '@eslint/json';
import { defineConfig } from 'eslint/config';
import globals from 'globals';
import tseslint from 'typescript-eslint';

export default defineConfig([
  {
    files: ['src/**/*.{js,mjs,cjs,ts}'],
    plugins: { js },
    extends: ['js/recommended'],
  },
  {
    files: ['src/**/*.{js,mjs,cjs,ts}'],
    languageOptions: { globals: globals.node },
  },
  tseslint.configs.recommended,
  {
    files: ['**/*.json'],
    plugins: { json },
    language: 'json/json',
    extends: ['json/recommended'],
  },
]);
```

Note that as part of the `eslint init` wizard, we have also installed TypeScript and JSON support.

**1.3. Ignore some files and directories from ESLint**

Add the following line at the end of your `eslint.config.js`.

```json
// ...
export default defineConfig([
  // ...
  {
    ignores: ['dist/**', 'node_modules/**', 'package-lock.json'],
  },
]);
```

### 2. Installing and Configuring the ESLint VS Code Extension

Now let's set up Cursor (or VS Code Equivalent) to automatically lint your code as you work:

**2.1. Install the [ESLint Extension](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)**

1. Go to Extensions (Ctrl+Shift+X or Cmd+Shift+X on Mac)
2. Search for "ESLint"
3. Install the ESLint extension by Microsoft

**2.2. Configure VS Code Settings**

Create a `.vscode` folder in your project root if it doesn't exist already, and add a `settings.json` file:

```json
{
    "editor.formatOnSave": true,
    "[javascript]": {
        "editor.defaultFormatter": "dbaeumer.vscode-eslint"
    },
    "[typescript]": {
        "editor.defaultFormatter": "dbaeumer.vscode-eslint"
    },
    "[json]": {
        "editor.defaultFormatter": "dbaeumer.vscode-eslint"
    },
    "editor.codeActionsOnSave": {
        "source.fixAll.eslint": "always",
        "source.organizeImports": "always"
    },
    "eslint.validate": [
        "javascript",
        "typescript",
        "json"
    ]
}
```

This configuration:
- Enables automatic ESLint fixes on save
- Configures ESLint to validate JavaScript, TypeScript and JSON files
- Enables formatting on save (which we'll use with Prettier)

### 3. Integrating [Prettier](https://prettier.io/) with ESLint

Prettier is an opinionated code formatter that will ensure consistent styling across your project. Let's integrate it with ESLint:

Note that we don't install the Prettier VS Code extension. Instead we configure ESLint to use Prettier.

**3.1. Install Prettier and Related Packages**

```bash
npm install --save-dev prettier eslint-config-prettier eslint-plugin-prettier
```

These packages:
- `prettier`: The core Prettier package
- `eslint-config-prettier`: Disables ESLint rules that might conflict with Prettier
- `eslint-plugin-prettier`: Runs Prettier as an ESLint rule

**3.2. Create Prettier Configuration File**

Create a `.prettierrc` file in your project root:

```json
{
  "semi": true,
  "trailingComma": "all",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "endOfLine": 'auto'
}
```

Adjust these settings based on your preferences.

Also, create a `.prettierignore` file to exclude certain files and directories from formatting:

```
node_modules
dist
```

**3.3. Update ESLint Configuration**

Update your `.eslint.config.js` file to include Prettier:

```javascript
import eslintConfigPrettier from 'eslint-config-prettier/flat';
import eslintPluginPrettierRecommended from 'eslint-plugin-prettier/recommended';

export default defineConfig([
  // ... add the following lines at the end
  eslintConfigPrettier,
  eslintPluginPrettierRecommended,
  // ... followed by ignores
]);
```

## 4. Adding Lint and Format Scripts to `package.json`

Add these scripts to your `package.json`:

```json
{
  // ...
  "scripts": {
    // ...
    "lint": "eslint",
    "lint:fix": "eslint --fix",
  }
  // ...
}
```

This allows you to run:
- `npm run lint` to check for linting issues
- `npm run lint:fix` to automatically fix linting issues

## 6. Tips for Working with a Team

1. **Commit Configuration Files**: Ensure `.eslint.config.js`, `.prettierrc`, `.prettierignore`, and `.vscode/settings.json` are committed to your repository so all team members share the same setup.

2. **Add Pre-commit Hooks**: Consider using husky and lint-staged to prevent committing code that doesn't pass lint checks.

3. **Incorporate in CI Pipeline**: Add linting checks to your CI pipeline to catch issues that might have slipped through.

## Conclusion

You've now set up a professional TypeScript linting and formatting workflow in VS Code! This setup will help you maintain code quality and consistency across your projects, especially when working in a team.

By combining ESLint for code quality rules with Prettier for consistent formatting, you get the best of both worlds: strongly typed, error-free code that's also visually consistent and easy to read.

Happy coding!
