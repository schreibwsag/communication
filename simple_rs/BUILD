load("@rules_rust//rust:defs.bzl", "rust_binary", "rust_library", "rust_static_library")
load("@rules_cc//cc:defs.bzl", "cc_library", "cc_binary")

rust_binary(
    name = "simple_rs",
    srcs = ["simple.rs"],
    data = [],
    features = [],
    deps = [],
    edition = "2021",
)

rust_binary(
    name = "simple_clap_rs",
    srcs = ["simple_clap.rs"],
    data = [],
    features = [],
    deps = ["@score_communication_crate_index//:clap"],
    edition = "2021",
)

# Build static Rust library instead of Rust binary
rust_static_library(
    name = "print_datetime_rs_lib",
    srcs = ["print_datetime.rs"],
    edition = "2021",
)

# Create empty CPP library which forces linking the correct C++ libraries 
cc_library(
    name = "force_cpp_runtime",
)

# CPP wrapper calling the entry function of the Rust binary
cc_binary(
    name = "print_datetime",
    srcs = ["print_datetime_wrapper.cc"],
    deps = [
        ":print_datetime_rs_lib",    # Rust staticlib, exposes CcInfo
        ":force_cpp_runtime",        # ensures g++ is used and libstdc++ is linked
    ],
)
