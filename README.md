# Compilation of the complete GEMOC Studio

## Introduction

The source code of the [GEMOC Studio](http://gemoc.org/studio/) is currently spread among different git repositories in different github organizations.

This project provides a script to pull all the source code of the GEMOC studio, and use maven [modules](https://maven.apache.org/guides/mini/guide-multiple-modules.html) to locally build a working studio using a dedicated `pom.xml`.


## Usage

The script `compile-all.sh` can be called using `bash` to clone each required git repository, and to start the maven compilation. A folder `localm2` is created in the working folder to store all dependencies downloaded by maven.

~~~
./compile-all.sh
~~~

If a folder already exists (eg. if `compile-all` is called twice in the same place), the corresponding repository is not re-cloned. The option `-u` can be passed to enable an automatic `git pull` in each folder that already exists.

~~~
./compile-all.sh -u
~~~

In the end, the result can then be found in `gemoc_studio/releng/org.gemoc.gemoc_studio.product/target/products/`, with one studio zip per platform.

## Explanations and Customizing

We use two options when calling maven in the script:

- `-Dmaven.repo.local=$PWD/localm2`: use a folder called *localm2* to cache all the external dependencies of the studio, instead of using the user local maven repository. Since the GEMOC Studio has around 1GB of dependencies, this avoids using this much space in a hidden folder of the user home dir.
- `-P 'ignore_CI_repositories,!use_CI_repositories'`: enables the maven profile `ignore_CI_repositories` and disables the profile `use_CI_repositories`, to disable the use of the update sites provided by GEMOC and to make sure that only local content is used.

If you prefer to use your own local maven repository (ie. in `<HOME>/.m2/repository`), remove the use of `-Dmaven.repo.local` in the script.

If you already compiled and resolved all dependencies at least once (ie. if you filled your local maven repository with everything needed for the build), add the option `-o` to maven in the script to perform an offline only build, which is signficantly faster since it skips checking all maven repositories online. 

## Future work

This compiles ALL the GEMOC maven projects, even those that are not directly required to construct a studio, such as update sites and features. It would be useful to only build maven projects required to obtain an actual studio in the end.
