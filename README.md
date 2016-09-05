# Compilation of the complete GEMOC Studio

## Introduction

The source code of the (GEMOC Studio)[http://gemoc.org/studio/] is currently spread among different git repositories in different github organizations.

This project relies on git (submodules)[https://git-scm.com/book/en/v2/Git-Tools-Submodules] to pull all the source code of the GEMOC studio, and to locally build a working studio using a script.

## How it works

- Using git submodules, all the source code from other git repositories is retrieved
- Then, we compile each project in the correct order, each time creating a new update site
- Finally, we assemble a complete studio when compiling the last project

## Usage

First checkout the the git repository with all the submodules:

~~~
git clone --recursive https://github.com/ebousse/gemoc-studio-compilation
~~~

TODO
