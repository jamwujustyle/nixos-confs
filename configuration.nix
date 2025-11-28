{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw"; # Define your hostname.

  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  ## new line
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
	settings = {
		experimental-features = ["nix-command" "flakes"];
	};
};
 
  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # }

  # services.xserver.enable = true;

services.xserver = {
  enable = true;
  windowManager.qtile.enable = true;
  displayManager.sessionCommands = ''
    xwallpaper --zoom ~/Downloads/chinatown.png
    xset r rate 200 35 &
    eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    export SSH_AUTH_SOCK
  '';
};
  services.picom = { 
	enable = true;
	backend = "glx";
	fade = true;
	};

  #new
  services.gnome.gnome-keyring.enable = true;
  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
 users.users.lord = {
   isNormalUser = true;
   extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
     tree
   ];
 };

 programs.firefox.enable = true;

 environment.systemPackages = with pkgs; [
   vim 
   wget
	alacritty
	xclip
	git
	vscode 
	btop
	gedit
	xwallpaper
	pcmanfm
	rofi
	brightnessctl
	jetbrains.goland
	go
	gopls
	go-tools
	delve
	golangci-lint

];




fonts.packages = with pkgs; [
	jetbrains-mono
	];
  #new
  services.dbus.enable = true;
  environment.sessionVariables = {
  SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # system.copySystemConfiguration = true;

  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

