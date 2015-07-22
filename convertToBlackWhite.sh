#!/bin/bash

INPUT=${1}
OUTPUT=${2}

function displayUsage {
    echo "This script takes images and converts them into non-colored images, ending up with only black-and-white versions of the input."
    echo "Usage: $0 <INPUTFILE> [OUTPUTFILE]"
    echo "If no output file is given, the output is written into a temporary folder."
    exit 0;
}

while getopts "h" optArg; do
    case "$optArg" in
        h)
            displayUsage
            ;;
    esac
done

if [ "x${INPUT}" == "x" ]; then
    echo "You need to specify a source file as input!"
    exit 1
fi

if [ "x${OUTPUT}" == "x" ]; then
    FILE_TYPE="${INPUT##*.}"
    TMP_DIR=`mktemp -d`
    touch ${TMP_DIR}/output.${FILE_TYPE}
    OUTPUT=${TMP_DIR}/output.${FILE_TYPE}
    echo "[INFO] You did not specify a destination target. Output will be written to: ${OUTPUT}"
fi
if [ "${OUTPUT}" == "*.svg" ]; then
    echo "[WARNING] Creating SVG files seems to cause problems. Writing output into raster images such as PNG or JPG is recommended!"
fi
convert ${INPUT} -colorspace Gray ${OUTPUT}
