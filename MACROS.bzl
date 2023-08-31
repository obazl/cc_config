load("//:RULES.bzl", "repo_paths_rule")

################################################################
## macro (public)
def repo_paths(name, repos, visibility=None):
    if native.repository_name() == "@":
       _this = "."
    else:
        _this = "external/{}".format(
            native.repository_name()[1:])

    repo_paths_rule(name = name, repos = repos,
                    this = _this,
                    visibility = ["//visibility:public"])
