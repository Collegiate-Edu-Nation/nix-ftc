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
      supportedSystems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forEachSupportedSystem =
        function:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          function {
            pkgs = nixpkgs.legacyPackages.${system};
            android-sdk = android-nixpkgs.sdk.${system} (
              sdkPkgs: with sdkPkgs; [
                build-tools-34-0-0
                cmdline-tools-13-0
                platform-tools
                platforms-android-30
              ]
            );
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs, android-sdk }:
        {
          default = pkgs.mkShell {
            packages = [
              android-sdk
            ]
            ++ (with pkgs; [
              jdk21
              aapt
            ]);

            # override aapt2 binary w/ nixpkgs'
            env.GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${pkgs.aapt}/bin/aapt2";

            shellHook = ''
              if ! test -d ./FtcRobotController; then
                echo -e "Fetching FTC SDK..."
                git clone https://github.com/FIRST-Tech-Challenge/FtcRobotController.git
                mv FtcRobotController FtcRobotController.backup
                mv FtcRobotController.backup/{.,}* .
                rm -r FtcRobotController.backup
                echo ""
              fi

              echo -e "\nFTC Development Environment via Nix Flake\n"

              echo -e "┌───────────────────────────────────────────────────────────────────────────────────────┐"
              echo -e "│                                   Helpful Commands                                    │"
              echo -e "├───────────────┬───────────────────────────────────────────────────────────────────────┤"
              echo -e "│ Build app     │ ./gradlew assemble                                                    │"
              echo -e "│ Test app      │ ./gradlew test                                                        │"
              echo -e "│ WiFi Connect  │ adb connect 192.168.43.1:5555                                         │"
              echo -e "│ Uninstall app │ adb uninstall com.qualcomm.ftcrobotcontroller                         │"
              echo -e "│ Install app   │ adb install ./TeamCode/build/outputs/apk/release/TeamCode-release.apk │"
              echo -e "└───────────────┴───────────────────────────────────────────────────────────────────────┘\n"
            '';
          };
        }
      );
    };
}
