{lib, ...}: {
  home.file.".pi/agent/AGENTS.md".source = lib.mkDefault ./original-shared/pi/AGENTS.md;
  home.file.".pi/agent/extensions".source = lib.mkDefault ./original-shared/pi/extensions;
  home.file.".pi/agent/settings.json".source = lib.mkDefault ./original-shared/pi/settings.json;
  home.file.".pi/agent/models.json".source = lib.mkDefault ./original-shared/pi/models.json;
  home.file.".pi/agent/keybindings.json".source = lib.mkDefault ./original-shared/pi/keybindings.json;
}
