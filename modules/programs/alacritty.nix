{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "screen-256color";
      };
      
      general = {
        live_config_reload = true;
      };
      
      window = {
        padding = {
          x = 2;
          y = 2;
        };
        decorations = "full";
        opacity = 1.0;
        dimensions = {
          columns = 0;
          lines = 0;
        };
        dynamic_title = true;
      };
      
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      
      font = {
        normal = {
          family = "Fira Code";
          style = "Retina";
        };
        bold = {
          family = "Fira Code";
          style = "Bold";
        };
        italic = {
          family = "Fira Code";
        };
        size = 8.0;
      };
      
      draw_bold_text_with_bright_colors = true;
      
      # Base16 Default Dark 256 color scheme
      colors = {
        primary = {
          background = "0x181818";
          foreground = "0xd8d8d8";
        };
        cursor = {
          text = "0x181818";
          cursor = "0xd8d8d8";
        };
        normal = {
          black = "0x181818";
          red = "0xab4642";
          green = "0xa1b56c";
          yellow = "0xf7ca88";
          blue = "0x7cafc2";
          magenta = "0xba8baf";
          cyan = "0x86c1b9";
          white = "0xd8d8d8";
        };
        bright = {
          black = "0x585858";
          red = "0xab4642";
          green = "0xa1b56c";
          yellow = "0xf7ca88";
          blue = "0x7cafc2";
          magenta = "0xba8baf";
          cyan = "0x86c1b9";
          white = "0xd8d8d8";
        };
      };
      
      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };
        unfocused_hollow = true;
      };
      
      bell = {
        animation = "EaseOutExpo";
        duration = 0;
      };
      
      mouse = {
        double_click = { threshold = 300; };
        triple_click = { threshold = 300; };
        faux_scrolling_lines = 1;
        hide_when_typing = true;
        bindings = [
          { mouse = "Middle"; action = "PasteSelection"; }
        ];
      };
      
      selection = {
        semantic_escape_chars = ",?`|:\"' ()[]{}<>";
        save_to_clipboard = true;
      };
      
      debug = {
        render_timer = false;
      };
      
      shell = {
        program = "/run/current-system/sw/bin/zsh";
        args = ["--login"];
      };
    };
  };
}
