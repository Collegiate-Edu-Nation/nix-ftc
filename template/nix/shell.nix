# SPDX-FileCopyrightText: Collegiate Edu-Nation
# SPDX-License-Identifier: GPL-3.0-or-later

{ pkgs, deps, ... }:

{
  default = pkgs.mkShell {
    packages = deps.build;

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
