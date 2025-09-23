{ ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
          label = "lock";
          action = "hyprlock";
          text = "Lock";
          keybind = "l";
      }
      {
          label = "logout";
          action = "hyprctl dispatch exit 0";
          text = "Logout";
          keybind = "e";
      }
      {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
      }
      {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
      }
    ];
    style = ''
      @define-color bar-bg rgba(0, 0, 0, 0);
      @define-color main-bg #11111b;
      @define-color main-fg #cdd6f4;
      @define-color wb-act-bg #a6adc8;
      @define-color wb-act-fg #313244;
      @define-color wb-hvr-bg #f5c2e7;
      @define-color wb-hvr-fg #313244;

      * {
        background-image: none;
        font-size: 21.6px;
      }

      window {
        background-color: transparent;
      }

      button {
        color: white;
        background-color: @main-bg;
        outline-style: none;
        border: none;
        border-width: 0px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 10%;
        border-radius: 0px;
        box-shadow: none;
        text-shadow: none;
        animation: gradient_f 20s ease-in infinite;
      }

      button:focus {
        background-color: @wb-act-bg;
        background-size: 20%;
      }

      button:hover {
        background-color: @wb-hvr-bg;
        background-size: 25%;
        border-radius: 50px;
        animation: gradient_f 20s ease-in infinite;
        transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
      }

      button:hover#lock {
        border-radius: 50px 50px 0px 50px;
        margin : 288px 0px 0px 819px;
      }

      button:hover#logout {
        border-radius: 50px 0px 50px 50px;
        margin : 0px 0px 288px 819px;
      }

      button:hover#shutdown {
        border-radius: 50px 50px 50px 0px;
        margin : 288px 819px 0px 0px;
      }

      button:hover#reboot {
        border-radius: 0px 50px 50px 50px;
        margin : 0px 819px 288px 0px;
      }

      #lock {
        background-image: url("${./icons/lock_white.png}");
        border-radius: 80px 0px 0px 0px;
        margin : 360px 0px 0px 896px;
      }

      #logout {
        background-image: url("${./icons/logout_white.png}");
        border-radius: 0px 0px 0px 80px;
        margin : 0px 0px 360px 896px;
      }

      #shutdown {
        background-image: url("${./icons/shutdown_white.png}");
        border-radius: 0px 80px 0px 0px;
        margin : 360px 896px 0px 0px;
      }

      #reboot {
        background-image: url("${./icons/reboot_white.png}");
        border-radius: 0px 0px 80px 0px;
        margin : 0px 896px 360px 0px;
      }
    '';
  };
}
