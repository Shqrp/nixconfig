{ pkgs, hostname, ... }:

let
  enabled = hostname == "ryzenix" || hostname == "nixpad";
in
{
  systemd.user.services."moodle-dl" =
    if enabled then
      {
        Service = {
          Type = "oneshot";
          ExecStart = [
            "${pkgs.moodle-dl}/bin/moodle-dl --path /home/shqrp/${
              if hostname == "ryzenix" then "Vienna/" else ""
            }Uni/Corsi"
          ];
          ExecCondition = [ "${pkgs.curl}/bin/curl --silent --head --request GET https://8.8.8.8" ];
          MemoryMax = "500M";
          Nice = 19;
        };
      }
    else
      { };

  systemd.user.timers."moodle-dl" =
    if enabled then
      {
        Timer = {
          OnCalendar = "*:0/5";
          Persistent = true;
        };
        Install.WantedBy = [ "timers.target" ];
      }
    else
      { };
}
