# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./machines/ramp-rat/hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/languages.nix
    ./modules/terminal.nix
    ./modules/unfree.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ramp-rat";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

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

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = ["JetBrainsMono"];
        monospace = ["JetBrainsMono"];
      };
    };
  };

  # Nvidia driver BS
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [nvidia-vaapi-driver];
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.defaultSession = "gnome-xorg";
  services.gnome.gnome-browser-connector.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bart = {
    isNormalUser = true;
    description = "Bart";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
    ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
      persistent = true;
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  nixpkgs = {
    config = {
      packageOverrides = pkgs: {
        unstable = pkgs.unstable {
          config = config.nixpkgs.config;
        };
      };
    };
  };

  # Enable Tailscale VPN
  services.tailscale.enable = false;
  #  systemd.services.tailscale-autoconnect = {
  #    description = "Automatic connection to Tailscale";
  #
  #    # make sure tailscale is running before trying to connect to tailscale
  #    after = ["network-pre.target" "tailscale.service"];
  #    wants = ["network-pre.target" "tailscale.service"];
  #    wantedBy = ["multi-user.target"];
  #
  #    # set this service as a oneshot job
  #    serviceConfig.Type = "oneshot";
  #
  #    # have the job run this shell script
  #    script = with pkgs; ''
  #      # wait for tailscaled to settle
  #      sleep 2
  #
  #      # check if we are already authenticated to tailscale
  #      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
  #      if [ $status = "Running" ]; then # if so, then do nothing
  #        exit 0
  #      fi
  #
  #      # otherwise authenticate with tailscale
  #      ${tailscale}/bin/tailscale up
  #    '';
  #  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #  # };

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
  system.stateVersion = "23.11"; # Did you read the comment?
}
