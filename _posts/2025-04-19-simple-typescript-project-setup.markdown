---
layout: post
title:  "Simple TypeScript Node.js project setup"
date:   2025-04-19 19:14:39 -0700
categories: JavaScript
---

### Introduction

If you want to build a simple javascript package. You can run `npm init` and it will get you started.

If you want to build a minimal web app with a frontend, you can use [vite](https://vite.dev/) by running `npm create vite@latest <project-name>`.

In this post, I am going to cover how to build a simple TypeScript Node.js project scaffold. This is quite useful if you want to create a pure TypeScript project without any boilerplate.


### Initialize a Node.js Project

We will call our project `hello_world`.

```shell
# Create Project Directory
mkdir hello_world
cd hello_world

# Initialize Node.js
npm init -y
```

### Setup TypeScript

```shell
# install typescript, and node type definitions as dev dependency
npm install --save-dev typescript @types/node

# initialize tsconfig.json
npx tsc --init
```

Make sure the following config params in `tsconfig.json` are updated. This will ensure that your project is setup for Modern Node.js.

```json
{
  // ...
  "target": "ESNext", /* Set the JavaScript language version for emitted JavaScript and include compatible library declarations. */
  "module": "NodeNext", /* Specify what module code is generated. */
  "moduleResolution": "NodeNext", /* Specify how TypeScript looks up a file from a given module specifier. */
  "rootDir": "./src", /* Specify the root folder within your source files. */
  "outDir": "./dist", /* Specify an output folder for all emitted files. */
  // ...
}
```

Note that the values for `target`, `module`, and `moduleResolution` dictate the compatibility of generated JavaScript code in various runtimes, including compatibility to run in legacy projects. This is a complex topic, and it's better to keep things simple for what
we are trying to achieve here.

### Configure entrypoint

```shell
mkdir src
touch src/index.ts

# you can add your TypeScript code to index.ts
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
