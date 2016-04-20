{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/virtualisation/amazon-image.nix> ];
  ec2.hvm = true;

  networking.firewall.allowedUDPPorts = [60001 60002 60003 60004 60005];
  networking.firewall.allowPing = true;

  system.autoUpgrade.channel = https://nixos.org/channels/nixos-15.09;

  i18n = {
    consoleFont="lat9w-16";
    consoleKeyMap="us";
    defaultLocale="en_US.UTF-8";
  };

  nix.trustedBinaryCaches = [
    "https://cache.nixos.org/"
    "http://hydra.nixos.org/"
    "http://hydra.cryp.to/"
  ];

  nix.binaryCaches = [
    "https://cache.nixos.org/"
    "http://hydra.nixos.org/"
    "http://hydra.cryp.to/"
  ];

  environment.systemPackages = with pkgs; [
    curl gitAndTools.gitFull gnugrep gzip less mosh parted psmisc tmux vim wget
    discount gnumake gnupg gnused gnutar graphviz jq mercurial screen
    silver-searcher w3m rlwrap
  ];

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  users.extraUsers.benjamin = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys =
      [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDs7c+tW9nfevShFfHyNWzsl/wXYKZh8UoXBOOyCoDLa8blwrLFmTOEOJY2hdX58YlLSJbYvponUMQOJoCUrlS1Sj3CH+MGR9e/XzS0+js4QtzTvof22qUB4wqyeCHD9XRDR1YHgOfiIeS6XyQFqMuTNh5/rKTPff5bjWpfcMRa+aGcLRcE9FYDYIjeqVOMWYL+oPTEr5c4I9MXoiJMZfOfz57pHHpsnBrQawSW1WV5xqOeFZFZiNyGHPyWTKrTjIgVC9bY0CYqiOM9wc6VJtuzz+BiyDlpPaHlBJNd6JvSsqkIBeb4etXyWeEpfNbd20LE68NDoqd0/AJWCioPG39P b@benjamins-air"
      ];
  };

  users.extraUsers.admin = {
    isNormalUser = true;
    uid = 1002;
    group = "users";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys =
      [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDs7c+tW9nfevShFfHyNWzsl/wXYKZh8UoXBOOyCoDLa8blwrLFmTOEOJY2hdX58YlLSJbYvponUMQOJoCUrlS1Sj3CH+MGR9e/XzS0+js4QtzTvof22qUB4wqyeCHD9XRDR1YHgOfiIeS6XyQFqMuTNh5/rKTPff5bjWpfcMRa+aGcLRcE9FYDYIjeqVOMWYL+oPTEr5c4I9MXoiJMZfOfz57pHHpsnBrQawSW1WV5xqOeFZFZiNyGHPyWTKrTjIgVC9bY0CYqiOM9wc6VJtuzz+BiyDlpPaHlBJNd6JvSsqkIBeb4etXyWeEpfNbd20LE68NDoqd0/AJWCioPG39P b@benjamins-air"
      ];
  };
}
