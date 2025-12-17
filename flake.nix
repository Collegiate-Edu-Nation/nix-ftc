# SPDX-FileCopyrightText: Collegiate Edu-Nation
# SPDX-License-Identifier: GPL-3.0-or-later

{
  nixConfig.bash-prompt = ''\n\[\033[1;31m\][devShell:\w]\$\[\033[0m\] '';

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
      self,
      ...
    }:
    let
      forEachSupportedSystem = (
        import ./template/nix/lib/forEachSupportedSystem.nix { inherit nixpkgs android-nixpkgs; }
      );
    in
    {
      templates = {
        ftc = {
          path = ./template;
        };
      };
      defaultTemplate = self.templates.ftc;

      # referencing here to build the shell in CI
      devShells = forEachSupportedSystem (import ./template/nix/shell.nix);
    };
}
