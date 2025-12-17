# nix-ftc

![Static Badge](https://img.shields.io/badge/Platforms-Linux,_macOS-forestgreen?style=for-the-badge)
[![built with garnix](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2FCollegiate-Edu-Nation%2Fnix-ftc%3Fbranch%3Dmain&style=for-the-badge&color=grey&labelColor=grey)](https://garnix.io/repo/Collegiate-Edu-Nation/nix-ftc)
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

### Binary Cache

You can drastically speed up build times for the devShell via the provided binary cache by adding [Garnix] to your nix-config

```nix
nix.settings.substituters = [ "https://cache.garnix.io" ];
nix.settings.trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
```

> [!NOTE]
> As the CI build uses the parent flake's lockfile, the cache will become stale within a few weeks of the most recent commit. You may be able to circumvent this by copying this lockfile to your repo

## Implementation

- [android-nixpkgs] is used for multiple reasons:
  - Simple bootstrapping
  - Several supported systems
  - Up-to-date packages
  - A functioning emulator _(not included by default, but can be helpful)_

- Rather than forking the [FTC SDK], this project clones it in the `shellHook` to minimize maintenance since FTC generally releases multiple versions each season w/o bumping external dependencies

- In the spirit of minimizing maintenance, the template is intended to be pulled sans lockfile by end users. As this breaks reproducibility, however, this prevents directly building the template's devShell in CI. To circumvent this, the devShell is composed in a highly modular manner, which enables building it in the parent flake as well (which includes a lockfile), allowing for CI builds w/o necessitating several updates per season

- Gradlew complains about read-only file systems if the expected versions of tooling are missing from `$PATH` (expected Nix behavior), so necessary versions are specified

- The `aapt2` binary included in `build-tools` doesn't support the `--source-path` arg, so the `aapt` package from nixpkgs is used in its place

## License

[GPLv3](COPYING)

[FTC SDK]: https://github.com/FIRST-Tech-Challenge/FtcRobotController
[OnBot Java]: https://ftc-docs.firstinspires.org/en/latest/programming_resources/onbot_java/OnBot-Java-Tutorial.html
[Garnix]: https://garnix.io/
[android-nixpkgs]: https://github.com/tadfisher/android-nixpkgs
