{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
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
  config = lib.mkIf config.user.enable {
    users.users.${config.user.username} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialHashedPassword = "$y$j9T$DiwYx30Ij0FYJ/wZPwics0$v2xSCXofFQNwCNPydviUj0598fCnZCRs/TBtV.Uid/8";
      extraGroups = [
        "wheel"
        "networkmanager"
        "mlocate"
      ];
    };
  };
}
