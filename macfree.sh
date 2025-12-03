#!/usr/bin/env bash
MF_VERSION="1.0"

macfree_help() {
   echo "disable Gatekeeper protection for a given application"
   echo
   echo "usage: $(basename "$0") [application/binary]"
   echo "options: [--help/-h]      -       display this dialog"
   echo "         [--version/-v]   -   display macfree version"
}

macfree_id() {
   echo "$(basename "$0"): version $MF_VERSION"
}

if [[ "$#" -eq 0 ]]; then
   macfree_help
   exit 0
fi

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
   macfree_help
   exit 0
fi

if [[ "$1" == "--version" || "$1" == "-v" ]]; then
   macfree_id
   exit 0
fi

if [[ $EUID -ne 0 ]]; then
   echo "$(basename "$0") must be run as root!"
   exit 1
fi

xattr -dr com.apple.quarantine $1
