# nix-ftc

![Static Badge](https://img.shields.io/badge/Platforms-Linux,_macOS-forestgreen?style=for-the-badge)
![Static Badge](https://img.shields.io/badge/Powered_by_Nix-grey?style=for-the-badge&logo=nixOS&logoColor=white)

FTC Development Environment via Nix Flake

Declarative, reproducible, and immutable Android support for the [FTC SDK] without the need for Android Studio, enabling advanced FTC development in your editor of choice without userspace clutter

## Usage

**Must install flake-enabled Nix before running**

- Create a directory and enter it

  ```shell
  mkdir ftc && cd ftc
  ```

- Add this flake to the directory

  ```shell
  nix flake init -t github:collegiate-edu-nation/nix-ftc
  ```

- Adjust the flake as needed, then:

  ```shell
  nix develop
  ```

This will load a shell-based development environment with OpenJDK and the Android SDK. All you'll need to do is open the repo in your editor of choice, and you're ready to start working in `TeamCode/`

Gradlew builds are supported, but manual builds can be omitted if you prefer uploading `TeamCode/` via [OnBot Java]

Once the dev session is complete, close your editor and leave the shell

```shell
exit
```

## Implementation

- [android-nixpkgs] is used for multiple reasons:
  - Simple bootstrapping
  - Several supported systems
  - Up-to-date packages
  - A functioning emulator _(not included by default, but can be helpful)_

- Rather than forking the [FTC SDK], this project clones it in the `shellHook` to minimize maintenance since FTC generally releases multiple versions each season w/o bumping external dependencies

- Gradlew complains about read-only file systems if the expected versions of tooling are missing from `$PATH` (expected Nix behavior), so necessary versions are specified

- The `aapt2` binary included in `build-tools` doesn't support the `--source-path` arg, so the `aapt` package from nixpkgs is used in its place

## License

[GPLv3](COPYING)

[FTC SDK]: https://github.com/FIRST-Tech-Challenge/FtcRobotController
[OnBot Java]: https://ftc-docs.firstinspires.org/en/latest/programming_resources/onbot_java/OnBot-Java-Tutorial.html
[android-nixpkgs]: https://github.com/tadfisher/android-nixpkgs
