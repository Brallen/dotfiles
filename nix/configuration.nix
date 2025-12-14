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
  hardware.bluetooth.enable = true;
  programs.ssh.startAgent = true;

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
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = ["JetBrainsMono Nerd Font"];
        monospace = ["JetBrainsMono Nerd Font"];
      };
    };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bart = {
    isNormalUser = true;
    description = "Bart";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
  };
  environment.shells = with pkgs; [zsh];

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

  system.stateVersion = "25.11";
}
