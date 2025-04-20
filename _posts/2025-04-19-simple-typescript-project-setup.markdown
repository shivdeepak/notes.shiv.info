---
layout: post
title:  "Simple Typescript Project Setup"
date:   2025-04-19 19:14:39 -0700
categories: typescript
---

### Introduction

If you want to build a simple javascript package. You can run `npm init` and it will get you started.

If you want to build a minimal web app with a frontend, you can use [vite](https://vite.dev/) by running `npm create vite@latest <project-name>`.

In this post, I am going to cover how to build a simple typescript project scaffold. This is quite useful if you want to create a pure typescript project without any boilerplate.


### Initialize a Node.js Project

We will call our project `hello_world`.

```shell
# Create Project Directory
mkdir hello_world
cd hello_world

# Initialize Node.js
npm init -y
```

### Setup Typescript

```shell
# install typescript as dev dependency
npm install --save-dev typescript

# initialize tsconfig.json
npx tsc --init
```

Make sure `outDir` config param in `tsconfig.json` is set to `dist`.

This will make sure compiled javascript files are created in `dist` directory, seperate from `src` directory.

```json
{
  // ...
  "outDir": "dist",
  // ...
}
```

### Configure entrypoint

```shell
mkdir src
touch src/index.ts

# you can add your typescript code to index.ts
# Maybe put `console.log("Hello World");` to get started.

```

### Update `package.json`

Now, update the following settings in `package.json`:

```json
{
  // ...
  "main": "dist/index.js",
  "type": "module",
  "scripts": {
    "build": "tsc",
    "start": "node dist/index.js",
    "dev": "tsc --watch"
  },
  // ...
}
```

Now, you are all set. You can use the following commands:

```shell
# Compile the code
npm run build

# Run the code
npm run start

# Watch and rebuild on file changes
npm run dev
```

### Setup git

```shell
# Initialize an empty repo
git init

# Ignore node packages and dist directory
echo "node_modules" >> .gitignore
echo "dist" >> .gitignore

# Add files
git add .

# Commit
git commit -m 'Initial Commit'
```
