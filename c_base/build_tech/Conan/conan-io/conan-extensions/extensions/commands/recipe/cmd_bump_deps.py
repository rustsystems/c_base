import ast
import functools
import json
import os
import sys
from typing import Any, Optional

from conan.api.conan_api import ConanAPI
from conan.api.output import ConanOutput
from conan.api.model import Remote
from conan.cli.command import conan_command


def output_json(results):
    print(json.dumps(results, indent=2))


@conan_command(group="Recipe", formatters={"json": output_json})
def bump_deps(conan_api: ConanAPI, parser, *args):
    """
    command bumping all dependencies of a recipe
    """
    parser.add_argument("path", help="Path to the recipe whose dependencies will be bumped", default=".")
    parser.add_argument("-r", "--remote", default=None, action="append",
                        help="Remote names. Accepts wildcards ('*' means all the remotes available)")
    parser.add_argument("-c", "--cache", action='store_true', help="Search in the local cache")
    args = parser.parse_args(*args)
    recipe_file = os.path.join(args.path, "conanfile.py")

    if not os.path.isfile(recipe_file):
        ConanOutput().error(f"Recipe file {recipe_file} not found")
        sys.exit(-1)

    with open(recipe_file) as f:
        recipe_lines = f.readlines()

    remotes: list[Optional[Remote]] = []
    if args.cache or not args.remote:
        remotes.append(None)
    if args.remote:
        remotes.extend(conan_api.remotes.list(args.remote))

    changes: list[dict[str, Any]] = []

    @functools.cache
    def latest_ref(name: str) -> Optional[str]:
        all_refs = []
        for remote in remotes:
            refs = conan_api.search.recipes(name, remote=remote)
            if refs:
                all_refs.extend(refs)
        if not all_refs:
            return None
        return str(max(all_refs))

    for node in ast.walk(ast.parse("".join(recipe_lines))):
        if isinstance(node, ast.Call):
            if isinstance(node.func, ast.Attribute):
                if node.func.attr in ["requires", "build_requires", "tool_requires"]:
                    arg = node.args[0]
                    if not isinstance(arg, ast.Constant):
                        ConanOutput().warning(f"Unable to bump non constant dependency in {recipe_file}:{arg.lineno}")
                        continue
                    oldref = arg.value
                    parts = oldref.split("/")
                    version = parts[1]
                    if version.startswith("[") or version.endswith("]"):
                        ConanOutput().info(f"Won't bump {oldref} because it uses a version range")
                        continue
                    if version == "<host_version>":
                        continue
                    name = parts[0]
                    newref = latest_ref(name)
                    if not newref:
                        ConanOutput().warning(f"Error bumping {oldref} in {recipe_file}:{arg.lineno}")
                        continue
                    if newref != oldref:
                        line = arg.lineno - 1
                        recipe_lines[line] = recipe_lines[line].replace(oldref, newref)
                        ConanOutput().info(f"updating {oldref} to {newref} in {recipe_file}:{arg.lineno}")
                        changes.append({"line": arg.lineno,
                                        "old reference": oldref,
                                        "new reference": newref})

    if changes:
        with open(recipe_file, 'w') as f:
            f.writelines(recipe_lines)
        ConanOutput().success(f"Successfully bumped the dependencies of recipe {recipe_file}")
    else:
        ConanOutput().success(f"All the dependencies of recipe {recipe_file} are already up to date")
    return changes
