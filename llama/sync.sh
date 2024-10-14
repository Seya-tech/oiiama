#!/bin/bash

set -e

# Run in the llama directory
cd $(dirname ${BASH_SOURCE[0]})

# Set the source directory
# TODO in the future: src_dir=$1
src_dir=../llm/llama.cpp

if [ -z "$src_dir" ]; then
  echo "Usage: $0 LLAMA_CPP_DIR"
  exit 1
fi

# Set the destination directory
dst_dir=$(pwd)

# TODO remove once we no longer use the submodule
if [ -z "${OLLAMA_SKIP_PATCHING}" ]; then
  (cd ../ && git submodule init && git submodule update --force ./llm/llama.cpp)

  # apply patches
  for patch in $dst_dir/patches/*.diff; do
    echo "Applying $patch"
    git -C $src_dir apply "$patch"
  done
else
  echo "Skipping patching"
fi

# llama.cpp
cp $src_dir/src/unicode.cpp $dst_dir/unicode.cpp
cp $src_dir/src/unicode.h $dst_dir/unicode.h
cp $src_dir/src/unicode-data.cpp $dst_dir/unicode-data.cpp
cp $src_dir/src/unicode-data.h $dst_dir/unicode-data.h
cp $src_dir/src/llama.cpp $dst_dir/llama.cpp
cp $src_dir/src/llama-impl.h $dst_dir/llama-impl.h
cp $src_dir/src/llama-vocab.cpp $dst_dir/llama-vocab.cpp
cp $src_dir/src/llama-vocab.h $dst_dir/llama-vocab.h
cp $src_dir/src/llama-grammar.cpp $dst_dir/llama-grammar.cpp
cp $src_dir/src/llama-grammar.h $dst_dir/llama-grammar.h
cp $src_dir/src/llama-sampling.cpp $dst_dir/llama-sampling.cpp
cp $src_dir/src/llama-sampling.h $dst_dir/llama-sampling.h
cp $src_dir/include/llama.h $dst_dir/llama.h
cp $src_dir/ggml/src/llamafile/sgemm.cpp $dst_dir/sgemm.cpp
cp $src_dir/ggml/src/llamafile/sgemm.h $dst_dir/sgemm.h
mkdir -p $dst_dir/llamafile
cp $src_dir/ggml/src/llamafile/sgemm.h $dst_dir/llamafile/sgemm.h

# ggml
cp $src_dir/ggml/src/ggml.c $dst_dir/ggml.c
cp $src_dir/ggml/include/ggml.h $dst_dir/ggml.h
cp $src_dir/ggml/src/ggml-quants.c $dst_dir/ggml-quants.c
cp $src_dir/ggml/src/ggml-quants.h $dst_dir/ggml-quants.h
cp $src_dir/ggml/src/ggml-metal.metal $dst_dir/ggml-metal.metal
cp $src_dir/ggml/include/ggml-metal.h $dst_dir/ggml-metal.h
cp $src_dir/ggml/src/ggml-metal.m $dst_dir/ggml-metal_darwin_arm64.m
cp $src_dir/ggml/src/ggml-impl.h $dst_dir/ggml-impl.h
cp $src_dir/ggml/include/ggml-cuda.h $dst_dir/ggml-cuda.h
cp $src_dir/ggml/src/ggml-cuda.cu $dst_dir/ggml-cuda.cu
cp $src_dir/ggml/src/ggml-common.h $dst_dir/ggml-common.h
cp $src_dir/ggml/include/ggml-backend.h $dst_dir/ggml-backend.h
cp $src_dir/ggml/src/ggml-backend.c $dst_dir/ggml-backend.c
cp $src_dir/ggml/src/ggml-backend-impl.h $dst_dir/ggml-backend-impl.h
cp $src_dir/ggml/include/ggml-alloc.h $dst_dir/ggml-alloc.h
cp $src_dir/ggml/src/ggml-alloc.c $dst_dir/ggml-alloc.c
cp $src_dir/ggml/src/ggml-aarch64.h $dst_dir/ggml-aarch64.h
cp $src_dir/ggml/src/ggml-aarch64.c $dst_dir/ggml-aarch64.c
cp $src_dir/ggml/src/ggml-cpu-impl.h $dst_dir/ggml-cpu-impl.h
cp $src_dir/ggml/include/ggml-blas.h $dst_dir/ggml-blas.h
cp $src_dir/ggml/src/ggml-blas.cpp $dst_dir/ggml-blas.cpp

# ggml-cuda
mkdir -p $dst_dir/ggml-cuda/template-instances
mkdir -p $dst_dir/ggml-cuda/vendors
cp $src_dir/ggml/src/ggml-cuda/*.cu $dst_dir/ggml-cuda/
cp $src_dir/ggml/src/ggml-cuda/*.cuh $dst_dir/ggml-cuda/
cp $src_dir/ggml/src/ggml-cuda/template-instances/*.cu $dst_dir/ggml-cuda/template-instances/
cp $src_dir/ggml/src/ggml-cuda/vendors/*.h $dst_dir/ggml-cuda/vendors/

# llava
cp $src_dir/examples/llava/clip.cpp $dst_dir/clip.cpp
cp $src_dir/examples/llava/clip.h $dst_dir/clip.h
cp $src_dir/examples/llava/llava.cpp $dst_dir/llava.cpp
cp $src_dir/examples/llava/llava.h $dst_dir/llava.h
cp $src_dir/common/log.h $dst_dir/log.h
cp $src_dir/common/log.cpp $dst_dir/log.cpp
cp $src_dir/common/stb_image.h $dst_dir/stb_image.h

# These files are mostly used by the llava code
# and shouldn't be necessary once we use clip.cpp directly
cp $src_dir/common/common.cpp $dst_dir/common.cpp
cp $src_dir/common/common.h $dst_dir/common.h
cp $src_dir/common/sampling.cpp $dst_dir/sampling.cpp
cp $src_dir/common/sampling.h $dst_dir/sampling.h
cp $src_dir/common/json.hpp $dst_dir/json.hpp
cp $src_dir/common/json-schema-to-grammar.cpp $dst_dir/json-schema-to-grammar.cpp
cp $src_dir/common/json-schema-to-grammar.h $dst_dir/json-schema-to-grammar.h
cp $src_dir/common/base64.hpp $dst_dir/base64.hpp
cat <<EOF > $dst_dir/build-info.cpp
int LLAMA_BUILD_NUMBER = 0;
char const *LLAMA_COMMIT = "$sha1";
char const *LLAMA_COMPILER = "";
char const *LLAMA_BUILD_TARGET = "";
EOF

# add licenses
sha1=$(git -C $src_dir rev-parse @)

TEMP_LICENSE=$(mktemp)
cleanup() {
    rm -f $TEMP_LICENSE
}
trap cleanup 0

cat <<EOF | sed 's/ *$//' >$TEMP_LICENSE
/**
 * llama.cpp - commit $sha1 - do not edit this file
 *
$(sed 's/^/ * /' <$src_dir/LICENSE)
 */

EOF

LICENSE_FILES=$(find $dst_dir -type f \( -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.m" -o -name "*.metal" -o -name "*.cu" -o -name "*.cuh" \))
EXCLUDED_FILES=("sgemm.cpp" "sgemm.h" "sampling_ext.cpp" "sampling_ext.h" "stb_image.h" "json.hpp" "llama_darwin.c")

for IN in $LICENSE_FILES; do
    for EXCLUDED in "${EXCLUDED_FILES[@]}"; do
        if [[ "$IN" == *"$EXCLUDED" ]]; then
            continue 2
        fi
    done
    TMP=$(mktemp)
    cat $TEMP_LICENSE $IN >$TMP
    mv $TMP $IN
done
