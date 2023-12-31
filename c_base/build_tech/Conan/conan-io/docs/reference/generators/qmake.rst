.. _qmake_generator:

qmake
=====

.. warning::

    This is a **deprecated** feature. Please refer to the :ref:`Migration Guidelines<conan2_migration_guide>`
    to find the feature that replaced this one.

.. container:: out_reference_box

    This is the reference page for ``qmake`` generator.
    Go to :ref:`Integrations/Qmake<qmake>` if you want to learn how to integrate your project or recipes with qmake.

Generates a file named ``conanbuildinfo.pri`` that can be used for your qmake builds.
The file contains:

- N groups of variables, one group per require, declaring the same individual values: include_paths, libs, bin dirs, libraries, defines etc.
- One group of global variables with the aggregated values for all requirements.

Package declared vars
---------------------

For each requirement ``conanbuildinfo.pri`` file declares the following variables.
``XXX`` is the name of the require in uppercase. e.k "ZLIB" for ``zlib/1.2.8@lasote/stable`` requirement:

+--------------------------------+----------------------------------------------------------------------+
| NAME                           | VALUE                                                                |
+================================+======================================================================+
| CONAN_XXX_ROOT                 | Abs path to root package folder.                                     |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_INCLUDEPATH_XXX          | Header's folders                                                     |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_LIB_DIRS_XXX             | Library folders  (default {CONAN_XXX_ROOT}/lib)                      |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_BINDIRS_XXX              | Binary folders  (default {CONAN_XXX_ROOT}/bin)                       |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_LIBS_XXX                 | Library names to link                                                |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_DEFINES_XXX              | Library defines                                                      |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_COMPILE_DEFINITIONS_XXX  | Compile definitions                                                  |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_QMAKE_CXXFLAGS_XXX       | CXX flags                                                            |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_QMAKE_LFLAGS_SHLIB_XXX   | Linker flags (shared libs)                                           |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_QMAKE_LFLAGS_APP_XXX     | Linker flags (executables)                                           |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_QMAKE_CFLAGS_XXX         | C flags                                                              |
+--------------------------------+----------------------------------------------------------------------+

Global declared vars
--------------------

Conan also declares some global variables with the aggregated values of all our requirements.
The values are ordered in the right order according to the dependency tree.

+--------------------------------+----------------------------------------------------------------------+
| NAME                           | VALUE                                                                |
+================================+======================================================================+
| CONAN_INCLUDEPATH              | Aggregated header's folders                                          |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_LIB_DIRS                 | Aggregated library folders                                           |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_BINDIRS                  | Aggregated binary folders                                            |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_LIBS                     | Aggregated library names to link                                     |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_DEFINES                  | Aggregated library defines                                           |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_COMPILE_DEFINITIONS      | Aggregated compile definitions                                       |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_QMAKE_CXXFLAGS           | Aggregated CXX flags                                                 |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_QMAKE_LFLAGS_SHLIB       | Aggregated linker flags (shared libs)                                |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_QMAKE_LFLAGS_APP         | Aggregated linker flags (executables)                                |
+--------------------------------+----------------------------------------------------------------------+
| CONAN_QMAKE_CFLAGS             | Aggregated C flags                                                   |
+--------------------------------+----------------------------------------------------------------------+

.. _conanbuildinfoqmake_methods:

Methods available in *conanbuildinfo.pri*
-----------------------------------------

+--------------------------------+-------------------------------------------------------------------------------+
| NAME                           | DESCRIPTION                                                                   |
+================================+===============================================================================+
| conan_basic_setup()            |  Setup all the qmake vars according to our settings with the global approach  |
+--------------------------------+-------------------------------------------------------------------------------+
