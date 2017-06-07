#!/bin/bash -ex

source CONFIG

mkdir -p ${dir}/go/{bin,pkg,src}
mkdir -p ${src}

echo "pwd ${dir}"
${work}/prepare-1-clone.sh
${work}/prepare-2-merge.sh
${work}/prepare-3-branch.sh
${work}/prepare-4-version.sh


echo "# code is in: ${src}"
