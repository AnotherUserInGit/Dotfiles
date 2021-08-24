rec {
  modifier = "Mod4";

  startup = [
    {
      command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway";
    }
    {
      command = "gammastep -l manual:lat=44.515313:lon=10.732699";
    }
    {
      command = ''
        swayidle -w \
            timeout 300 'swaylock -f -c 000000' \
            timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
            before-sleep 'swaylock -f -c 000000'
      '';
      always = true;
    }
  ];

  menu = "wofi --show run";

  terminal = "alacritty";

  output = {
    "*" = {
      bg = "~/.wallpaper.jpg fill";
    };
  };

  input = {
    "*" = { xkb_layout = "it"; };
    "1267:12363:ELAN469D:00_04F3:304B_Touchpad" = {
      dwt = "enabled";
      tap = "enabled";
      natural_scroll = "enabled";
      middle_emulation = "enabled";
    };
  };

  keybindings = {
    "${modifier}+Return" = "exec ${terminal}";
    "${modifier}+Shift+q" = "kill";
    "${modifier}+d" = "exec ${menu}";
    "${modifier}+Shift+c" = "reload";
    "${modifier}+Shift+e" = ''exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit' '';
    "${modifier}+Left" = "focus left";
    "${modifier}+Down" = "focus down";
    "${modifier}+Up" = "focus up";
    "${modifier}+Right" = "focus right";
    "${modifier}+Shift+Left" = "move left";
    "${modifier}+Shift+Down" = "move down";
    "${modifier}+Shift+Up" = "move up";
    "${modifier}+Shift+Right" = "move right";
    "${modifier}+1" = "workspace number 1";
    "${modifier}+2" = "workspace number 2";
    "${modifier}+3" = "workspace number 3";
    "${modifier}+4" = "workspace number 4";
    "${modifier}+5" = "workspace number 5";
    "${modifier}+6" = "workspace number 6";
    "${modifier}+7" = "workspace number 7";
    "${modifier}+8" = "workspace number 8";
    "${modifier}+9" = "workspace number 9";
    "${modifier}+0" = "workspace number 10";
    "${modifier}+Shift+1" = "move container to workspace number 1";
    "${modifier}+Shift+2" = "move container to workspace number 2";
    "${modifier}+Shift+3" = "move container to workspace number 3";
    "${modifier}+Shift+4" = "move container to workspace number 4";
    "${modifier}+Shift+5" = "move container to workspace number 5";
    "${modifier}+Shift+6" = "move container to workspace number 6";
    "${modifier}+Shift+7" = "move container to workspace number 7";
    "${modifier}+Shift+8" = "move container to workspace number 8";
    "${modifier}+Shift+9" = "move container to workspace number 9";
    "${modifier}+Shift+0" = "move container to workspace number 10";
    "${modifier}+b" = "splith";
    "${modifier}+v" = "splitv";
    "${modifier}+s" = "layout stacking";
    "${modifier}+w" = "layout tabbed";
    "${modifier}+e" = "layout toggle split";
    "${modifier}+f" = "fullscreen";
    "${modifier}+Shift+space" = "floating toggle";
    "${modifier}+space" = "focus mode_toggle";
    "${modifier}+a" = "focus parent";
    "${modifier}+Shift+minus" = "move scratchpad";
    "${modifier}+minus" = "scratchpad show";
    "${modifier}+r" = ''mode "resize"'';
    # Personal ones
    "${modifier}+h" = ''exec grim Screenshots/$(date +'%s.png') && notify-desktop "Screenshot taken"'';
    "${modifier}+Shift+h" = ''exec grim -g "$(slurp)" Screenshots/$(date +'%s.png') && notify-desktop "Screenshot taken"'';
    "${modifier}+j" = ''exec grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | xargs -r0 notify-desktop'';
  };

  fonts = {
    names = [ "Source Code Pro" ];
    style = "Regular";
    size = 10.0;
  };

  colors = {
    background = ''#0a0707'';
    focused = {
      background = ''#d6462b'';
      border = ''#d6462b'';
      childBorder = ''#d6462b'';
      indicator = ''#d6462b'';
      text = ''#bcb0be'';
    };
    focusedInactive = {
      background = ''#984738'';
      border = ''#984738'';
      childBorder = ''#984738'';
      indicator = ''#984738'';
      text = ''#bcb0be'';
    };
    unfocused = {
      background = ''#604744'';
      border = ''#604744'';
      childBorder = ''#604744'';
      indicator = ''#604744'';
      text = ''#bcb0be'';
    };
    urgent = {
      background = ''#961e12'';
      border = ''#961e12'';
      childBorder = ''#961e12'';
      indicator = ''#961e12'';
      text = ''#bcb0be'';
    };
    placeholder = {
      background = ''#0a0707'';
      border = ''#0a0707'';
      childBorder = ''#0a0707'';
      indicator = ''#0a0707'';
      text = ''#bcb0be'';
    };
  };
}
