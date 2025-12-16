# SPDX-FileCopyrightText: Collegiate Edu-Nation
# SPDX-License-Identifier: GPL-3.0-or-later

{ pkgs, android-sdk }:

{
  build = [
    android-sdk
  ]
  ++ (with pkgs; [
    jdk21
    aapt
  ]);
}
