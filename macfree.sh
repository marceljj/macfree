#!/usr/bin/env bash

macfree_help() {
   echo "usage: $(basename "$0") [application/executable]"
   echo "disable Gatekeeper protection for a given application"
}

if [[ "$#" -eq 0 ]]; then
   macfree_help
   exit 0
fi

if [[ $EUID -ne 0 ]]; then
   echo "$(basename "$0") must be run as root!"
   exit 1
fi

xattr -dr com.apple.quarantine $1
