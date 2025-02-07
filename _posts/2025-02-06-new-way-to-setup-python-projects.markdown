---
layout: post
title:  "A new way to setup Python projects (Poetry)"
date:   2025-02-06 21:40:39 -0700
categories: python
---

I am spoiled by the amount of tooling available with Nodejs, and Ruby. Now that
I am primarily coding in Python, I am was looking for something similar, and I
came across pipx (equivalent to npx) and poetry (loosely similar to npm, or bundler).

Let's get started with pipx, and then we will cover poetry.

## pipx

It's really easy to install pipx, and it's a great way to install Python packages
that come with command line tools.

On Mac, you can install it using homebrew:

```bash
brew install pipx
```

Now that you have pipx installed, you can install any Python package, including
poetry which comes with a command line tool.

```bash
pipx install poetry
```

That's it!

## Poetry

Poetry is a tool for dependency management and packaging in Python. It allows you
to declare, manage and install dependencies of Python projects. It also manages
your virtual environment and build system. Also, using poetry is a great way to
ensure consistent project structure around different Python projects.

### Creating a new project
To create a new project, you can use the following command:

```bash
poetry new my_project
```

This will create a new project in the `my_project` directory, and create a `my_project`
directory inside it. Btw, that's the right way to structure a Python project, because
your imports will be relative to `my_project` directory in the project root, which is
also the module name.

```bash
my_project/
├── pyproject.toml
├── README.md
├── poetry.lock
├── src/
│   └── my_project/
│       └── __init__.py
└── tests/
    └── __init__.py
```

### Converting an existing project
But what if you already have a project, and you want to convert it to poetry?

You can use the following command:

```bash
poetry init
```

This will create a `pyproject.toml` file, and you can start adding dependencies.

### Adding dependencies

```bash
poetry add requests
```

Poetry updates the `pyproject.toml` file, and you can start adding dependencies, and

It will also take care of doing version locks, and creating a `poetry.lock` file that
could be checked into your repository. This will ensure that everyone in the team, and
the upper environments are using the same versions of the dependencies.

So, if you have just cloned the project, you can run:

```bash
poetry install
```

To create a virtual environment and install the dependencies.

### Running module as CLI tool

Just like how you would run any module in python using `python -m my_module`, you can
run any command in poetry using `poetry run my_command`.

```bash
poetry run python -m my_project
```

Note that if you have an executable module, it should have a `__main__.py` file in the
root of the module.

### Running tests and other commands

You can run any command in poetry using `poetry run my_command`. `poetry run` will take
care of running the command in the virtual environment.

So, if you have pytest installed, you can run your tests using:

```bash
poetry run pytest
```

You can also run other commands like `poetry run mypy` to run mypy, or `poetry run isort`
to run isort.

### Running commands in the virtual environment

You can also run commands in the virtual environment using `poetry shell`. This will
give you a shell in the virtual environment, and you can run any command in the shell.

```bash
poetry shell
```

Well, this should be enough to get you started with poetry. If you want to learn more,
simply run `poetry list` and it will list all the available commands -- and there are
quite a few to have you covered with dependency management, packaging, and more.
