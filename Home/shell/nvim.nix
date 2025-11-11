{
config,
pkgs,
lib,
self,
...
}: 
{
  options = {
    shell.nvim = {
      enable = lib.mkOption {
        description = "Enable Shell config for neovim config";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };
  config = lib.mkIf config.shell.nvim.enable {
    home = {
      sessionVariables = {
        EDITOR = "nvim";
      };
    };
    programs.nvf = {
            enable = true;
            settings ={

                    vim = {
                            theme = {
                                    enable = true;
                                    name = "gruvbox";
                                    style = "dark";
                            };
                            statusline.lualine.enable = true;
                            telescope.enable = true;
                            autocomplete.nvim-cmp.enable = true;
                            lsp.enable = true;
                            languages = {
                                    enableTreesitter = true;
                                    nix.enable = true;
                            };
                            options = {
                                    tabstop = 2;
                                    shiftwidth = 2;
                                    expandtab = true;
                            };
                    };
            };
    };
    };
  }
