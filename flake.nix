# SPDX-FileCopyrightText: 2024 Collegiate Edu-Nation
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  outputs =
    { self }:
    {
      templates = {
        ftc = {
          path = ./template;
        };
      };
      defaultTemplate = self.templates.ftc;
    };
}
