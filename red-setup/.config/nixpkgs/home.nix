{ config, pkgs, ... }:

rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vale";
  home.homeDirectory = "/home/vale";

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    htop
    tdesktop
    keepass
    gnome.nautilus
    syncthing
    ungoogled-chromium
    pavucontrol
    nodejs
    swaylock
    swayidle
    mako
    wofi
    wf-recorder
    gammastep
    kanshi
    xwayland
    brightnessctl
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    wtype
    clipman
    flameshot
    notify-desktop
    nixpkgs-fmt
    tree
    grim
    slurp
    imagemagick
    imv
    multimc
    rnix-lsp
    unzip
    steam-run
    pywal
    dconf
    python39Packages.youtube-dl
    (
      pkgs.writeTextFile {
        name = "uchromium";
        destination = "/bin/uchromium";
        executable = true;
        text = ''
          #! ${pkgs.bash}/bin/bash
          chromium --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-gpu --enable-usermedia-screen-capturing "$@"
        '';
      }
    )
    (
      pkgs.writeTextFile {
        name = "wcode";
        destination = "/bin/wcode";
        executable = true;
        text = ''
          #! ${pkgs.bash}/bin/bash
          code --enable-features=UseOzonePlatform --ozone-platform=wayland "$@"
        '';
      }
    )
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "uchromium";
    QT_QPA_PLATFORMTHEME = "gtk2";
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    font = {
      name = "Source Code Pro";
      size = 10;
    };
    theme.name = "oomox-wal";
    iconTheme.name = "Red-Dot-Black-Dark-Icons";
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = import ./sway.nix;
  };

  systemd.user.services.kanshi = {
    Unit = {
      description = "Kanshi output autoconfig";
      wantedBy = [ "graphical-session-pre.target" ];
      partOf = [ "graphical-session-pre.target" ];
    };
    Service = {
      ExecStart = ''
        ${pkgs.kanshi}/bin/kanshi
      '';
      RestartSec = 5;
      Restart = "always";
    };
  };

  programs = {
    neovim = {
      enable = true;
      extraPackages = with pkgs; [ rnix-lsp ];
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        coc-nvim
        coc-rust-analyzer
        coc-json
        coc-markdownlint
        coc-python
        coc-yaml
        coc-clangd
        vim-addon-nix
        vim-toml
      ];
      extraConfig = ''
        set lines number
	set guicursor=a:ver1
      '';
    };

    alacritty = {
      enable = true;
      settings = {
        cursor = {
          style.shape = "Beam";
          blinking = "On";
          blinking_interval = 750;
        };
        font.normal = {
          family = "Source Code Pro";
          style = "Regular";
        };
      };
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "fenv";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-foreign-env";
            rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
            sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
          };
        }
      ];
      interactiveShellInit = ''
        fenv source /etc/profile
        cat ~/.config/nixpkgs/sequences
        echo -e -n "\x1b[\x35 q"
      '';
      loginShellInit = ''
        if test (id --user $USER) -ge 1000 && test (tty) = "/dev/tty1"
          exec dbus-run-session sway
        end
      '';
      functions = {
        fish_greeting = {
          body = "cat ~/.ascii_wallp";
        };
      };
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
	# Addiotional ones: dlasagno.wal-theme arrterian.nix-env-selector 
	matklad.rust-analyzer
        vadimcn.vscode-lldb
        ms-vscode.cpptools
        ms-python.python
	bbenoist.Nix
	tamasfe.even-better-toml
      ];
    };

    git = {
      enable = true;
      userEmail = "hex0x0000@protonmail.com";
      userName = "hex0x0000";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
