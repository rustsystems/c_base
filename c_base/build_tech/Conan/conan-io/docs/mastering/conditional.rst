.. _conditional_settings_options_requirements:

Conditional settings, options and requirements
==============================================

Remember, in your ``conanfile.py`` you can use the value of your options to:

* Add requirements dynamically
* Change values of other options
* Assign values to options of your requirements

The ``configure()`` method might be used to hardcoded values for options of the requirements.
It is strongly discouraged to use it to change the settings values. Please remember that ``settings``
are a configuration *input*, so it doesn't make sense to modify it in the recipes.

Also, for options, a more flexible solution is to define dependencies options values in the ``default_options``,
not in the ``configure()`` method. Setting the values in ``configure()`` won't allow to override them and it
will make really hard (even impossible) to resolve some conflicts. Use it only when it is absolutely
necessary that the package dependencies use those options.

Here is an example of what we could do in our **configure method**:

.. code-block:: python

    class Recipe(ConanFile):
      ...
      requires = "poco/1.9.4" # We will add OpenSSL dynamically "openssl/1.0.2t"
      ...

      def configure(self):
          # We can control the options of our dependencies based on current options
          self.options["openssl"].shared = self.options.shared

          # Maybe in windows we know that OpenSSL works better as shared (false)
          if self.settings.os == "Windows":
             self.options["openssl"].shared = True

             # Or adjust any other available option
             self.options["poco"].other_option = "foo"

          # We could check the presence of an option
          if "shared" in self.options:
              pass

      def requirements(self):
          # Or add a new requirement!
          if self.options.testing:
             self.requires("OpenSSL/2.1@memsharded/testing")
          else:
             self.requires("openssl/1.0.2u")

      def build(self):
          # We can check the final values of options of our requirements
          if self.options['poco'].that_option != "bar":
              raise ConanInvalidConfiguration("Who modified this option?!")


Constrain settings and options
------------------------------

Sometimes there are libraries that are not compatible with specific settings like libraries
that are not compatible with an architecture, or options that only make sense for an operating system. It can also be useful when there are
settings under development.

There are two approaches for this situation:

- **Use** ``validate()`` **to raise an error for non-supported configurations**:

  This approach is the first one evaluated when Conan loads the recipe so it is quite handy to perform checks of the input settings. It
  relies on the set of possible settings inside your *settings.yml* file, so it can be used to constrain any recipe.

  .. code-block:: python

      from conans.errors import ConanInvalidConfiguration
      ...
      def validate(self):
          if self.settings.os == "Windows":
            raise ConanInvalidConfiguration("This library is not compatible with Windows")

  .. tip::

      Use the :ref:`invalid_configuration` exception to make Conan return with a special error code. This will indicate that the
      configuration used for settings or options is not supported.

  This same method is also valid for ``options`` and ``config_options()`` method and it is commonly used to remove options for one setting:

  .. code-block:: python

      def config_options(self):
          if self.settings.os == "Windows":
              del self.options.fPIC

.. note::

    For managing invalid configurations, please check the new ``validate()`` method (:ref:`method_validate`).


- **Constrain settings inside a recipe**:

  This approach constrains the settings inside a recipe to a subset of them, and it is normally used in recipes that are never supposed to
  work out of the restricted settings.

  .. code-block:: python

      from conans import ConanFile

      class MyConan(ConanFile):
          name = "myconanlibrary"
          version = "1.0.0"
          settings = {"os": None, "build_type": None, "compiler": None, "arch": ["x86_64"]}

  The disadvantage of this is that possible settings are hardcoded in the recipe, and in case new values are used in the future, it will
  require the recipe to be modified explicitly.

  .. important::

      Note: the use of the ``None`` value in the ``os``, ``compiler`` and ``build_type`` settings described above will allow them to take the values
      from *settings.yml* file

We strongly recommend the use of the first approach whenever it is possible, and use the second one only for those cases where a stronger
constrain is needed for a particular recipe.

.. seealso::

    Check the reference section :ref:`configure(), config_options() <method_configure_config_options>` to find out more.
