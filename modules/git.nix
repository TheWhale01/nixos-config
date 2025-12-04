{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = false;
      user.name = "TheWhale01";
      user.email = "ard.rasp01@gmail.com";
    };
  };
}
