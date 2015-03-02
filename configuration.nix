{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";

  networking.hostId = "2bc28922";
  networking.firewall.allowedUDPPorts = [60001 60002 60003 60004 60005];
  networking.firewall.allowedTCPPorts = [3000 8080];

  networking.firewall.allowPing = true;

  i18n = {
    consoleFont="lat9w-16";
    consoleKeyMap="us";
    defaultLocale="en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    # Basics
    curl gitAndTools.gitFull gnugrep gzip less mosh psmisc tmux vim wget

    # General
    discount gnumake gnupg gnused gnutar graphviz jq mercurial screen
    silver-searcher w3m rlwrap

    # Heroku
    rubyLibs.heroku
    rubyLibs.heroku_api

    # Haskell
    haskellPackages.stylishHaskell
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.purescript
  ];

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";

  security.sudo.enable = true;

  users.extraUsers.ben = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys =
      [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDs7c+tW9nfevShFfHyNWzsl/wXYKZh8UoXBOOyCoDLa8blwrLFmTOEOJY2hdX58YlLSJbYvponUMQOJoCUrlS1Sj3CH+MGR9e/XzS0+js4QtzTvof22qUB4wqyeCHD9XRDR1YHgOfiIeS6XyQFqMuTNh5/rKTPff5bjWpfcMRa+aGcLRcE9FYDYIjeqVOMWYL+oPTEr5c4I9MXoiJMZfOfz57pHHpsnBrQawSW1WV5xqOeFZFZiNyGHPyWTKrTjIgVC9bY0CYqiOM9wc6VJtuzz+BiyDlpPaHlBJNd6JvSsqkIBeb4etXyWeEpfNbd20LE68NDoqd0/AJWCioPG39P b@benjamins-air" ];
  };

  users.extraUsers.james = {
    isNormalUser = true;
    uid = 1001;
    group = "users";
    openssh.authorizedKeys.keys =
      [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDs7c+tW9nfevShFfHyNWzsl/wXYKZh8UoXBOOyCoDLa8blwrLFmTOEOJY2hdX58YlLSJbYvponUMQOJoCUrlS1Sj3CH+MGR9e/XzS0+js4QtzTvof22qUB4wqyeCHD9XRDR1YHgOfiIeS6XyQFqMuTNh5/rKTPff5bjWpfcMRa+aGcLRcE9FYDYIjeqVOMWYL+oPTEr5c4I9MXoiJMZfOfz57pHHpsnBrQawSW1WV5xqOeFZFZiNyGHPyWTKrTjIgVC9bY0CYqiOM9wc6VJtuzz+BiyDlpPaHlBJNd6JvSsqkIBeb4etXyWeEpfNbd20LE68NDoqd0/AJWCioPG39P b@benjamins-air"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDu9wbijGThrxTNOP/7atYLg3l42bQTDrVdvjtIgJ4txV/X1OiZ0ju/JM8gv/X7JQcrC2d7cRVzGq7tIEoX3gDulMe/mW2WVPF3fgJV0Z/BHstAhFgi3Mc4nE1UzdnGl6CtZt/LVPqv5lRxarOi+iyceCDCV1EyV7cdl4Y7BMH9ozHiN4Y0bN32HjlMTKWY1BWnjlIefYmX3kI4R6Q2BcEec3NmSzPKP/dVYyOIaU9h/5nwqQTU39M7BO68lY7V1HXYRLpyxJvyGSiqNgF46MbYTBR9QQnm6SzHTrvbzB0HL5TR0O9F5Uh0xb3DQJqw7zgt6Ivwqev7NuYH4qiB/PHF josborn8@mcdigr-dev"
      ];
  };
}
