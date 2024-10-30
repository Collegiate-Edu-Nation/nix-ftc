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
