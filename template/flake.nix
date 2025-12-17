# SPDX-FileCopyrightText: Collegiate Edu-Nation
# SPDX-License-Identifier: GPL-3.0-or-later

{
  description = "FTC Development Environment via Nix Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      android-nixpkgs,
      ...
    }:
    let
      forEachSupportedSystem = (
        import ./nix/lib/forEachSupportedSystem.nix { inherit nixpkgs android-nixpkgs; }
      );
    in
    {
      devShells = forEachSupportedSystem (import ./nix/shell.nix);
    };
}
