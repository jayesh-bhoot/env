{
  description = "Nix configs";

  inputs = {
    nixosChan.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixosChanHM = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixosChan";
    };

    darwinChan.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwinChanHM = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "darwinChan";
    };

    # NOTE1: MonoLisa is a private flake: https://github.com/NixOS/nix/issues/3991
    # NOTE2: Beware of master vs main branch. nix by default assumes master.
    monolisa.url = "git+ssh://git@github.com/jayesh-bhoot/MonoLisa";
  };

  outputs = { self, nixosChan, nixosChanHM, darwinChan, darwinChanHM, monolisa }:
    let
      commonPkgs = chan: system:
        let
          pkgs = import chan {
            inherit system;
            config.allowUnfree = true;
          };
        in
        [
          pkgs.bashInteractive_5 # why not bash_5? bashInteractive_5 comes with readline support by default.
          pkgs.bash-completion
          pkgs.nix-bash-completions
          pkgs.direnv
          pkgs.nix-direnv

          pkgs.pass
          pkgs.bitwarden-cli

          pkgs.parallel
          pkgs.tree
          pkgs.htop

          pkgs.fzf
          pkgs.jq

          pkgs.rsync
          pkgs.wget
          pkgs.curl
          pkgs.wireshark-cli
          pkgs.entr

          pkgs.git
          pkgs.stow

          pkgs.mpv
          pkgs.ffmpeg
          pkgs.imagemagickBig

          pkgs.youtube-dl
          pkgs.aria

          # pkgs.vim
          pkgs.kakoune

          pkgs.nixpkgs-fmt
          pkgs.rnix-lsp
          pkgs.shellcheck

          pkgs.bc

          pkgs.fira # for Fira Sans for thick body text
          monolisa.defaultPackage.${system} # For thick monospaced fonts
          pkgs.jetbrains-mono # An alternative to MonoLisa for thick monospaced fonts
          pkgs.cascadia-code # An alternative to MonoLisa for thick monospaced fonts
          pkgs.noto-fonts
          pkgs.noto-fonts-extra
          pkgs.roboto
          pkgs.roboto-mono
          pkgs.fantasque-sans-mono
          pkgs.courier-prime
        ];

      nixosPkgs = system:
        let
          pkgs = import nixosChan {
            inherit system;
            config.allowUnfree = true;
          };
        in
        [
          pkgs.finger_bsd
          pkgs.xclip
          pkgs.chromium
          pkgs.teams
          pkgs.upwork
          pkgs.transmission-gtk
          pkgs.chromium
          pkgs.teams
          pkgs.vscode
          pkgs.jetbrains.webstorm
          pkgs.jetbrains.datagrip
          pkgs.jetbrains.idea-ultimate
          pkgs.celluloid
        ];

      darwinPkgs = system:
        let
          pkgs = import darwinChan {
            inherit system;
            config.allowUnfree = true;
          };
        in
        [
          pkgs.coreutils-full
          pkgs.findutils
          pkgs.diffutils
          pkgs.inetutils
          # Don't install binutils.
          # binutils provide building, compiling, linking,and binary utilities, not the command-line utilities as the other packages. 
          # Also, clang, ld, etc., provided by nix binutils somehow almost never work with errors like 'ld: symbol not found for architecture'
          # pkgs.binutils 

          pkgs.gnugrep
          pkgs.gnused
          pkgs.gawkInteractive

          pkgs.readline
          pkgs.gzip
          pkgs.gnutar
          pkgs.ncurses
          pkgs.less
          pkgs.more
          pkgs.gnupatch
          pkgs.time
          pkgs.which
          pkgs.texinfo
          pkgs.man
          # pkgs.man-pages
        ];
    in
    {
      nixosConfigurations = {
        "Jayeshs-Thinkpad-E431" = nixosChan.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              ({ config, lib, pkgs, modulesPath, options, specialArgs }: {
                # copied from hardware-configuration.nix, itself auto-generated by nixos-generate-config cmd.
                imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
                boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
                boot.initrd.kernelModules = [ ];
                boot.kernelModules = [ "kvm-intel" ];
                boot.extraModulePackages = [ ];
                fileSystems."/" = {
                  device = "/dev/disk/by-uuid/5bdefd0f-5143-4f81-80ac-1827d2c07f3b";
                  fsType = "ext4";
                };
                swapDevices = [ ];
                hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
              })

              ({ config, lib, pkgs, modulesPath, options, specialArgs }: {
                boot.loader.grub = {
                  enable = true;
                  version = 2;
                  device = "/dev/sda";
                };

                networking = {
                  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
                  # Per-interface useDHCP will be mandatory in the future, so this generated config
                  # replicates the default behaviour.
                  useDHCP = false;
                  interfaces.enp5s0.useDHCP = true;
                  interfaces.wlp4s0.useDHCP = true;
                  firewall.enable = true;

                  hostName = "Jayeshs-Thinkpad-E431"; # Define your hostname.
                  networkmanager.enable = true;
                  firewall.checkReversePath = "loose";
                  wireguard.enable = true;
                };
                services.mullvad-vpn.enable = true;

                time = {
                  timeZone = "Asia/Kolkata";
                  hardwareClockInLocalTime = false;
                };

                hardware.bluetooth = {
                  enable = true;
                  package = pkgs.bluezFull;
                };

                hardware.pulseaudio = {
                  enable = true;
                  package = pkgs.pulseaudioFull;
                };

                services = {
                  printing.enable = true;
                  openssh.enable = true;
                  sshd.enable = true;
                  xserver = {
                    enable = true;
                    videoDrivers = [ "modesetting" ];
                    useGlamor = true;
                    # Enable touchpad support (enabled default in most desktopManager).
                    libinput.enable = true;
                    layout = "us";
                    displayManager.gdm.enable = true;
                    desktopManager.gnome.enable = true;
                  };
                  gnome = {
                    core-os-services.enable = true;
                    core-shell.enable = true;
                    core-utilities.enable = false;
                    core-developer-tools.enable = false;
                    games.enable = false;
                    chrome-gnome-shell.enable = true;
                  };
                };

                sound.enable = true;

                # Define a user account. Don't forget to set a password with ‘passwd’.
                users.users.jayesh = {
                  isNormalUser = true;
                  extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
                };

                # This value determines the NixOS release from which the default
                # settings for stateful data, like file locations and database versions
                # on your system were taken. It‘s perfectly fine and recommended to leave
                # this value at the release version of the first install of this system.
                # Before changing this value read the documentation for this option
                # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
                system.stateVersion = "21.11"; # Did you read the comment?

                nix = {
                  package = pkgs.nixUnstable; # Using pkgs.nixFlakes throws some error during evaluation.
                  extraOptions = ''
                    experimental-features = nix-command flakes
                  '';
                };

                nixpkgs.config.allowUnfree = true;

                # List packages installed in system profile. To search, run:
                # $ nix search wget
                environment.systemPackages = with pkgs; [
                  git # system requirement because of flake
                  gnome.gnome-session
                  gnome.gnome-disk-utility
                  gnome.gnome-tweaks
                  gnome.dconf-editor
                  gnome.nautilus
                  gnome.gnome-screenshot
                  gnome.gnome-logs
                  gnome.gnome-system-monitor
                  gnome.gnome-characters
                  gnome.file-roller
                  gnome.gnome-terminal
                  gnome.gnome-weather
                  evince
                  gnome.gnome-color-manager
                  gnome.gnome-calculator
                  gnome.gnome-themes-extra
                  gnome.cheese
                  gnome.gnome-clocks
                  gnomeExtensions.gsconnect
                  gnomeExtensions.keyboard-modifiers-status
                  gnomeExtensions.overview-keyboard-navigation-fix
                  mullvad-vpn
                  gnomeExtensions.mullvad-indicator
                  home-manager
                  firefox
                  finger_bsd
                  xclip
                ];
              })
            ];
        };
      };

      homeConfigurations = {
        # Each configuration is unique to a combination of user, OS, machine.
        # eg., jayesh@MacMini2018 implies username=jayesh, OS=macOS (default OS), machine=MacMini2018, arch=x86_64-darwin
        # eg., jayesh@NixOSVM-MacMini2018 implies username=jayesh, OS=NixOS in VM, machine=MacMini2018, arch=x86_64-linux?
        # eg., jayesh@Jayesh-MacbookProM1? implies username=jayesh, OS=macOS, machine=Jayesh-MacbookProM1?, arch=aarch64-linux
        # eg., jayesh@NixOS-ThinkpadE431 implies username=jayesh, OS=NixOS, machine=ThinkpadE431, arch=x86_64-linux
        # eg., jayesh@FedoraVM-ThinkpadE431 implies username=jayesh, OS=Fedora on VM, machine=ThinkpadE431, arch=x86_64-linux
        "jayesh@Jayeshs-Mac-Mini-2018.local" = darwinChanHM.lib.homeManagerConfiguration rec {
          system = "x86_64-darwin";
          username = "jayesh";
          homeDirectory = "/Users/${username}";
          stateVersion = "21.11";
          configuration = {
            nixpkgs.config.allowUnfree = true;
            home.packages = (commonPkgs darwinChan system) ++ (darwinPkgs system);
          };
        };

        "jayesh@Jayeshs-Macbook-Pro-13-M1-2020.local" = darwinChanHM.lib.homeManagerConfiguration rec {
          system = "aarch64-darwin";
          username = "jayesh";
          homeDirectory = "/Users/${username}";
          stateVersion = "21.11";
          configuration = {
            nixpkgs.config.allowUnfree = true;
            home.packages = (commonPkgs darwinChan system) ++ (darwinPkgs system);
          };
        };

        "jayesh@Jayeshs-Thinkpad-E431" = nixosChanHM.lib.homeManagerConfiguration rec {
          system = "x86_64-linux";
          username = "jayesh";
          homeDirectory = "/home/${username}";
          stateVersion = "21.11";
          configuration = {
            nixpkgs.config.allowUnfree = true;
            home.packages = (commonPkgs nixosChan system) ++ (nixosPkgs system);
          };
        };
      };
    };
}
