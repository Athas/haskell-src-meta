#! /bin/sh
set -eu

# requires cabal2nix
# requires colordiff
# TODO gracefully fall back to diff if no colordiff

echo 'Linting .nix files generated by cabal2nix'

package=haskell-src-meta
nixfile=$package/default.nix

if (cd $package && cabal2nix .) | colordiff "$nixfile" /dev/stdin 2>/dev/null; then
  echo 'All .nix files generated by cabal2nix match expected output'
else
  # TODO: echo command for generating file correctly
  echo "Generated file $nixfile does not match. To fix, try:"
  echo "(cd $package && cabal2nix .) > $nixfile"
  echo
  echo 'Some .nix files generated by cabal2nix do not match expected output'
  exit 1;
fi
