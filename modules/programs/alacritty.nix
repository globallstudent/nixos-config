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
        opacity = 0.9;
        decorations = "Full";
        decorations_theme_variant = "Light";
        dynamic_title = true;
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
        size = 15.0;
      };
      
      # Nice dark theme with good contrast
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        normal = {
          black = "#45475a";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#bac2de";
        };
        bright = {
          black = "#585b70";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          blue = "#89b4fa";
          magenta = "#f5c2e7";
          cyan = "#94e2d5";
          white = "#a6adc8";
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
      shell = {
        program = "zsh";
        args = ["-l"];
      };
    };
  };
}
