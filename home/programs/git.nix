{ ... }:

{
  programs.git = {
    enable = true;

    signing = {
      key = "/home/shqrp/.ssh/shqrp_signing.pub";
      format = "ssh";
      signByDefault = true;
    };
    settings = {
      user = {
        email = "shqrp@shqrp.lol";
        name = "Shqrp";
      };
      gpg.format = "ssh";
    };
  };
}
