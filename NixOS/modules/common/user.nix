{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.poaclu = {
    user = {
      enable = lib.mkOption {
        description = "Enable user";
        type = lib.types.bool;
        default = true;
        example = false;
      };
      username = lib.mkOption {
        description = "Name of the user";
        type = lib.types.str;
        default = "poaclu";
      };
      #groups = {
      #  type = lib.types.listOf lib.types.str;
      #default = [ "wheel" "networkmanager" "mlocate" ];
      #description = "Groups the user belongs to.";
      #};
    };
  };
  config = lib.mkIf config.poaclu.user.enable {
    users= {
      mutableUsers = false; #All users password are reset at boot
      users.${config.poaclu.user.username} = {
        isNormalUser = true;
        shell = pkgs.zsh;
        hashedPasswordFile = config.age.secrets.poaclu.path;
        extraGroups = [
          "wheel"
          "networkmanager"
          "mlocate"
          "vboxusers"
        ];
      };
    };
  };
}
