{ pkgs, ... }:

{
  jovian = {
    steam = {
      enable = true;
      user = "poseidon";
    };
    hardware.has.amd.gpu = true;
    decky-loader = {
      enable = true;
    };
  };
}
