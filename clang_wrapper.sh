#!/bin/bash

# Try running idl clang, then fallback to normal clang.

execdir=$(dirname $0)

idl_clang="$execdir/idlclang"

# Grep every file for 'matrix'
echo "Scanning started"
for arg in "$@"; do
  if [[ -f $arg ]]; then
    if [[ $arg != *.o ]] && [[ $arg != *.so ]] && [[ $arg != *.a ]]; then
      grep -i matrix $arg
    fi
  fi
done

(timeout 8 $idl_clang "$@" && echo "****IDLClang Worked :)")
err_code=$?

if [[ $err_code == 124 ]]; then
  echo "****IDLClang Timed out.  Falling back to normal clang"
  exec $idl_clang "$@" -fno-idl
elif [[ $err_code -ne 0 ]]; then
  echo "****IDLClang Failed.  Falling back to normal clang"
  exec $idl_clang "$@" -fno-idl
fi
