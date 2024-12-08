{
  #xdg.configFile."kitty/kitty.conf" = ./kitty;
  programs.kitty = {
    enable = true;
    themeFile = "GruvboxMaterialDarkHard";
    #font = "Liberation Mono";
    settings = {
      font_family = "Liberation Mono";
      blod_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 8.0;
      background_opacity = 0.7;
      dynamic_background_opacity = "yes";
    };
  };
}
