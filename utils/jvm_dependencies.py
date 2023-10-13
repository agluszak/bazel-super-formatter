import os
import sys
import tempfile
import requests
import base64
import subprocess
from dataclasses import dataclass

## How to use this script
# 1. Install coursier: https://get-coursier.io/docs/cli-installation
# 2. Run the script with the artifact you want to download as an argument
#   e.g. python utils/jvm_dependencies.py org.scalameta:scalafmt-cli_2.13:3.7.14
# 3. Copy the output into respective files
# 4. Fill in the main_class in the java_binary target

@dataclass
class Artifact:
    group: str
    name: str
    version: str
    base_url: str
    bazelized_name: str


def parse_line(line: str) -> Artifact:
    parts = line.strip().split(':')
    if len(parts) == 4:
        group, name, version, _ = parts
        group_path = group.replace('.', '/')
        base_url = f"https://repo1.maven.org/maven2/{group_path}/{name}/{version}/{name}-{version}"
        bazelized_name = name.replace('-', '_').replace('.', '_')
        return Artifact(group, name, version, base_url, bazelized_name)


def download_sha1(artifact: Artifact) -> str:
    # Download the sha1 file and read its contents
    response = requests.get(artifact.base_url + '.jar.sha1')
    response.raise_for_status()
    return response.text.strip()

def resolve_and_parse(artifact_str: str) -> list[Artifact]:
    try:
        # Run the external process using coursier resolve
        command = ["cs", "resolve", artifact_str]
        output = subprocess.check_output(command, text=True)

        # Split the output into lines and parse each line
        lines = output.strip().split('\n')
        parsed_artifacts = [parse_line(line) for line in lines if line.strip()]

        return parsed_artifacts

    except subprocess.CalledProcessError as e:
        print(f"Error running 'coursier resolve': {e}")
        return []


def to_bazel_target(artifact: Artifact) -> str:
    sha1 = download_sha1(artifact)
    base64_sha1 = base64.b64encode(bytes.fromhex(sha1)).decode('utf-8')
    sri = f"sha1-{base64_sha1}"

    return f"""
http_jar(
    name = "{artifact.bazelized_name}",
    url = "{artifact.base_url}.jar",
    integrity = "{sri}",
)
"""

def parse_requested_artifact(artifact_str: str) -> Artifact:
    artifact_str = artifact_str + ":default"
    return parse_line(artifact_str)

def requested_to_bazel_target(artifact: Artifact, deps: list[Artifact]) -> str:
    deps_to_bazel_targets = [f"{to_bazel_target(dep)}" for dep in deps]

    return f"""

# Copy this into format/BUILD.bazel

# Automatically generated by running
# python utils/jvm_dependencies.py {artifact.group}:{artifact.name}:{artifact.version}
java_binary(
    name = "{artifact.bazelized_name}",
    main_class = (FILL IN),
    runtime_deps = [{", ".join([f'"@{dep.bazelized_name}//jar"' for dep in deps])}],
)

# Copy this into format/repositories.bzl

# Automatically generated by running
# python utils/jvm_dependencies.py {artifact.group}:{artifact.name}:{artifact.version}
{to_bazel_target(artifact)}
{"".join(deps_to_bazel_targets)}

# end generated deps for {artifact.group}:{artifact.name}:{artifact.version}
"""

def run(requested_artifact_str: str):
    requested_artifact = parse_requested_artifact(requested_artifact_str)
    deps = resolve_and_parse(requested_artifact_str)
    print(requested_to_bazel_target(requested_artifact, deps))

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} <artifact>")
        sys.exit(1)

    run(sys.argv[1])
