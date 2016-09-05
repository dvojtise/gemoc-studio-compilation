# Compilation of the complete GEMOC Studio

## Introduction

The source code of the [GEMOC Studio](http://gemoc.org/studio/) is currently spread among different git repositories in different github organizations.

This project relies on git [submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to pull all the source code of the GEMOC studio, and on maven [modules](https://maven.apache.org/guides/mini/guide-multiple-modules.html) to locally build a working studio.


## Usage

First checkout the the git repository with all the submodules:

~~~
git clone --recursive https://github.com/ebousse/gemoc-studio-compilation
~~~

Then compile using maven:

~~~
mvn package -Dmaven.repo.local=$PWD/localm2 -P 'ignore_CI_repositories,!use_CI_repositories'
~~~

We use two options:

- `-Dmaven.repo.local=$PWD/localm2`: use a folder called *localm2* to cache all the external dependencies of the studio, instead of using the user local maven repository. Since the GEMOC Studio has around 1GB of dependencies, this avoids using this much space in a hidden folder of the user home dir.
- `-P 'ignore_CI_repositories,!use_CI_repositories'`: enables the maven profile `ignore_CI_repositories` and disables the profile `use_CI_repositories`, to disable the use of the update sites provided by GEMOC and to make sure that only local content is used.

If you prefer to use your own local maven repository (ie. in <HOME>/.m2/repository), use this command:

~~~
mvn package -P 'ignore_CI_repositories,!use_CI_repositories'
~~~
