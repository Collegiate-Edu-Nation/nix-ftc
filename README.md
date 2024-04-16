# nix-ftc
FTC Development Environment via Nix Flake.  

Offers reproducible and immutable Android support for the FTC SDK on Linux and MacOS (and Windows via WSL) without the need for Android Studio, enabling advanced FTC development in your editor of choice without userspace clutter. Emulation is not included by default, but relevant boilerplate need only be uncommented.
<details>
<summary><b>Usage</b></summary>

Note: git is required, though if you're using flake-enabled nix, this is a safe assumption in my book.  

There's several options for initial project bootstrapping. I personally have user scripts copy flakes into my project folders to avoid needing to remember yet another repo name, but this seems to be the most common approach:  

    nix flake init -t github:camdenboren/nix-ftc

Adjust the flake as needed, then:  

    nix develop

This will throw you into a shell-based development environment with Java and the Android SDK. All you'll need to do is open FtcRobotController in your editor of choice, and you're ready to start working in TeamCode/  

Gradlew builds are supported (and necessary for more advanced app modifications), but builds can be omitted if you prefer uploading TeamCode/ via OnBot (in which case you can probably leave out the Android SDK).

Once the dev session is complete, close your editor and leave the shell with:

    exit  
</details>

<details>
<summary><b>Supported Architectures</b></summary>

For Linux, only x86_64 is supported due to upstream. For MacOS, both aarch64 and x86_64 are supported (though x86_64 is untested on my end).
</details>

<details>
<summary><b>Implementation Details</b></summary>

First, Android-Nixpkgs is used for multiple reasons: simple bootstrapping, several supported systems, up-to-date packages, and a functioning emulator.  

Second, Gradlew complains about read-only file systems if the expected versions of tooling are missing from $PATH (expected Nix behavior), so necessary versions are specified.  

Last, the aapt2 binary included in build-tools doesn't support the --source-path arg, so the aapt package from nixpkgs is used in its place.
</details>