# SPDX-FileCopyrightText: Collegiate Edu-Nation
# SPDX-License-Identifier: GPL-3.0-or-later

{ nixpkgs, android-nixpkgs }:

let
  supportedSystems = [
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
in
function:
nixpkgs.lib.genAttrs supportedSystems (
  system:
  function rec {
    pkgs = nixpkgs.legacyPackages.${system};
    android-sdk = android-nixpkgs.sdk.${system} (
      sdkPkgs: with sdkPkgs; [
        build-tools-34-0-0
        cmdline-tools-13-0
        platform-tools
        platforms-android-30
      ]
    );
    deps = (import ../deps.nix { inherit pkgs android-sdk; });
  }
)
