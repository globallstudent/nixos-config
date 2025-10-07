{ config, pkgs, lib, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    glibc
    sqlite
  ];

  environment.variables.LD_LIBRARY_PATH = lib.mkForce (lib.makeLibraryPath [
    pkgs.stdenv.cc.cc.lib
    pkgs.libgcc
    pkgs.glibc
    pkgs.zlib
    pkgs.sqlite
  ]);
}
