{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        opacity = 0.85;  # Transparency works on both Wayland and X11
        decorations = "Full";
        decorations_theme_variant = "Dark";
        dynamic_title = true;
        # blur = true;  # Commented out - not supported on Wayland
        startup_mode = "Windowed";
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
      };
      
      font = {
        normal = {
          family = "Cascadia Code PL";
        };
        bold = {
          family = "Cascadia Code PL";
        };
        italic = {
          family = "Cascadia Code PL";
        };
        bold_italic = {
          family = "Cascadia Code PL";
        };
        size = 12.0;
      };
      
      # Dark theme with black/dark background
      colors = {
        primary = {
          background = "#0a0a0a";  # Very dark background for better transparency effect
          foreground = "#c9d1d9";  # Light gray text
        };
        normal = {
          black = "#484f58";
          red = "#ff7b72";
          green = "#7ee787";
          yellow = "#ffa657";
          blue = "#79c0ff";
          magenta = "#d2a8ff";
          cyan = "#a5f3fc";
          white = "#b1bac4";
        };
        bright = {
          black = "#6e7681";
          red = "#ffa198";
          green = "#56d364";
          yellow = "#ffdf5d";
          blue = "#79c0ff";
          magenta = "#d2a8ff";
          cyan = "#a5f3fc";
          white = "#f0f6fc";
        };
      };
      
      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };
      
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      
      selection = {
        save_to_clipboard = true;
      };
      
      mouse = {
        hide_when_typing = false;
      };
      
      # Use Zsh as the default shell
      terminal = {
        shell = {
          program = "zsh";
          args = ["-l"];
        };
      };
    };
  };
}
