load("@rules_python//python/pip_install:pip_repository.bzl", "whl_library")
load("@rules_python//python:repositories.bzl", "python_repository")
# -- load statements -- #

def _extension_for_rules_python_impl(ctx):
  whl_library(
    name = "aspect_rules_format_pypi_black",
    repo = "aspect_rules_format_pypi",
    requirement = "black==22.6.0     --hash=sha256:074458dc2f6e0d3dab7928d4417bb6957bb834434516f21514138437accdbe90     --hash=sha256:187d96c5e713f441a5829e77120c269b6514418f4513a390b0499b0987f2ff1c     --hash=sha256:2ea29072e954a4d55a2ff58971b83365eba5d3d357352a07a7a4df0d95f51c78     --hash=sha256:4af5bc0e1f96be5ae9bd7aaec219c901a94d6caa2484c21983d043371c733fc4     --hash=sha256:560558527e52ce8afba936fcce93a7411ab40c7d5fe8c2463e279e843c0328ee     --hash=sha256:568ac3c465b1c8b34b61cd7a4e349e93f91abf0f9371eda1cf87194663ab684e     --hash=sha256:6797f58943fceb1c461fb572edbe828d811e719c24e03375fd25170ada53825e     --hash=sha256:6c1734ab264b8f7929cef8ae5f900b85d579e6cbfde09d7387da8f04771b51c6     --hash=sha256:6c6d39e28aed379aec40da1c65434c77d75e65bb59a1e1c283de545fb4e7c6c9     --hash=sha256:7ba9be198ecca5031cd78745780d65a3f75a34b2ff9be5837045dce55db83d1c     --hash=sha256:94783f636bca89f11eb5d50437e8e17fbc6a929a628d82304c80fa9cd945f256     --hash=sha256:a218d7e5856f91d20f04e931b6f16d15356db1c846ee55f01bac297a705ca24f     --hash=sha256:a3db5b6409b96d9bd543323b23ef32a1a2b06416d525d27e0f67e74f1446c8f2     --hash=sha256:ac609cf8ef5e7115ddd07d85d988d074ed00e10fbc3445aee393e70164a2219c     --hash=sha256:b154e6bbde1e79ea3260c4b40c0b7b3109ffcdf7bc4ebf8859169a6af72cd70b     --hash=sha256:b270a168d69edb8b7ed32c193ef10fd27844e5c60852039599f9184460ce0807     --hash=sha256:b9fd45787ba8aa3f5e0a0a98920c1012c884622c6c920dbe98dbd05bc7c70fbf     --hash=sha256:c85928b9d5f83b23cee7d0efcb310172412fbf7cb9d9ce963bd67fd141781def     --hash=sha256:c9a3ac16efe9ec7d7381ddebcc022119794872abce99475345c5a61aa18c45ad     --hash=sha256:cfaf3895a9634e882bf9d2363fed5af8888802d670f58b279b0bece00e9a872d     --hash=sha256:e439798f819d49ba1c0bd9664427a05aab79bfba777a6db94fd4e56fae0cb849     --hash=sha256:f586c26118bc6e714ec58c09df0157fe2d9ee195c764f630eb0d8e7ccce72e69     --hash=sha256:f6fe02afde060bbeef044af7996f335fbe90b039ccf3f5eb8f16df8b20f77666",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "aspect_rules_format_pypi_",
    timeout = 600,
  )
  python_repository(
    name = "python3_x86_64-unknown-linux-gnu",
    patches = [  ],
    platform = "x86_64-unknown-linux-gnu",
    python_version = "3.10.12",
    release_filename = "20230726/cpython-3.10.12+20230726-x86_64-unknown-linux-gnu-install_only.tar.gz",
    sha256 = "a476dbca9184df9fc69fe6309cda5ebaf031d27ca9e529852437c94ec1bc43d3",
    strip_prefix = "python",
    urls = [
      "https://github.com/indygreg/python-build-standalone/releases/download/20230726/cpython-3.10.12+20230726-x86_64-unknown-linux-gnu-install_only.tar.gz"
    ],
  )
  whl_library(
    name = "aspect_rules_format_pypi_pathspec",
    repo = "aspect_rules_format_pypi",
    requirement = "pathspec==0.9.0     --hash=sha256:7d15c4ddb0b5c802d161efc417ec1a2558ea2653c2e8ad9c19098201dc1c993a     --hash=sha256:e564499435a2673d586f6b2130bb5b95f04a3ba06f81b8f895b651a3c76aabb1",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "aspect_rules_format_pypi_",
    timeout = 600,
  )
  whl_library(
    name = "aspect_rules_format_pypi_tomli",
    repo = "aspect_rules_format_pypi",
    requirement = "tomli==2.0.1     --hash=sha256:939de3e7a6161af0c887ef91b7d41a53e7c5a1ca976325f429cb46ea9bc30ecc     --hash=sha256:de526c12914f0c550d15924c62d72abc48d6fe7364aa87328337a31007fe8a4f",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "aspect_rules_format_pypi_",
    timeout = 600,
  )
  whl_library(
    name = "aspect_rules_format_pypi_mypy_extensions",
    repo = "aspect_rules_format_pypi",
    requirement = "mypy-extensions==0.4.3     --hash=sha256:090fedd75945a69ae91ce1303b5824f428daf5a028d2f6ab8a299250a846f15d     --hash=sha256:2d82818f5bb3e369420cb3c4060a7970edba416647068eb4c5343488a6c604a8",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "aspect_rules_format_pypi_",
    timeout = 600,
  )
  whl_library(
    name = "aspect_rules_format_pypi_click",
    repo = "aspect_rules_format_pypi",
    requirement = "click==8.1.3     --hash=sha256:7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e     --hash=sha256:bb4d8133cb15a609f44e8213d9b391b0809795062913b383c62be0ee95b1db48",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "aspect_rules_format_pypi_",
    timeout = 600,
  )
  whl_library(
    name = "aspect_rules_format_pypi_platformdirs",
    repo = "aspect_rules_format_pypi",
    requirement = "platformdirs==2.5.2     --hash=sha256:027d8e83a2d7de06bbac4e5ef7e023c02b863d7ea5d079477e722bb41ab25788     --hash=sha256:58c8abb07dcb441e6ee4b11d8df0ac856038f944ab98b7be6b27b2a3c7feef19",
    download_only = False,
    enable_implicit_namespace_pkgs = False,
    environment = {  },
    extra_pip_args = [  ],
    isolated = True,
    pip_data_exclude = [  ],
    python_interpreter = "python3",
    python_interpreter_target = "@python3_x86_64-unknown-linux-gnu//:bin/python3",
    quiet = True,
    repo_prefix = "aspect_rules_format_pypi_",
    timeout = 600,
  )
# -- repo definitions -- #

extension_for_rules_python = module_extension(implementation = _extension_for_rules_python_impl)
