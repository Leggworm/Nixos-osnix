{
  home-manager = {
    useGlobalPkgs = true;
    users.root = {
      imports = [
        ../home/aliases.nix
        ../home/neovim.nix
        ../home/pi.nix
      ];

      home.stateVersion = "26.05";

      programs.fish = {
        enable = true;
        interactiveShellInit = builtins.readFile ../home/original-shared/fish/config.fish;
      };
      home.file.".config/fish/functions/fish_prompt.fish".source = ../home/original-shared/fish/functions/fish_prompt.fish;
      home.file.".config/fish/functions/fish_print_git_action.fish".source = ../home/original-shared/fish/functions/fish_print_git_action.fish;
    };
  };
}
