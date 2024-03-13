{ pkgs ? import <nixpkgs> { } }:
let
  version = "0.1.4"
 src = pkgs.fetchFromGitHub {
   owner = "hyprwm";
   repo = "hyprcursor";
   rev = "v${version}";
   hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
 }; 
in import "${src}/release.nix"
