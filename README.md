# Compilation of the complete GEMOC Studio

## Introduction

The source code of the [GEMOC Studio](http://gemoc.org/studio/) is currently spread among different git repositories in different github organizations.

This project relies on git [submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to pull all the source code of the GEMOC studio, and on maven [modules](https://maven.apache.org/guides/mini/guide-multiple-modules.html) to locally build a working studio.


## Usage

First checkout this git repository with all the submodules:

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

If you prefer to use your own local maven repository (ie. in <HOME>/.m2/repository), remove the use of `-Dmaven.repo.local`, ie. use this command:

~~~
mvn package -P 'ignore_CI_repositories,!use_CI_repositories'
~~~

If you already compiled and resolved all dependencies at least once (ie. if you filled your local maven repository with everything needed for the build), add the option `-o` to perform an offline only build, which is signficantly faster since it skips checking all maven repositories online. 

In the end, the result can then be found in `gemoc_studio/releng/org.gemoc.gemoc_studio.product/target/products/`, with one studio zip per platform.

## Future work

This compiles ALL the GEMOC maven projects, even those that are not directly required to construct a studio, such as update sites and features. It would be useful to only build maven projects required to obtain an actual studio in the end.
