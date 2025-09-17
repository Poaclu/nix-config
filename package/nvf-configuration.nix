{ pkgs, lib, ...}:
{
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
    startPlugins = [pkgs.vimPlugins.gitsigns-nvim];
  };
  extraPlugins = {
    gitisigns-nvim = {
      package = pkgs.vimPlugins.gitsigns-nvim;
      setup = "require('gitsigns').setup({})";
    };
  };
 };
}
