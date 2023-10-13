"""Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive", _http_jar = "http_jar")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def http_archive(name, **kwargs):
    maybe(_http_archive, name = name, **kwargs)

def http_jar(name, **kwargs):
    maybe(_http_jar, name = name, **kwargs)

# WARNING: any changes in this function may be BREAKING CHANGES for users
# because we'll fetch a dependency which may be different from one that
# they were previously fetching later in their WORKSPACE setup, and now
# ours took precedence. Such breakages are challenging for users, so any
# changes in this function should be marked as BREAKING in the commit message
# and released only in semver majors.
# This is all fixed by bzlmod, so we just tolerate it for now.
def rules_format_dependencies():
    "Fetch dependencies"

    # The minimal version of bazel_skylib we require
    http_archive(
        name = "bazel_skylib",
        sha256 = "f7be3474d42aae265405a592bb7da8e171919d74c16f082a5457840f06054728",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
        ],
    )

    # TODO: after https://github.com/bazelbuild/rules_swift/issues/864 we should only fetch for host
    http_archive(
        name = "swiftformat",
        sha256 = "f62813980c2848cb1941f1456a2a06251c2e2323183623760922058b98c70745",
        url = "https://github.com/nicklockwood/SwiftFormat/releases/download/0.49.17/swiftformat_linux.zip",
        patch_cmds = ["chmod u+x swiftformat_linux"],
        build_file_content = "filegroup(name = \"swiftformat\", srcs=[\"swiftformat_linux\"], visibility=[\"//visibility:public\"])",
    )

    http_archive(
        name = "swiftformat_mac",
        sha256 = "978eaffdc3716bbc0859aecee0d83875cf3ab8d8725779448f0035309d9ad9f3",
        url = "https://github.com/nicklockwood/SwiftFormat/releases/download/0.49.17/swiftformat.zip",
        patch_cmds = [
            # On MacOS, `xattr -c` clears the "Unknown developer" warning when executing a fetched binary
            "if command -v xattr > /dev/null; then xattr -c swiftformat; fi",
            "chmod u+x swiftformat",
        ],
        build_file_content = "filegroup(name = \"swiftformat_mac\", srcs=[\"swiftformat\"], visibility=[\"//visibility:public\"])",
    )

    http_archive(
        name = "buildifier_prebuilt",
        sha256 = "72b5bb0853aac597cce6482ee6c62513318e7f2c0050bc7c319d75d03d8a3875",
        strip_prefix = "buildifier-prebuilt-6.3.3",
        urls = [
            "http://github.com/keith/buildifier-prebuilt/archive/6.3.3.tar.gz",
        ],
    )

    http_archive(
        name = "rules_nodejs",
        sha256 = "5aef09ed3279aa01d5c928e3beb248f9ad32dde6aafe6373a8c994c3ce643064",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/5.5.3/rules_nodejs-core-5.5.3.tar.gz"],
    )

    http_archive(
        name = "aspect_rules_js",
        sha256 = "25bcb082d49616ac2da538bf7bdd33a9730c8884edbec787fec83db07e4f7f16",
        strip_prefix = "rules_js-1.1.0",
        url = "https://github.com/aspect-build/rules_js/archive/refs/tags/v1.1.0.tar.gz",
    )

    http_archive(
        name = "aspect_bazel_lib",
        sha256 = "8ea64f13c6db68356355d6a97dced3d149e9cd7ba3ecb4112960586e914e466d",
        strip_prefix = "bazel-lib-1.11.1",
        url = "https://github.com/aspect-build/bazel-lib/archive/refs/tags/v1.11.1.tar.gz",
    )

    http_archive(
        name = "rules_python",
        sha256 = "9d04041ac92a0985e344235f5d946f71ac543f1b1565f2cdbc9a2aaee8adf55b",
        strip_prefix = "rules_python-0.26.0",
        url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/0.26.0.tar.gz",
    )

    http_jar(
        name = "google-java-format",
        sha256 = "33068bbbdce1099982ec1171f5e202898eb35f2919cf486141e439fc6e3a4203",
        url = "https://github.com/google/google-java-format/releases/download/v1.17.0/google-java-format-1.17.0-all-deps.jar",
    )

    http_jar(
        name = "ktfmt",
        url = "https://repo1.maven.org/maven2/com/facebook/ktfmt/0.46/ktfmt-0.46-jar-with-dependencies.jar",
    )

    # Automatically generated by running
    # python utils/jvm_dependencies.py org.scalameta:scalafmt-cli_2.13:3.7.14

    http_jar(
        name = "scalafmt_cli_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/scalafmt-cli_2.13/3.7.14/scalafmt-cli_2.13-3.7.14.jar",
        integrity = "sha1-tbY3lNIx+JYvDY8GeDgrz+TLRf0=",
    )

    http_jar(
        name = "metaconfig_core_2_13",
        url = "https://repo1.maven.org/maven2/com/geirsson/metaconfig-core_2.13/0.11.1/metaconfig-core_2.13-0.11.1.jar",
        integrity = "sha1-wo9gZZOmp/fR0+DpTNSA3bpeqJw=",
    )

    http_jar(
        name = "metaconfig_pprint_2_13",
        url = "https://repo1.maven.org/maven2/com/geirsson/metaconfig-pprint_2.13/0.11.1/metaconfig-pprint_2.13-0.11.1.jar",
        integrity = "sha1-Lu7eBd349929+uLiNocg+6/tpWM=",
    )

    http_jar(
        name = "metaconfig_typesafe_config_2_13",
        url = "https://repo1.maven.org/maven2/com/geirsson/metaconfig-typesafe-config_2.13/0.11.1/metaconfig-typesafe-config_2.13-0.11.1.jar",
        integrity = "sha1-PmKhrB+N+TdprsRYTOYjg8V6M+s=",
    )

    http_jar(
        name = "scopt_2_13",
        url = "https://repo1.maven.org/maven2/com/github/scopt/scopt_2.13/4.1.0/scopt_2.13-4.1.0.jar",
        integrity = "sha1-22cIJsNEtchhYgsOMp2G0vmGgoU=",
    )

    http_jar(
        name = "diffutils",
        url = "https://repo1.maven.org/maven2/com/googlecode/java-diff-utils/diffutils/1.3.0/diffutils-1.3.0.jar",
        integrity = "sha1-fgYN1bGUMebRmOkf9nBkQ3L2D70=",
    )

    http_jar(
        name = "fansi_2_13",
        url = "https://repo1.maven.org/maven2/com/lihaoyi/fansi_2.13/0.3.0/fansi_2.13-0.3.0.jar",
        integrity = "sha1-Qc/9gdauKoyufwstOYpbUIoBGec=",
    )

    http_jar(
        name = "sourcecode_2_13",
        url = "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.3.0/sourcecode_2.13-0.3.0.jar",
        integrity = "sha1-lXTaDOmTYHsHH2gq+V9lNeviofE=",
    )

    http_jar(
        name = "nailgun_server",
        url = "https://repo1.maven.org/maven2/com/martiansoftware/nailgun-server/0.9.1/nailgun-server-0.9.1.jar",
        integrity = "sha1-1X6gpvbBuxthbFs7MRs3Jsb/Na0=",
    )

    http_jar(
        name = "config",
        url = "https://repo1.maven.org/maven2/com/typesafe/config/1.4.2/config-1.4.2.jar",
        integrity = "sha1-TECmM+eZTPsDVCRO+20D/LEcPs8=",
    )

    http_jar(
        name = "interface",
        url = "https://repo1.maven.org/maven2/io/get-coursier/interface/0.0.17/interface-0.0.17.jar",
        integrity = "sha1-iMGIQ7lmc2Th+RloKD8vNIwbINk=",
    )

    http_jar(
        name = "java_diff_utils",
        url = "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.12/java-diff-utils-4.12.jar",
        integrity = "sha1-GnEqkTJNVm7vOYF/xcmYDrEMIds=",
    )

    http_jar(
        name = "jna",
        url = "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.13.0/jna-5.13.0.jar",
        integrity = "sha1-EgDn6+7b4NEAYgk/MpJakSAg50c=",
    )

    http_jar(
        name = "jline",
        url = "https://repo1.maven.org/maven2/org/jline/jline/3.22.0/jline-3.22.0.jar",
        integrity = "sha1-US3ecfG6nLh/MY5OHjrMd9xnpxI=",
    )

    http_jar(
        name = "scala_compiler",
        url = "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.11/scala-compiler-2.13.11.jar",
        integrity = "sha1-MOU8aTaEP29HBhe2JWODFxBI794=",
    )

    http_jar(
        name = "scala_library",
        url = "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.11/scala-library-2.13.11.jar",
        integrity = "sha1-T82C4c5C17FXkUuGhk57NZHh4NI=",
    )

    http_jar(
        name = "scala_reflect",
        url = "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.11/scala-reflect-2.13.11.jar",
        integrity = "sha1-lls4LzLZFHFrDGqNBZVqNgCns1o=",
    )

    http_jar(
        name = "scalap",
        url = "https://repo1.maven.org/maven2/org/scala-lang/scalap/2.13.11/scalap-2.13.11.jar",
        integrity = "sha1-5AM/NkkbNxTAKOjK2i2F/Eq8k+U=",
    )

    http_jar(
        name = "scala_collection_compat_2_13",
        url = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.5.0/scala-collection-compat_2.13-2.5.0.jar",
        integrity = "sha1-J0UeqJfkHHSYha0gX3uD+nuqfMc=",
    )

    http_jar(
        name = "scala_parallel_collections_2_13",
        url = "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/1.0.4/scala-parallel-collections_2.13-1.0.4.jar",
        integrity = "sha1-mEbR7QHyTpDX+UlZhwM7gnSDVDE=",
    )

    http_jar(
        name = "common_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/common_2.13/4.8.10/common_2.13-4.8.10.jar",
        integrity = "sha1-WE49RsSCajNcByq9WVFqPyjI0Mk=",
    )

    http_jar(
        name = "parsers_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/parsers_2.13/4.8.10/parsers_2.13-4.8.10.jar",
        integrity = "sha1-unzBbLswW3tx1Bo01eDfudx3IKk=",
    )

    http_jar(
        name = "scalafmt_cli_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/scalafmt-cli_2.13/3.7.14/scalafmt-cli_2.13-3.7.14.jar",
        integrity = "sha1-tbY3lNIx+JYvDY8GeDgrz+TLRf0=",
    )

    http_jar(
        name = "scalafmt_config_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/scalafmt-config_2.13/3.7.14/scalafmt-config_2.13-3.7.14.jar",
        integrity = "sha1-MbQXYLTpFLvbsxpH3Hu95FcIh+8=",
    )

    http_jar(
        name = "scalafmt_core_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/scalafmt-core_2.13/3.7.14/scalafmt-core_2.13-3.7.14.jar",
        integrity = "sha1-6YpWD6MOj2V8J626FXmdjJElLaY=",
    )

    http_jar(
        name = "scalafmt_dynamic_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/scalafmt-dynamic_2.13/3.7.14/scalafmt-dynamic_2.13-3.7.14.jar",
        integrity = "sha1-d4+y4XLEnOn0HEgzYgqFhnoRRCk=",
    )

    http_jar(
        name = "scalafmt_interfaces",
        url = "https://repo1.maven.org/maven2/org/scalameta/scalafmt-interfaces/3.7.14/scalafmt-interfaces-3.7.14.jar",
        integrity = "sha1-xA3OqfHmMK99tINLmf1c+3gsxDs=",
    )

    http_jar(
        name = "scalafmt_sysops_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/scalafmt-sysops_2.13/3.7.14/scalafmt-sysops_2.13-3.7.14.jar",
        integrity = "sha1-Zftlr+872dLsHY4FBjwwFQY4Qdk=",
    )

    http_jar(
        name = "scalameta_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/scalameta_2.13/4.8.10/scalameta_2.13-4.8.10.jar",
        integrity = "sha1-rM7jsUs8rMEjDaripd/hrfBxvOA=",
    )

    http_jar(
        name = "svm_subs",
        url = "https://repo1.maven.org/maven2/org/scalameta/svm-subs/101.0.0/svm-subs-101.0.0.jar",
        integrity = "sha1-amP3YfwPkgN6A0+T4dUDNQNpR1s=",
    )

    http_jar(
        name = "trees_2_13",
        url = "https://repo1.maven.org/maven2/org/scalameta/trees_2.13/4.8.10/trees_2.13-4.8.10.jar",
        integrity = "sha1-oNzodQ66vRX822yUod+dxMwgh4U=",
    )

    http_jar(
        name = "paiges_core_2_13",
        url = "https://repo1.maven.org/maven2/org/typelevel/paiges-core_2.13/0.4.2/paiges-core_2.13-0.4.2.jar",
        integrity = "sha1-/eB2O8GQfz2+H5BZZGluCTArxkM=",
    )

    # end generated deps for org.scalameta:scalafmt-cli_2.13:3.7.14

    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "099a9fb96a376ccbbb7d291ed4ecbdfd42f6bc822ab77ae6f1b5cb9e914e94fa",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.35.0/rules_go-v0.35.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.35.0/rules_go-v0.35.0.zip",
        ],
    )

    http_archive(
        name = "buf",
        sha256 = "6c1e7258b79273c60085df8825a52a5ee306530e7327942c91ec84545cd2d40a",
        url = "https://github.com/bufbuild/buf/releases/download/v1.9.0/buf-Linux-x86_64.tar.gz",
        strip_prefix = "buf",
        build_file_content = """exports_files(["bin/buf"], visibility = ["//visibility:public"])""",
    )

    http_archive(
        name = "buf_mac",
        sha256 = "27ea882bdaf5a4e46410fb3f5ef3507f6ce65cc8e6f4c943c37e89683b2866fb",
        url = "https://github.com/bufbuild/buf/releases/download/v1.9.0/buf-Darwin-x86_64.tar.gz",
        strip_prefix = "buf",
        build_file_content = """exports_files(["bin/buf"], visibility = ["//visibility:public"])""",
    )

    tf_version = "1.4.0"
    http_archive(
        name = "terraform_macos_aarch64",
        build_file_content = "exports_files([\"terraform\"])",
        sha256 = "d4a1e564714c6acf848e86dc020ff182477b49f932e3f550a5d9c8f5da7636fb",
        urls = ["https://releases.hashicorp.com/terraform/{0}/terraform_{0}_darwin_arm64.zip".format(tf_version)],
    )
    http_archive(
        name = "terraform_macos_x86_64",
        build_file_content = "exports_files([\"terraform\"])",
        sha256 = "e897a4217f1c3bfe37c694570dcc6371336fbda698790bb6b0547ec8daf1ffb3",
        urls = ["https://releases.hashicorp.com/terraform/{0}/terraform_{0}_darwin_amd64.zip".format(tf_version)],
    )
    http_archive(
        name = "terraform_linux_x86_64",
        build_file_content = "exports_files([\"terraform\"])",
        sha256 = "5da60da508d6d1941ffa8b9216147456a16bbff6db7622ae9ad01d314cbdd188",
        urls = ["https://releases.hashicorp.com/terraform/{0}/terraform_{0}_linux_amd64.zip".format(tf_version)],
    )
    jsonnet_version = "0.20.0"
    http_archive(
        name = "jsonnet_macos_aarch64",
        build_file_content = "exports_files([\"jsonnetfmt\"])",
        sha256 = "a15a699a58eb172c6d91f4cbddf3681095a649008628e0cfd84f564db4244ee3",
        urls = ["https://github.com/google/go-jsonnet/releases/download/v{0}/go-jsonnet_{0}_Darwin_arm64.tar.gz".format(jsonnet_version)],
    )
    http_archive(
        name = "jsonnet_macos_x86_64",
        build_file_content = "exports_files([\"jsonnetfmt\"])",
        sha256 = "76901637f60589bb9bf91b3481d4aecbc31efcd35ca99ae72bcb510b00270ad9",
        urls = ["https://github.com/google/go-jsonnet/releases/download/v{0}/go-jsonnet_{0}_Darwin_x86_64.tar.gz".format(jsonnet_version)],
    )
    http_archive(
        name = "jsonnet_linux_x86_64",
        build_file_content = "exports_files([\"jsonnetfmt\"])",
        sha256 = "a137c5e969609c3995c4d05817a247cfef8a92760c5306c3ad7df0355dd62970",
        urls = ["https://github.com/google/go-jsonnet/releases/download/v{0}/go-jsonnet_{0}_Linux_x86_64.tar.gz".format(jsonnet_version)],
    )
    http_archive(
        name = "jsonnet_linux_aarch64",
        build_file_content = "exports_files([\"jsonnetfmt\"])",
        sha256 = "49fbc99c91dcd2be53fa856307de3b8708c91dc5c74740714fdf9317957322e0",
        urls = ["https://github.com/google/go-jsonnet/releases/download/v{0}/go-jsonnet_{0}_Linux_arm64.tar.gz".format(jsonnet_version)],
    )
