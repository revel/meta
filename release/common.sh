#!/bin/bash

function update_version() {
    package=$1
    file=$2
    ver=$3
    date=$4
    min=$5
    cat <<EOF > $file
// Copyright (c) 2012-2018 The Revel Framework Authors, All rights reserved.
// Revel Framework source code and usage is governed by a MIT style
// license that can be found in the LICENSE file.

package ${package}

const (
	// Version current Revel version
	Version = "${ver}"

	// BuildDate latest commit/release date
	BuildDate = "${date}"

	// MinimumGoVersion minimum required Go version for Revel
	MinimumGoVersion = ">= go${min}"
)
EOF
}

function update_web() {
    file=$1
    ver=$2
    date=$3
    min=$4
    sed -i".old" -e "s/revel:.*/revel: ${ver}/" ${file} && \
        sed -i".old" -e "s/golang:.*/golang: ${min}+/" ${file} && \
        sed -i".old" -e "s/date:.*/date: ${date}/" ${file} && \
        rm ${file}.old
}

function update_readme() {
    file=$1
    ver=$2
    date=$3
    sed -i".old" -e "s/Current\ Version.*/Current\ Version: ${ver} \(${date}\)/" ${file} && rm ${file}.old
}

function update_changelog() {
    file=$1
    cd ${work}
    ${work}/changelog.sh > ${file}.new
    if [ -e "${file}" ]; then
        cat ${file} | grep -v ^"# CHANGELOG" >> ${file}.new
    fi
    mv ${file}.new ${file}
}
