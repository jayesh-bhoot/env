{
  description = "Nix configs";

  inputs = {
    repoNixosUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    hmRepoNixosUnstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "repoNixosUnstable";
    };

    repoNixos21-11.url = "github:NixOS/nixpkgs/nixos-21.11";

    repoNixpkgsUnstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    hmRepoNixpkgsUnstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "repoNixpkgsUnstable";
    };

    # NOTE1: MonoLisa is a private flake: https://github.com/NixOS/nix/issues/3991
    # NOTE2: nix by default assumes (or has hardcoded? Don't remember which one it is) master branch.
    repoMonolisa.url = "git+ssh://git@github.com/jayesh-bhoot/MonoLisa";
  };

  outputs = { self, repoNixosUnstable, hmRepoNixosUnstable, repoNixos21-11, repoNixpkgsUnstable, hmRepoNixpkgsUnstable, repoMonolisa }:
    let
      makePkgSet = repo: system:
        import repo {
          inherit system;
          config.allowUnfree = true;
        };

      serverTools = pkgs:
        [
          # specifically for a NixOS server. A minimal set which will overlap with cliTools.
        ];

      cliTools = pkgs:
        [
          pkgs.bashInteractive_5 # why not bash_5? bashInteractive_5 comes with readline support by default.
          pkgs.bash-completion
          pkgs.nix-bash-completions
          pkgs.direnv
          pkgs.nix-direnv

          pkgs.parallel
          pkgs.tree
          pkgs.htop

          pkgs.rsync
          pkgs.wget
          pkgs.curl
          pkgs.aria

          pkgs.fzf
          pkgs.jq

          pkgs.entr
          pkgs.devd

          pkgs.git
          pkgs.stow

          pkgs.vim
          pkgs.kakoune

          pkgs.nixpkgs-fmt
          pkgs.rnix-lsp
          pkgs.shellcheck
          pkgs.pass
          pkgs.bitwarden-cli
          pkgs.wireshark-cli
          pkgs.ffmpeg
          pkgs.imagemagickBig
          pkgs.mpv
          pkgs.youtube-dl
          pkgs.bc
        ];

      fonts = pkgs:
        [
          pkgs.fira
          pkgs.jetbrains-mono
          pkgs.cascadia-code
          pkgs.noto-fonts
          pkgs.noto-fonts-extra
        ];

      customFonts = system:
        [
          repoMonolisa.defaultPackage.${system}
        ];

      desktop = pkgs:
        [
          pkgs.gnome.gnome-tweaks
          pkgs.gnomeExtensions.appindicator
          pkgs.gnomeExtensions.gsconnect
          pkgs.gnomeExtensions.overview-keyboard-navigation-fix
          # pkgs.gnomeExtensions.keyboard-modifiers-status  # installed from website because the one in nixpkgs don't support GNOME 42
          pkgs.xsel
          pkgs.xclip
          pkgs.orca
          pkgs.libsForQt5.kmousetool
          pkgs.home-manager
        ];

      guiTools = pkgs:
        [
          pkgs.mullvad-vpn
          pkgs.gnomeExtensions.mullvad-indicator
          pkgs.firefox
          pkgs.chromium
          pkgs.transmission-gtk
          pkgs.teams
          pkgs.slack
          pkgs.vscode
          pkgs.jetbrains.webstorm
          pkgs.jetbrains.datagrip
          pkgs.jetbrains.idea-ultimate
          pkgs.upwork
          pkgs.whatsapp-for-linux
          pkgs.tdesktop
          pkgs.celluloid
          pkgs.resilio-sync
        ];

      darwinTools = pkgs:
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

      darwinRosettaTools = repo:
        # Those darwin pkgs which compile for x86-64, but don't compile for aarch64.
        let pkgs = makePkgSet repo "x86_64-darwin";
        in [ ];
    in
    {
      nixosConfigurations = {
        "Jayeshs-Dell-Precision-3460" = repoNixosUnstable.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              ({ config, lib, pkgs, modulesPath, options, specialArgs }: {
                imports =
                  [
                    (modulesPath + "/installer/scan/not-detected.nix")
                  ];

                boot.kernelPackages = pkgs.linuxPackages_latest;
                boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
                boot.initrd.kernelModules = [ "i915" ];
                boot.kernelModules = [ "kvm-intel" ];
                boot.extraModulePackages = [ ];

                fileSystems."/" =
                  {
                    device = "/dev/disk/by-uuid/b1dcaf95-1fae-4171-b232-5cfbdf2bdf76";
                    fsType = "ext4";
                  };

                fileSystems."/boot" =
                  {
                    device = "/dev/disk/by-uuid/D351-5B2B";
                    fsType = "vfat";
                  };

                swapDevices = [ ];

                powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
                hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
              })

              ({ config, lib, pkgs, modulesPath, options, specialArgs }:
                let
                  nixos21_11Pkgs = makePkgSet repoNixos21-11 "x86_64-linux";
                in
                {
                  # Use the systemd-boot EFI boot loader.
                  boot.loader.systemd-boot.enable = true;
                  boot.loader.systemd-boot.consoleMode = "2"; # Enable large fonts on EFI bootloader for HiDPI screen
                  boot.loader.efi.canTouchEfiVariables = true;

                  time.timeZone = "Asia/Kolkata";
                  time.hardwareClockInLocalTime = false;

                  nix.package = pkgs.nixUnstable; # Using pkgs.nixFlakes throws some error during evaluation.
                  nix.extraOptions = ''
                    experimental-features = nix-command flakes
                  '';
                  nixpkgs.config.allowUnfree = true;

                  i18n.defaultLocale = "en_US.UTF-8";

                  # Use large fonts so that text don't render tiny on HiDPI aka 4K monitor.
                  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
                  console.keyMap = "us";

                  hardware.bluetooth.enable = true;
                  # Use nixos21.11 until this PR lands: https://github.com/NixOS/nixpkgs/pull/170194
                  hardware.bluetooth.package = nixos21_11Pkgs.bluezFull;

                  sound.enable = false;
                  hardware.pulseaudio.enable = false;
                  # hardware.pulseaudio.package = pkgs.pulseaudioFull;
                  security.rtkit.enable = true;
                  services.pipewire = {
                    enable = true;
                    alsa.enable = true;
                    alsa.support32Bit = true;
                    pulse.enable = true;
                  };

                  networking.hostName = "Jayeshs-Dell-Precision-3460";
                  networking.networkmanager.enable = true;
                  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
                  # Per-interface useDHCP will be mandatory in the future, so this generated config
                  # replicates the default behaviour.
                  networking.useDHCP = false;
                  networking.interfaces.enp0s31f6.useDHCP = true;
                  networking.interfaces.wlp0s20f3.useDHCP = true;
                  networking.firewall.enable = true;
                  networking.firewall.checkReversePath = "loose";
                  networking.wireguard.enable = true;

                  services.openssh.enable = true;
                  services.sshd.enable = true;
                  services.mullvad-vpn.enable = true;
                  services.xserver.enable = true;
                  services.xserver.layout = "us";
                  services.xserver.videoDrivers = [ "modesetting" ];
                  services.xserver.useGlamor = true;

                  services.xserver.displayManager.gdm.enable = true;
                  services.xserver.displayManager.gdm.wayland = false;
                  services.xserver.desktopManager.gnome.enable = true;
                  services.gnome.core-developer-tools.enable = true;
                  programs.evolution.enable = true;
                  programs.evolution.plugins = [ pkgs.evolution-ews ];
                  environment.gnome.excludePackages = [
                    pkgs.gnome.geary
                  ];
                  services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

                  # services.xserver.displayManager.sddm.enable = true;
                  # services.xserver.desktopManager.plasma5.enable = true;

                  nixpkgs.config.firefox.enableGnomeExtensions = true;

                  users.users.jayesh = {
                    isNormalUser = true;
                    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
                  };

                  environment.systemPackages = desktop pkgs;

                  # This value determines the NixOS release from which the default
                  # settings for stateful data, like file locations and database versions
                  # on your system were taken. It‘s perfectly fine and recommended to leave
                  # this value at the release version of the first install of this system.
                  # Before changing this value read the documentation for this option
                  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
                  system.stateVersion = "21.11"; # Did you read the comment?
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

        "jayesh@Jayeshs-Mac-Mini-2018.local" = hmRepoNixpkgsUnstable.lib.homeManagerConfiguration rec {
          system = "x86_64-darwin";
          username = "jayesh";
          homeDirectory = "/Users/${username}";
          stateVersion = "21.11";
          configuration = {
            nixpkgs.config.allowUnfree = true;
            home.packages =
              (cliTools (makePkgSet repoNixpkgsUnstable system))
              ++ (darwinTools (makePkgSet repoNixpkgsUnstable system))
              ++ (darwinRosettaTools repoNixpkgsUnstable)
              ++ (fonts (makePkgSet repoNixpkgsUnstable system))
              ++ (customFonts system);
          };
        };

        "jayesh@Jayeshs-Macbook-Pro-13-M1-2020.local" = hmRepoNixpkgsUnstable.lib.homeManagerConfiguration rec {
          system = "aarch64-darwin";
          username = "jayesh";
          homeDirectory = "/Users/${username}";
          stateVersion = "21.11";
          configuration = {
            nixpkgs.config.allowUnfree = true;
            home.packages =
              (cliTools (makePkgSet repoNixpkgsUnstable system))
              ++ (darwinTools (makePkgSet repoNixpkgsUnstable system))
              ++ (darwinRosettaTools repoNixpkgsUnstable)
              ++ (fonts (makePkgSet repoNixpkgsUnstable system))
              ++ (customFonts system);
          };
        };

        "jayesh@Jayeshs-Dell-Precision-3460" = hmRepoNixosUnstable.lib.homeManagerConfiguration rec {
          system = "x86_64-linux";
          username = "jayesh";
          homeDirectory = "/home/${username}";
          stateVersion = "21.11";
          configuration = {
            nixpkgs.config.allowUnfree = true;
            home.packages =
              (cliTools (makePkgSet repoNixpkgsUnstable system))
              ++ (guiTools (makePkgSet repoNixosUnstable system))
              ++ (fonts (makePkgSet repoNixosUnstable system))
              ++ (customFonts system);
          };
        };
      };
    };
}
