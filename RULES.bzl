def _repo_paths_impl(ctx):
    items = {}
    for item in ctx.attr.repos:
        print("ITEM: %s" % item)

        wsname = item.label.workspace_name
        tildes = wsname.count("~")

        ## https://bazel.build/external/extension#repository_names_and_visibility
        # print("splitting %s" % wsname)

        segs = wsname.split("~")
        root_repo = segs[0]
        version   = segs[1]
        if tildes > 1:
            # 2nd seg is repo version (or "override")
            # 3rd is extension name
            # 4th is extension repo
            extension = segs[2]
            ext_repo  = segs[3]
        else:
            extension = None
            ext_repo  = None

        # print("REPO %s" % root_repo)
        # print("VERSION %s" % version)
        # print("EXTENSION %s" % extension)
        # print("EXT REPO %s" % ext_repo)

        if ext_repo:
            items["@" + ext_repo] = item.label.workspace_root
        else:
            items["@" + root_repo] = item.label.workspace_root

    items["@"] = ctx.attr.this

    # print("MAKE VARS: %s" % items)

    return [platform_common.TemplateVariableInfo(items)]

################
repo_paths_rule = rule(
    implementation = _repo_paths_impl,
    attrs = {"repos": attr.label_list(),
             "this": attr.string()}
)
