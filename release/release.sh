#!/bin/bash -ex

next=${1#"v"}
if [ -z "${next}" ]; then
    echo "Usage: $0 <next version>"
    exit 1
fi

source CONFIG
source ${work}/common.sh

export GOPATH=${dir}/go
export PATH=$GOPATH/bin:$PATH

for r in ${repos}; do
    git -C ${src}/${r} ci -m "release v${ver}"
    git -C ${src}/${r} tag v${ver}
    git -C ${src}/${r} push origin release/v${ver}
    git -C ${src}/${r} push --tags

    git -C ${src}/${r} checkout ${master}
    git -C ${src}/${r} merge release/v${ver}
    git -C ${src}/${r} ci -m "release v${ver}"
    git -C ${src}/${r} push origin ${master}

    git -C ${src}/${r} heckout ${develop}
    git -C ${src}/${r} merge master
    git -C ${src}/${r} push origin ${develop}
done

# TODO:
# add updated changelog to release notes
# notifications

update_version ${src}/revel/version.go ${next}-dev ${date} ${min}
update_web ${src}/revel.github.io/_data/version.yaml ${next}-dev ${date} ${min}
update_readme ${src}/revel/README.md ${next}-dev ${date}

for r in "revel revel.github.io"; do
    git -C ${src}/${r} ci -m "develop v${next}-dev"
    git push origin ${develop}
done
