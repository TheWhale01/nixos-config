{ ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };
  services.displayManager.gdm.enable = true;
}
