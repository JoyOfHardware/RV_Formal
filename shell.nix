{ pkgs ? import <nixpkgs> {} }:

let
  riscv64-linux = pkgs.pkgsCross.riscv64;
in
pkgs.mkShell {
  buildInputs = [
    riscv64-linux.gcc
    riscv64-linux.binutils
    riscv64-linux.glibc
  ];

  shellHook = ''
    echo "RISC-V Linux cross-compilation environment initialized!"
  '';
}