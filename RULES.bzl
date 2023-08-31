def _repo_paths_impl(ctx):
    items = {}
    for item in ctx.attr.repos:
        (repo, sep, version) = item.label.workspace_name.partition("~")
        items["@" + repo] = item.label.workspace_root
    items["@"] = ctx.attr.this
    return [platform_common.TemplateVariableInfo(items)]

################
repo_paths_rule = rule(
    implementation = _repo_paths_impl,
    attrs = {"repos": attr.label_list(),
             "this": attr.string()}
)

