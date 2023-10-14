---
layout: post
comments: false
title: "Conan 1.17: The Conan user survey, lockfiles, new graph commands, package ID modes for revisions, apple-clang 11.0 support and
usability improvements"
---

Great news in this 1.17 release! The new lockfile feature has arrived together with a new ``conan graph`` commands and package ID modes for
recipe and package revisions. We are also running a user survey to gather some feedback. Let's check it out!

## The Conan User Survey

We are running a user survey to gather some feedback from the community. As you know, Conan Package Manager is fully OpenSource, we do not
capture any kind of information on your usage. This survey will help us to size our resources accordingly across different areas
(development, support, etc.), to estimate the importance of some feature requests, the impact of bugs or regressions, and to prioritize
development in general.

Please take **2 minutes** to [fill the survey](https://www.surveymonkey.com/r/ConanCommunity) and help the Conan project. The results of the
survey will be exclusively for the internal use of the JFrog-Conan team to evolve Conan to better suit your needs. Thanks!

## Freeze your dependencies with lockfiles

When a package in a dependency graph is modified and a new version or revision is created, it is sometimes desired to test if that new
version works well within a larger product or project, that is, when that package is part of a larger dependency graph.

The packages that depend on the modified one might need to be rebuilt, but if something else changed (a new version of another upstream
dependency is released), it is impossible to achieve reproducible builds.

The Conan lockfiles achieve that functionality storing the information of a dependency graph. This information includes the exact versions,
revisions, options, and configuration. As every graph in Conan is different depending on the input settings and options of each profile used,
there will be one lockfile for each configuration.

<div align="center">
    <figure>
        <img src="{{ site.url }}/assets/post_images/2019-07-15/conan-lockfiles_graph.png" width="600"/>
        <figcaption>A nondeterministic dependency graph</figcaption>
    </figure>
</div>

Lockfiles are useful to achieve deterministic builds, even if the dependency definitions in conanfile recipes are not fully deterministic,
for example when using version ranges or using package revisions.

Check the [new section about lockfiles](https://docs.conan.io/en/latest/versioning/lockfiles.html) in our documentation to learn more about
this powerful feature!

## Manage lockfiles and the update of dependencies in your graph

One of the applications of lockfiles is to be able to propagate changes in one package belonging to a dependency graph to its affected
downstream consumers. This can be achieved with the aforementioned lockfiles and the package ID revision mode (read more in the next
section).

The main point about manipulating lockfiles is to coordinate the rebuild of the affected packages building them in isolated environments,
for example, different slaves. So you get the results of an isolated package creation, and then you update the main lockfile to continue
processing the rest of the packages guaranteeing that the following compilations will use the previously built packages.

In order to achieve that, we have released the new ``conan graph`` command, that will allow you to:

- Generate lockfiles for a given graph without running a complete installation (without downloading or rebuilding): ``conan graph lock``

- Update packages that have been rebuilt in one lockfile generating a new one: ``conan graph update-lock``

- Clean the modified packages in a lockfile to perform a new operation that will mark packages as modified: ``conan graph clean-modified``

- Compute the packages that have to be rebuilt in order to achieve the result of a given lockfile: ``conan graph build-order``

Check the full reference of the commands in the [documentation](https://docs.conan.io/en/latest/reference/commands/misc/graph.html). You
will also find a full example using lockfiles here: https://github.com/conan-io/examples#lockfiles

## Package ID modes for recipe and package revisions

We have increased the possibilities of the package ID
[versioning schema](https://docs.conan.io/en/latest/creating_packages/define_abi_compatibility.html#versioning-schema) including the
``recipe_revision_mode()`` and ``package_revision_mode()``. These modes will make the package ID of a package depending on the
recipe revision (for the first mode) and on the package ID and package revision (for the latest mode) of the requirements.

```
    def package_id(self):
        # <name>/<version>@<user>/<channel>#<RREV> for all the dependencies
        self.info.requires.recipe_revision_mode()

        # <name>/<version>@<user>/<channel>#<RREV>:<package_id>#<PREV>
        # for the "mypkgdep" dependency
        self.info.requires["mypkgdep"].package_revision_mode()
```

As done with the other modes, this can be separately applied to each recipe or configured globally as the default version schema in the
Conan configuration file:

*conan.conf*
```
[general]
default_package_id_mode=package_revision_mode
```

These modes are **very important** together with the lockfiles in order to achieve a fully reproducible graph, as this mode makes sure that
the packages have been built with the exact same recipe revision and package revision in upstream dependencies. In other words, this will
achieve **exact binary addressing** (the package revision is the hash of the contents), meaning that in case an upstream binary is rebuilt,
it will induce a compulsory build of new binaries downstream.

## Apple-clang 11.0 support

Apple released in June a new beta version of XCode 11.0 and it will stay in beta during some months. However, there are some brave
developers already taking advantage of the new release, so we have included the new apple-clang 11 version in the default
[settings.yml](https://docs.conan.io/en/latest/reference/config_files/settings.yml.html) file.

Remember that the values in this file are a convention for open source packages but you can
[customize the settings](https://docs.conan.io/en/latest/extending/custom_settings.html) to fit your needs.

## Usability improvements

There has been some improvements and deprecations in favor of the new syntax:

- ``conan copy|download|upload`` commands can be used indicating a full reference instead of the ``--package`` flag (now deprecated).
  Remember that the download command can also specify the recipe and the package revision:

  ```
  $ conan download <name>/<version>@<user>/<channel>#<RREV>:<package_id>#<PREV> -r my_remote
  ```

- The *conanfile.txt* recipe format now supports indicating a specific
[recipe revision](https://docs.conan.io/en/latest/versioning/revisions.html) for requirements:

  ```
  [requires]
  MyPackage/1.2@user/channel#3453453453
  ```

- Resolution of package search to resolve version ranges has been improved as well as the result is now displayed at the end of the
  installation:

  ```
  $ conan install "boost/[>=1.68.0]@conan/stable"
  ...
  boost/[>=1.68.0]@conan/stable resolved to 'boost/1.70.0@lasote/stable' in remote 'conan-center'
  ```

- Other UX improvements like unified progress bars, deprecation warning message for ``general.no_proxy`` configuration and the profile path
  showed in warning messages.

<div align="center">
    <figure>
        <img src="{{ site.url }}/assets/post_images/2019-07-15/conan-progress_bars.gif" width="500"/>
        <figcaption>Unified progress bars for installation</figcaption>
    </figure>
</div>

-----------
<br>

Have a look at the full list of features and fixes in the [changelog](https://docs.conan.io/en/latest/changelog.html).

Report any bug or share your feedback opening a new issue in our [issue tracker](https://github.com/conan-io/conan/issues) and don't forget
to [update](https://conan.io/downloads.html). Have a good summer!
