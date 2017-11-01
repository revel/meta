#!/bin/bash -ex

next=${1#"v"}
if [ -z "${next}" ]; then
    echo "Usage: $0 <next version>"
    exit 1
fi

echo "export next=${next}" >> CONFIG

source CONFIG

cd ${dir}
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=$GOPATH/bin:$PATH

for r in ${repos}; do
    git -C ${src}/${r} checkout ${release}
    git -C ${src}/${r} add .
    git -C ${src}/${r} commit -m "release v${ver}" || true # could be empty
    git -C ${src}/${r} tag v${ver} || true

    git -C ${src}/${r} checkout ${master}
    git -C ${src}/${r} merge release/v${ver}

#     if [ "${r}" != "revel.github.io" ]; then
        # website doesn't use develop branch
        git -C ${src}/${r} checkout ${develop}
        git -C ${src}/${r} merge ${master}
#     fi
done

# TODO:
# add updated changelog to release notes
# notifications

update_version ${src}/revel/version.go ${next}-dev ${date} ${min}
update_web ${src}/revel.github.io/_data/version.yaml ${next}-dev ${date} ${min}
update_readme ${src}/revel/README.md ${next}-dev ${date}

for r in ${repos}; do
#     if [ "${r}" != "revel.github.io" ]; then
        # website doesn't use develop branch
        git -C ${src}/${r} add .
        git -C ${src}/${r} commit -m "develop v${next}-dev" || true # could be empty
#     fi
done

echo "# code successfully updated"
