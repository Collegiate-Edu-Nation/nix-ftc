# nix-ftc
![Static Badge](https://img.shields.io/badge/Android_API-30-blue)
![Static Badge](https://img.shields.io/badge/OpenJDK-21.0.3-blue)
![Static Badge](https://img.shields.io/badge/Platforms-Linux,_macOS-green)
![Static Badge](https://img.shields.io/badge/Powered_by_Nix-grey?logo=nixOS&logoColor=white)

FTC Development Environment via Nix Flake 

Offers reproducible and immutable Android support for the FTC SDK without the need for Android Studio, enabling advanced FTC development in your editor of choice without userspace clutter

Emulation is not included by default, but relevant boilerplate need only be uncommented

## Usage

<b>Must install flake-enabled Nix before running</b>

* Create a directory and enter it

        mkdir ftc && cd ftc

* Add this flake to the directory

        nix flake init -t github:collegiate-edu-nation/nix-ftc

* Adjust the flake as needed, then:  

        nix develop

This will load a shell-based development environment with OpenJDK and the Android SDK. All you'll need to do is open FtcRobotController in your editor of choice, and you're ready to start working in TeamCode

Gradlew builds are supported, but manual builds can be omitted if you prefer uploading TeamCode via OnBot

Once the dev session is complete, close your editor and leave the shell

    exit

## Implementation

* Android-Nixpkgs is used for multiple reasons: simple bootstrapping, several supported systems, up-to-date packages, and a functioning emulator

* Gradlew complains about read-only file systems if the expected versions of tooling are missing from $PATH (expected Nix behavior), so necessary versions are specified

* The aapt2 binary included in build-tools doesn't support the --source-path arg, so the aapt package from nixpkgs is used in its place

## License
[GPLv3](COPYING)
