#!/bin/bash

cat << EOF
    hello
    world
EOF

# 忽略行首的Tab键
cat <<- EOF
    hello
    world
EOF