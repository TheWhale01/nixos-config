{ pkgs, ... }:

{
  jovian = {
    steam = {
      enable = true;
      desktopSession = "Hyprland";
      user = "poseidon";
    };
    hardware.has.amd.gpu = true;
    decky-loader = {
      enable = true;
    };
  };
}
