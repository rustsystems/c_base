import shutil
import tempfile
import textwrap
import os

import pytest

from tools import save, run


@pytest.fixture(autouse=True)
def conan_test():
    old_env = dict(os.environ)
    env_vars = {"CONAN_HOME": tempfile.mkdtemp(suffix='conans')} 
    os.environ.update(env_vars)
    current = tempfile.mkdtemp(suffix="conans")
    cwd = os.getcwd()
    os.chdir(current)
    try:
        yield
    finally:
        os.chdir(cwd)
        os.environ.clear()
        os.environ.update(old_env)

def test_deploy_licenses():
    repo = os.path.join(os.path.dirname(__file__), "..")
    run(f"conan config install {repo}")
    conanfile = textwrap.dedent("""
        from conan import ConanFile
        from conan.tools.files import save
        import os
        
        
        class Pkg(ConanFile):
            name = "hello"
            version = "0.1"

            def package(self):
                save(self, os.path.join(self.package_folder, "licenses", "hello.txt"), "example licenses")
        """)
    
    # Let's build a application to bundle
    save("conanfile.py", conanfile)
    run("conan profile detect")
    run("conan create .")

    run("conan install --requires hello/0.1 --deployer=licenses")
    shutil.unpack_archive("licenses.zip", "zip_contents")
    assert os.path.isfile(os.path.join("zip_contents", "hello", "0.1", "hello.txt"))
