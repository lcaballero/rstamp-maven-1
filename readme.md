[![Build Status](https://travis-ci.org/lcaballero/rstamp-maven-1.svg?branch=master)](https://travis-ci.org/) [![NPM version](https://badge.fury.io/js/rstamp-maven-1.svg)](http://badge.fury.io/js/rstamp-maven-1)

# Introduction

This `rstamp` generator creates a new Java+Maven project.  It adds some initial code and a test for that
code.  The resulting pom.xml is configured to create a fat jar.

The pom.xml file includes the libs:
1. junit v4.11
1. hamcrest v1.3
1. mockito v1.8.4
1. guava v16.0.1
1. gson v2.2.4

The structure arrived at by this generator:

```
ProjectDir
├── .git
├── .gitignore
├── license
├── pom.xml
├── readme.md
└── src
    ├── main
    │   └── java
    │       └── first
    │           └── pkg
    │               ├── App.java
    │               └── Main.java
    └── test
        └── java
            └── first
                └── pkg
                    └── AppTest.java
```


## Installation

Install [rstamp-cli][rstamp-cli].  `%> npm install rstamp-cli -g`
Install this template either globally or manually.  First the manual install:
1) clone [rstamp-maven-1][rstamp-maven-1] to a directory like `~/bin/npm/rstamp/templates/`,
```
%> mkdir -p ~/bin/npm/rstamp/templates
%> cd $_
%> git clone https://github.com/lcaballero/rstamp-maven-1
%> cd rstamp-maven-1
%> [sudo] npm link
```

At this point npm should have put a symbolic link to the package which basically would point
to `~/bin/npm/rstamp/template/rstamp-rstamp-1/` and when other tools go to either `require()`
that module or find it's home via the normal npm mechanisms it can be found.

2) The other way is just to install it globally.

```
%> npm install rstamp-maven-1 -g
```

After which the full code is installed.  This is the simplest.  The manual process is useful
when you'd like to fork the code and make a new version, like `rstamp-maven-2`.


## Usage

Once you have `rstamp-maven-1` installed you can run `rstamp-cli` and generate a new project.
This following commands might be how you'd go about that:

```
%> mkdir -p ~/Projects/Node/Playground/new-package
%> cd $_
%> rstamp -g maven-1
```

A note on `-g`.  `-g` here doesn't mean global like it does with npm, but instead means
'generate'.  That same command could have been written like so:

```
%> rstamp --generate maven-1
```


## License

See license file.

The use and distribution terms for this software are covered by the
[Eclipse Public License 1.0][EPL-1], which can be found in the file 'license' at the
root of this distribution. By using this software in any fashion, you are
agreeing to be bound by the terms of this license. You must not remove this
notice, or any other, from this software.


[EPL-1]: http://opensource.org/licenses/eclipse-1.0.txt
[rstamp-cli]: https://www.npmjs.org/package/rstamp-cli

