#!/bin/bash
DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
WORK_DIR="build/working"

rm -rf build
mkdir -p $WORK_DIR
cp $DIR/__main__.py $WORK_DIR
pip install -r $DIR/requirements.txt --target $WORK_DIR
find $WORK_DIR \( -name '*.dist-info' -o -name '__pycache__' \) -prune -exec rm -r '{}' \;
touch $WORK_DIR/azure/__init__.py

if [[ $1 != '--no-zip' ]]; then
    python3 -m zipapp --compress --output=build/db_init.pyz $WORK_DIR
fi