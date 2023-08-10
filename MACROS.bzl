## rule (private)
def _repo_paths_impl(ctx):
    items = {}
    for item in ctx.attr.repos:
        (repo, sep, version) = item.label.workspace_name.partition("~")
        items["@" + repo] = item.label.workspace_root
    items["@"] = ctx.attr.this
    return [platform_common.TemplateVariableInfo(items)]

################
_repo_paths_rule = rule(
    implementation = _repo_paths_impl,
    attrs = {"repos": attr.label_list(),
             "this": attr.string()}
)

################################################################
## macro (public)
def repo_paths(name, repos, visibility=None):
    if native.repository_name() == "@":
       _this = "."
    else:
        _this = "external/{}".format(
            native.repository_name()[1:])

    _repo_paths_rule(name = name, repos = repos,
                    this = _this,
                    visibility = ["//visibility:public"])
