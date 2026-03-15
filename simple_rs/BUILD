load("@rules_rust//rust:defs.bzl", "rust_binary", "rust_library")

rust_binary(
    name = "simple_rs",
    srcs = ["simple.rs"],
    data = [],
    features = [],
    deps = [],
)

rust_binary(
    name = "simple_clap_rs",
    srcs = ["simple_clap.rs"],
    data = [],
    features = [],
    deps = ["@score_communication_crate_index//:clap"],
    edition = "2021"
)
