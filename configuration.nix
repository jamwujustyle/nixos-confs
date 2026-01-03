
{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw"; # Define your hostname.


  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  ## new line
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
	settings = {
		experimental-features = ["nix-command" "flakes"];
	};
};
 
  time.timeZone = "Asia/Tashkent";


services.xserver = {
  enable = true;
  windowManager.qtile.enable = true;

  displayManager.sessionCommands = ''
    xwallpaper --zoom images/anime_skull.png
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

# Add PipeWire audio here:
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
};



  #new
  services.gnome.gnome-keyring = {
	enable = true;
};   

 users.users.lord = {
   isNormalUser = true;
   extraGroups = [ "wheel" "networkmanager" "video" "audio" ]; 
   packages = with pkgs; [
     tree
   ];
 };


programs = {
          firefox.enable = true;
          starship.enable = true;
  }; 

 environment.systemPackages = with pkgs; [
   vim 
   wget
	alacritty
	xclip
	git
vscode 
inputs.antigravity-nix.packages.${pkgs.system}.default
	btop
	gedit
	xwallpaper
	pcmanfm
	rofi
	brightnessctl
	
	#go stuff
	go
	gopls
	go-tools
	delve
	golangci-lint
	
	obs-studio
	v4l-utils  # for webcam
	telegram-desktop
	
	#audio bullshit
	pipewire
	mpv
	alsa-utils
	pavucontrol
	pulseaudio
	google-chrome
];




fonts.packages = with pkgs; [
	jetbrains-mono
	];
  services.dbus.enable = true;
  environment.sessionVariables = {
  SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
};

  system.stateVersion = "25.05"; # Did you read the comment?

}

