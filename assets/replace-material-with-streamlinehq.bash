#!/usr/bin/env bash

set -euo pipefail

RAINTPL_GLOB_BASES="./app/Widgets"
PHP_GLOB_BASES="./app/Views"

echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:env RAINTPL_GLOB_BASES=\"${RAINTPL_GLOB_BASES}\""
echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:env PHP_GLOB_BASES=\"${PHP_GLOB_BASES}\""

declare -A streamlinehq_replace_map

IFS=','

while read -r material_id streamline_id humanized_id; do
    streamlinehq_replace_map["$material_id"]="$humanized_id"
done < "$(dirname $(realpath "$0"))/streamlinehq-replace-map.csv"

echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:initialized streamlinehq replace map"

gnugrep () { [ "$(uname)" = "Linux" ] && grep $@ || ggrep $@ ; }
gnused () { [ "$(uname)" = "Linux" ] && sed $@ || gsed $@ ; }

for rootdir in $RAINTPL_GLOB_BASES; do
    IFS=
    find "$rootdir" -name "*.tpl" -type f -print0 | while read -r -d $'\0' file; do
        (gnugrep -Po '<i class="material-symbols[^"]*">\S+?<\/i>' "$file" || true) | while read -r imatch; do
            if [[ -z $imatch ]]; then
                continue
            fi
            iicon=$(echo "$imatch" | gnugrep -Po '(?<=>)\S+?(?=<\/i>)')
            extra_classes=$(echo "$imatch" | gnugrep -Po '(?<=material-symbols)[^"]*' | gnused 's/^ *//')
            if [[ ! -v streamlinehq_replace_map["${iicon}"] ]]; then
                echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):INFO:iicon=$iicon:missing streamlinehq alternative for this icon"
                continue
            fi
            sicon="${streamlinehq_replace_map["${iicon}"]}"
            svg_args="'${sicon}'"
            class_suffix=""
            if [[ -n "$extra_classes" ]]; then
                class_suffix=" ${extra_classes}"
                for cls in $extra_classes; do
                    svg_args="${svg_args}, '${cls}'"
                done
            fi
            echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:file=$file:iicon=$iicon:extra_classes=$extra_classes:sicon=$sicon:replacing"
            gnused -i -e "\
0,\
/<i class=\"material-symbols${class_suffix}\">${iicon}<\/i>\
/s\
/<i class=\"material-symbols${class_suffix}\">${iicon}<\/i>\
/{autoescape=\"off\"}{\$c->svg(${svg_args})}{\/autoescape}\
/" "$file"
        done
        echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:file=$file:finished processing file"
    done
done

for rootdir in $PHP_GLOB_BASES; do
    IFS=
    find "$rootdir" -name "*.tpl" -type f -print0 | while read -r -d $'\0' file; do
        (gnugrep -Po '<i class="material-symbols[^"]*">\S+?<\/i>' "$file" || true) | while read -r imatch; do
            if [[ -z $imatch ]]; then
                continue
            fi
            iicon=$(echo "$imatch" | gnugrep -Po '(?<=>)\S+?(?=<\/i>)')
            extra_classes=$(echo "$imatch" | gnugrep -Po '(?<=material-symbols)[^"]*' | gnused 's/^ *//')
            if [[ ! -v streamlinehq_replace_map["${iicon}"] ]]; then
                echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):INFO:iicon=$iicon:missing streamlinehq alternative for this icon"
                continue
            fi
            sicon="${streamlinehq_replace_map["${iicon}"]}"
            svg_args="'${sicon}'"
            class_suffix=""
            if [[ -n "$extra_classes" ]]; then
                class_suffix=" ${extra_classes}"
                for cls in $extra_classes; do
                    svg_args="${svg_args}, '${cls}'"
                done
            fi
            echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:file=$file:iicon=$iicon:extra_classes=$extra_classes:sicon=$sicon:replacing"
            gnused -i -e "\
0,\
/<i class=\"material-symbols${class_suffix}\">${iicon}<\/i>\
/s\
/<i class=\"material-symbols${class_suffix}\">${iicon}<\/i>\
/<?php echo svg(${svg_args}); ?>\
/" "$file"
        done
        echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:file=$file:finished processing file"
    done
done
