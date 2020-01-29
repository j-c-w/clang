#!/bin/bash

# Try running idl clang, then fallback to normal clang.

execdir=$(dirname $0)

idl_clang="$execdir/idlclang"

(timeout 8 $idl_clang "$@" && echo "****IDLClang Worked :)")
err_code=$?

if [[ $err_code == 124 ]]; then
  echo "****IDLClang Timed out.  Falling back to normal clang"
  exec $idl_clang "$@" -fno-idl
elif [[ $err_code -ne 0 ]]; then
  echo "****IDLClang Failed.  Falling back to normal clang"
  exec $idl_clang "$@" -fno-idl
fi
