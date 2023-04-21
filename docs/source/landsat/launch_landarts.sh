#!/bin/bash

module load pybox

echo "LANDARTs starts ..."

/export/apps/os154/pyboxes/bin/geomatics.prepro.landarts.pb $1 $2

echo "LANDARTs finished !"

mkdir -p $3

tar -xzf $1 -C $3