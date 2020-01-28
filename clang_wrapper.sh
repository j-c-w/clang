#!/bin/bash

# Try running idl clang, then fallback to normal clang.

execdir=$(dirname $0)

idl_clang="$execdir/idlclang"

(timeout 20 $idl_clang "$@" && echo "****IDLClang Worked :)") || (echo "****IDLClang Failed.  Falling back to normal clang"; exec $idl_clang "$@" -fno-idl)
