{ pkgs, ... }:

{
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    settings = {
      capture_with_kms = "on";
      audio_sink = "Sunshine-Audio";
      virtual_sink = "Sunshine-Audio";
      encoder = "nvenc";
    };
  };
  # auto discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  programs.steam.enable = true;
  home-manager.users.hades = { pkgs, ... }: {
    xdg.configFile."sunshine/apps.json".text = builtins.toJSON {
      env = {
        PATH = "$(PATH):${pkgs.util-linux}/bin:${pkgs.steam}/bin";
        DISPLAY = ":0";
        HOME = "/home/hades";
      };
      apps = [
        {
          name = "Big Picture";
          cmd = "${pkgs.steam}/bin/steam -gamepadui";
          # prep-cmd = [{
          #   do = "${pkgs.steam}/bin/steam -gamepadui";
          #   undo = "${pkgs.steam}/bin/steam -shutdown";
          # }];
          image-path = "steam.png";
        }
      ];
    };
  };
}
