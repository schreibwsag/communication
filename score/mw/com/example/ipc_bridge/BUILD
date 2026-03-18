# *******************************************************************************
# Copyright (c) 2025 Contributors to the Eclipse Foundation
#
# See the NOTICE file(s) distributed with this work for additional
# information regarding copyright ownership.
#
# This program and the accompanying materials are made available under the
# terms of the Apache License Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0
#
# SPDX-License-Identifier: Apache-2.0
# *******************************************************************************

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
load("@rules_rust//rust:defs.bzl", "rust_binary", "rust_library", "rust_static_library")
load("@score_baselibs//score/language/safecpp:toolchain_features.bzl", "COMPILER_WARNING_FEATURES")

cc_binary(
    name = "ipc_bridge_cpp",
    srcs = [
        "assert_handler.cpp",
        "assert_handler.h",
        "main.cpp",
    ],
    data = ["etc/mw_com_config.json"],
    features = COMPILER_WARNING_FEATURES,
    deps = [
        ":sample_sender_receiver",
        "//score/mw/com",
        "@boost.program_options",
        "@score_baselibs//score/language/futurecpp",
        "@score_logging//score/mw/log",
    ],
)

cc_library(
    name = "sample_sender_receiver",
    srcs = [
        "sample_sender_receiver.cpp",
    ],
    hdrs = [
        "sample_sender_receiver.h",
    ],
    features = COMPILER_WARNING_FEATURES,
    deps = [
        ":datatype",
        "//score/mw/com",
        "@score_logging//score/mw/log",
    ],
)

cc_library(
    name = "datatype",
    srcs = [
        "datatype.cpp",
    ],
    hdrs = [
        "datatype.h",
    ],
    features = COMPILER_WARNING_FEATURES,
    deps = [
        "//score/mw/com",
        "@score_baselibs//score/language/futurecpp",
    ],
)

rust_library(
    name = "ipc_bridge_gen_rs",
    srcs = ["ipc_bridge_gen.rs"],
    visibility = [
        "//score/mw/com:__subpackages__",
    ],
    deps = [
        ":ipc_bridge_gen_cpp",
        "//score/mw/com/impl/rust:mw_com",
        "@score_communication_crate_index//:libc",
    ],
    edition = "2021",
)

# build static library instaed of binary. The entry function of this
# library will be called by main() of a CPP wrapper ipc_bridge_rs_wrapper.cc
rust_static_library(
    name = "ipc_bridge_rs_as_lib",
    srcs = ["ipc_bridge.rs"],
    data = ["etc/mw_com_config.json"],
    deps = [
        ":ipc_bridge_gen_rs",
        "//score/mw/com/impl/rust:mw_com",
        "@score_communication_crate_index//:clap",
        "@score_communication_crate_index//:futures",
    ],
    edition = "2021",
)

# Dummy library which forces linking of the correct CPP standard libraries
cc_library(
    name = "force_cpp_runtime",
)

# CPP wrapper binaries with dependencies to all needed CPP libraries.
# Ugly. Apperently the dependencies coming from ipc_bridge_rs_as_lib
# are list and need to be added manually !!!
cc_binary(
    name = "ipc_bridge_rs",
    srcs = ["ipc_bridge_rs_wrapper.cc"],
    deps = [
        ":ipc_bridge_rs_as_lib",
        # Required C++ libs used by the Rust code!
        ":ipc_bridge_gen_cpp",
        ":sample_sender_receiver",
        ":datatype",
        # This is a MUST — provides SharedMemory, Runtime, TypedMemory, etc.
        "//score/mw/com",
        # Provides CreateRecorderFactory()
        "@score_logging//score/mw/log",
        "//score/mw/com/impl/rust:bridge_macros",
        # forced CPP runtime
        ":force_cpp_runtime",
    ],
    data = ["etc/mw_com_config.json"],
)

cc_library(
    name = "ipc_bridge_gen_cpp",
    srcs = ["ipc_bridge_gen.cpp"],
    features = COMPILER_WARNING_FEATURES,
    implementation_deps = [
        ":datatype",
        "//score/mw/com/impl/rust:bridge_macros",
    ],
)

exports_files([
    "etc/mw_com_config.json",
])
