{ ... }:

{
  programs.git = {
    enable = true;
    userEmail = "shqrp@shqrp.lol";
    userName = "Shqrp";
    signing = {
      key = "/home/shqrp/.ssh/shqrp_signing.pub";
      format = "ssh";
      signByDefault = true;
    };
    extraConfig = {
      gpg.format = "ssh";
    };
  };
}
