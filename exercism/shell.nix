let
  pkgs = import <nixpkgs> { };
  stdenv = pkgs.llvmPackages_13.stdenv;
in

pkgs.stdenv.mkDerivation
{
  name = "elm-pos";
  version = "0.1.0";
  
  buildInputs = with pkgs; [
    cabal-install
    exercism
    ghc
    stack
    llvmPackages_13.bintools
    llvmPackages_13.clang
    llvmPackages_13.libclang
    llvmPackages_13.libcxx
    llvmPackages_13.libcxxabi
    llvmPackages_13.libcxxClang
    llvmPackages_13.libcxxStdenv
    llvmPackages_14.libllvm
    llvmPackages_13.llvm
    llvmPackages_13.openmp
    llvmPackages_13.stdenv
    sqlite
    zlib
  ];

  meta = {
    description = "PoS (point of sale) frontend in elm";
    license = "BSD";
  };
}