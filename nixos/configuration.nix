# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./languages.nix
    ];
  
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ 
  "video=HDMI-A-1:1920x1080@120"
  "i915.enable_fbc=0"
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  i18n.inputMethod = {
   enable = true;
   type = "fcitx5";
   fcitx5.addons = with pkgs; [
     fcitx5-gtk
     #fcitx5-configtool
     qt6Packages.fcitx5-unikey
   ];
  };
  
   # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false; #turn true if u use gnome
  
  # Enable the i3 WM
  services.xserver.windowManager.i3.enable = true;
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.xserver.libinput.touchpad.naturalScrolling = true;
  
  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # for global user
  users.defaultUserShell = pkgs.zsh;
  
  users.users.dontwait.shell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dontwait = {
    isNormalUser = true;
    description = "dontwait";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "docker"];
    packages = with pkgs; [
    #  thunderbird
    	docker
    ];

  };

  # Install firefox.
  programs.firefox.enable = true;
  
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ];
  programs = {
   adb.enable = true;
  };

  programs.bash.enableCompletion = true;

  nixpkgs.config.allowBroken = true; 

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  system.userActivationScripts = {
  stdio = {
    text = ''
      rm -f ~/Android/Sdk/platform-tools/adb
      ln -s /run/current-system/sw/bin/adb ~/Android/Sdk/platform-tools/adb
    '';
    deps = [
    ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Core tools 
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    wget
    git
    dmenu
    networkmanagerapplet
    fastfetch
    zsh
    oh-my-zsh
    ghostty 
    vscode-fhs
    curl
    unzip
    tmux  
    zathura 
    discord
    home-manager
    qt6Packages.fcitx5-configtool
    stow
    tldr
    stdenv.cc.cc
    zlib
    glib
    cmake
    fontconfig
    freetype
    libGL
    obs-studio
    gnutar
    gzip
    home-manager
    tree-sitter
    edid-decode
    tree
    brave
    libreoffice-qt
    hunspell
    staruml
    vmware-workstation
    i3
    xclip
    # i3status
    
    dunst
    feh
    pavucontrol
    flameshot
    rofi
    picom
    blueman
    arandr
    autorandr
     
    (polybar.override {
     i3Support = true;
     pulseSupport = true;
     }) 

 ];
    # NIXOS
  nix.settings.experimental-features = ["nix-command" "flakes"];
    

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  virtualisation.docker.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # VMWare config
  virtualisation.vmware.host.enable = true;
  virtualisation.vmware.guest.enable = true;
  
  # Garbage Collector Setting
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";

   
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
