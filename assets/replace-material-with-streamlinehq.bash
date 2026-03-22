#!/usr/bin/env bash

set -euo pipefail

TEMPLATE_GLOB_BASES="./app"
echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:env TEMPLATE_GLOB_BASES=\"${TEMPLATE_GLOB_BASES}\""

declare -A streamlinehq_replace_map

IFS=','

while read -r material_id streamline_id humanized_id; do
    streamlinehq_replace_map["$material_id"]="$humanized_id"
done < "$(dirname $(realpath "$0"))/streamlinehq-replace-map.csv"

echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:initialized streamlinehq replace map"

for rootdir in $TEMPLATE_GLOB_BASES; do
    IFS=
    find "$rootdir" -name "*.tpl" -type f -print0 | while read -r -d $'\0' file; do
        (ggrep -Po '(?<=<i class="material-symbols">)\S+?(?=<\/i>)' "$file" || true) | while read -r iicon; do
            if [[ -z $iicon ]]; then
                continue
            fi
            if [[ ! -v streamlinehq_replace_map["${iicon}"] ]]; then
                echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):INFO:iicon=$iicon:missing streamlinehq alternative for this icon"
                continue
            fi
            sicon="${streamlinehq_replace_map["${iicon}"]}"
            echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:file=$file:iicon=$iicon:sicon=$sicon:replacing"
            gsed -i -e "\
0,\
/<i class=\"material-symbols\">${iicon}<\/i>\
/s\
/<i class=\"material-symbols\">${iicon}<\/i>\
/{\$c->svgIcon(\"${sicon}\")}\
/" "$file"
        done
        echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:file=$file:finished processing file"
    done
done
