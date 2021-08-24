# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lenovo";

  time.timeZone = "Europe/Rome";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Locale
  i18n.defaultLocale = "it_IT.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "it";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Account
  users.users.vale = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "audio" "video" "input" "networkmanager" "adbusers" ];
  };

  # Packets
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    networkmanager
    home-manager
    gnome3.dconf
    fish
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    media-session.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ rocm-opencl-icd ];
    driSupport = true;
  };

  networking.networkmanager.enable = true;
  networking.nameservers = [ "9.9.9.9" "149.112.112.112" ];

  fonts.fonts = with pkgs; [ source-code-pro emojione ];

  environment.etc."pam.d/swaylock".text = "auth include login";

  services.flatpak.enable = true;

  xdg.portal.enable = true;
  
  hardware.bluetooth.enable = true;

  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

