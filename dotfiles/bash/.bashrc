#!/usr/bin/env bash

# Don't do anything if not running interactively
if [[ $- != *i* ]]; then
    return
fi

for file in "${HOME}"/.bashrc.d/*; do
    source "$file";
done

