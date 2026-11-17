{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./aliases.nix
    ./default-apps.nix
    ./firefox.nix
    ./neovim.nix
    ./pi.nix
  ];

  home = {
    username = "leggrowm";
    homeDirectory = "/home/leggrowm";
    stateVersion = "26.05";

    file.".config/fish/functions/fish_prompt.fish".source = ./original-shared/fish/functions/fish_prompt.fish;
    file.".config/fish/functions/fish_print_git_action.fish".source = ./original-shared/fish/functions/fish_print_git_action.fish;

    file.".config/git/config".source = ./original-shared/git/config;
    file.".config/git/ignore".source = ./original-shared/git/ignore;
    file.".config/git/user".text = ''
      [user]
        email = idi0807@mail.ru
        name = leggrowm
    '';

    file.".config/hypr/hypridle.conf".source = ./leggrowm-mini/hypr/hypridle.conf;
    file.".config/hypr/hyprland.conf".source = ./leggrowm-mini/hypr/hyprland.conf;
    file.".config/waybar/config-top".source = ./leggrowm-mini/waybar/waybar-top.json;
    file.".config/waybar/config-bottom".source = ./leggrowm-mini/waybar/waybar-bottom.json;
    file.".config/waybar/style.css".source = ./leggrowm-mini/waybar/waybar.css;
    file.".config/alacritty/alacritty.toml".source = ./leggrowm-mini/alacritty/alacritty.toml;

    file.".config/nixpkgs/config.nix".text = ''
      { allowUnfree = true; }
    '';

    file.".config/rofi/grey.rasi".source = ./original-shared/rofi/grey.rasi;
    file.".config/rofi/config.rasi".source = lib.mkDefault ./original-shared/rofi/config.rasi;
    file.".config/rofimoji.rc".source = lib.mkDefault ./original-shared/rofi/rofimoji.rc;

    file.".config/imv/config".source = lib.mkDefault ./original-shared/imv/config;
    file.".config/mpv/mpv.conf".source = lib.mkDefault ./original-shared/mpv/mpv.conf;
    file.".config/mpv/input.conf".source = ./original-shared/mpv/input.conf;
    file.".config/mpv/scripts/autoload.lua".source = ./original-shared/mpv/scripts/autoload.lua;
    file.".config/mpv/scripts/delete_file.lua".source = ./original-shared/mpv/scripts/delete_file.lua;

    file.".npmrc".source = ./original-shared/.npmrc;
    file.".config/swayimg/init.lua".source = ./original-shared/nvim/init.lua;
    file.".iex.exs".source = ./original-shared/.iex.exs;

    file.".local/share/nemo/actions/aunpack.nemo_action".text = ''
      [Nemo Action]
      Name=Extract here
      Comment=Extract the selected archive(s) using aunpack
      Exec=aunpack -X %P %F
      Icon=package-x-generic
      Selection=Any
      Extensions=zip;tar;gz;bz2;7z;rar;
      Quote=double
    '';

    file.".config/zellij/config.kdl".text = ''
      theme "gruvbox-dark"
      show_startup_tips false
      show_release_notes false
    '';

    file.".config/tealdeer/config.toml".text = ''
      [updates]
      auto_update = true
    '';

    file.".config/opencode/opencode.jsonc".source = lib.mkDefault ./original-shared/opencode.jsonc;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ./original-shared/fish/config.fish;
  };

  programs.browserpass.enable = true;

  services.mako = {
    enable = true;
    settings = {
      font = "CaskaydiaMono Nerd Font 15";
      default-timeout = 4000;
      background-color = "#16161E";
      text-color = "#d0d0d0";
      border-color = "#3a3a45";
      border-size = 1;
      padding = "4";
      outer-margin = "4";
      border-radius = 4;
      anchor = "bottom-center";
      text-alignment = "center";
      max-visible = 1;
      max-history = 1;
    };
  };

  home.pointerCursor = {
    enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    gtk.enable = true;
    name = lib.mkDefault "Posy_Cursor";
    package = lib.mkDefault pkgs.posy-cursors;
    size = lib.mkDefault 32;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    font = {
      name = "CaskaydiaMono Nerd Font";
      size = 15;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.configFile."wpaperd/config.toml".text = lib.mkDefault ''
    [default]
    path = "~/wallpapers"
    duration = "24h"
    mode = "center"
    sorting = "random"
  '';
  xdg.configFile."sunsetr/sunsetr.toml".text = lib.mkDefault ''
    transition_mode = "finish_by"
    sunrise = "07:00:00"
    sunset = "19:00:00"
    transition_duration = 60

    night_temp = 3500
    day_temp = 6500
    night_gamma = 100
    day_gamma = 100
    update_interval = 60
  '';
}
