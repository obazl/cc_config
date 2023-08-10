BASE_DEPS = ["@liblogc//src:logc"]

BASE_INCLUDE_PATHS = ["-I$(@liblogc)/src"]

BASE_COPTS = [
    "-x", "c",
    "-Wall",
    "-Wextra",
] + select({
    "@platforms//os:macos": [
        "-std=c11",
        "-Werror=pedantic", # not needed with -Werror?
        "-Wpedantic", # same as -pedantic, strict ISO C and ISO C++ warnings
        "-pedantic-errors",
        # "-Wno-gnu-statement-expression",
        # "-Werror=pedantic",
        # "-Wno-gnu",
        # "-Wno-format-pedantic",
    ],
    "@platforms//os:linux": [
        "-std=gnu11",
        "-fPIC",
        # GCC:
        "-Werror", # turn all warnings into errors
        "-Wfatal-errors", # stop on first error
        # "-Wl,--no-undefined",
    ],
    "//conditions:default": ["-std=c11"],
# }) + select({
#     "@platforms//cpu:arm64": [
#         # "-target", "arm64-apple-darwin22.5.0"
#     ],
#     "//conditions:default": [],
})

BASE_LINKOPTS = select({
    "@platforms//os:linux": ["-rdynamic", "-ldl"],
    "@platforms//os:macos": [],
    "//conditions:default": []
})

BASE_DEFINES = select({
    "@cc_config//profile:dev?": ["DEVBUILD"],
    "//conditions:default": []
}) + select({
    "@cc_config//trace:trace?": ["TRACING"],
    "//conditions:default": []
})
        # # "_XOPEN_SOURCE=500", # strdup
        # "_POSIX_C_SOURCE=200809L", # strdup, strndup since glibc 2.10
        # # "_DEFAULT_SOURCE"    # dirent DT_* macros

