{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      
      general = {
        live_config_reload = true;
      };
      
      window = {
        padding = {
          x = 8;
          y = 8;
        };
        decorations = "none";
        startup_mode = "Maximized";
        opacity = 0.98;
        dynamic_title = true;
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
      };
      
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
        size = 11;
        offset = {
          x = 0;
          y = 1;
        };
      };
      
      # Dark black background with standard colors
      colors = {
        primary = {
          background = "#000000";  # Pure black background
          foreground = "#ffffff";  # White text
        };
        normal = {
          black = "#000000";
          red = "#ff0000";
          green = "#00ff00";
          yellow = "#ffff00";
          blue = "#0000ff";
          magenta = "#ff00ff";
          cyan = "#00ffff";
          white = "#ffffff";
        };
        bright = {
          black = "#808080";
          red = "#ff8080";
          green = "#80ff80";
          yellow = "#ffff80";
          blue = "#8080ff";
          magenta = "#ff80ff";
          cyan = "#80ffff";
          white = "#ffffff";
        };
      };
      
      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };
        thickness = 0.15;
      };
      
      keyboard = {
        bindings = [
          { key = "V"; mods = "Control|Shift"; action = "Paste"; }
          { key = "C"; mods = "Control|Shift"; action = "Copy"; }
          { key = "Insert"; mods = "Shift"; action = "PasteSelection"; }
          { key = "Key0"; mods = "Control"; action = "ResetFontSize"; }
          { key = "Equals"; mods = "Control"; action = "IncreaseFontSize"; }
          { key = "Plus"; mods = "Control"; action = "IncreaseFontSize"; }
          { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
          { key = "F11"; mods = "None"; action = "ToggleFullscreen"; }
        ];
      };
      
      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
        save_to_clipboard = true;
      };
    };
  };
}
