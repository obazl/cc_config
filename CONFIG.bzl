BASE_COPTS = [
    "-x", "c",
    "-Wall",
    "-Wextra",
    "-Werror",
    "-Wfatal-errors",
] + select({
    "@platforms//os:macos": [
        "-std=c11",
        "-Werror=pedantic",
        "-Wpedantic",
        "-pedantic-errors",
    ],
    "@platforms//os:linux": [
        "-std=gnu11",
        "-fPIC",
        # GCC:
        "-Werror",
    ],
    "//conditions:default": ["-std=c11"],
})

BASE_LINKOPTS = select({
    "@platforms//os:linux": ["-rdynamic", "-ldl"],
    "@platforms//os:macos": [],
    "//conditions:default": []
})

# BASE_DEFINES = select({
#     "@cc_config//profile:dev?": ["DEVBUILD"],
#     "//conditions:default": []
# }) + select({
#     "@cc_config//trace:trace?": ["TRACING"],
#     "//conditions:default": []
# })

