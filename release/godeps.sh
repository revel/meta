#!/bin/bash -ex

source CONFIG

# Run gdm in each folder (requires go get github.com/sparrc/gdm)
export GOPATH=${dir}/go
# for d in ${deps}; do
#   echo getting ${d}
#   go get  ${d}
# done
# If you want to specify the version to generate for change uncomment and 
# uncomment checkout line as well
# ver=0.18.0
rm ${dir}/*.godeps && true
for r in ${repos}; do
    echo "Preparing to look at repo ${r}"
    if [ "${r}" != "heroku-buildpack-go-revel" ] && [ "${r}" != "revel.github.io" ]; then
        cd ${src}/${r}
#        git checkout tags/v${ver}
        gdm save
        mv ${src}/${r}/Godeps ${dir}/${r}.godeps
        # Append the hash to all.godeps in case they are not referenced
        echo "github.com/revel/${r}" $(git -C ${src}/${r} rev-parse HEAD) >> ${dir}/all.godeps
    fi
done

cd ${work}
# Save deps in working parent folder (to be comitted after released)
cat ${dir}/*.godeps | sort -u > ${work}/../v${ver}.godeps
