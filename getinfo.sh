#!/bin/sh
echo cat MODULE.bazel
cat MODULE.bazel

echo "---"

echo cat .bazelrc
cat .bazelrc

echo "---"

echo cat local-score-crates/MODULE.bazel
cat local-score-crates/MODULE.bazel

echo "---"

echo bazel query @score_toolchains_rust//...
bazel query @score_toolchains_rust//...


