#!/usr/bin/env bash

# set -euo pipefail

if [ -z "${STREAMLINEHQ_API_KEY:-}" ]; then
    echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):ERROR:env STREAMLINEHQ_API_KEY is unset"
    exit 1
fi

STREAMLINEHQ_CACHE_DIR="${CACHE_PATH:-/usr/local/share/movim/cache}/streamlinehq"
echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:env STREAMLINEHQ_CACHE_DIR=\"${STREAMLINEHQ_CACHE_DIR}\""

mkdir -p "$STREAMLINEHQ_CACHE_DIR"

IFS=','

while read -r material_id streamline_id humanized_id; do
    output_file="$STREAMLINEHQ_CACHE_DIR/$humanized_id.svg"
    if [ -f "$output_file" ]; then
        echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):INFO:material_id=$material_id:streamline_id=$streamline_id:humanized_id=$humanized_id:output_file=$output_file:\
skipped because file already exists"
        continue
    fi
    echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):DEBUG:material_id=$material_id:streamline_id=$streamline_id:humanized_id=$humanized_id:\
processing"

    http_code=$(curl -sS -o /tmp/streamline_svg_download \
        -w "%{http_code}" \
        -H "Accept: image/svg+xml" \
        -H "x-api-key: $STREAMLINEHQ_API_KEY" \
        "https://public-api.streamlinehq.com/v1/icons/ico_${streamline_id}/download/svg?colors=%23010101,%23FEFEFE&responsive=true")

    if [ "$http_code" != "200" ]; then
        echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):ERROR:material_id=$material_id:streamline_id=$streamline_id:humanized_id=$humanized_id:http_code=$http_code:\
failed to download from streamlinehq: '$(cat /tmp/streamline_svg_download | tr '\n' '\\n' | tr '\r' '')'"
        exit 1
    fi

    svg_humanized_id=`grep -Po -m 1 '(?<=id=")\S+?(?=")' /tmp/streamline_svg_download`
    if [[ "$svg_humanized_id" != "$humanized_id" ]]; then
        echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):WARN:material_id=$material_id:streamline_id=$streamline_id:humanized_id=$humanized_id:svg_humanized_id=$svg_humanized_id:\
humanized id set in svg and in csv are different"
    fi

    sed \
        -e 's/viewBox="0 0 24 24"/viewBox="-6 -6 36 36"/g' \
        -e 's/#010101/currentColor/g' \
        -e 's/#FEFEFE/var(--movim-accent)/g' \
        /tmp/streamline_svg_download > "$output_file"

    echo "$(date +'%Y-%m-%dT%H:%M:%S%z'):INFO:material_id=$material_id:streamline_id=$streamline_id:humanized_id=$humanized_id:\
saved icon"

done < "$(dirname $(realpath "$0"))/streamlinehq-replace-map.csv"

rm -f /tmp/streamline_svg_download
