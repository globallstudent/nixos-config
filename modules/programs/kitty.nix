{...}: {
  programs.kitty = {
    enable = true;
    settings = {
      # Font configuration
      font_family = "Cascadia Code PL";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 13;

      # Background and transparency
      background_opacity = "0.85";
      background_blur = 20;  # This works better on Wayland
      dynamic_background_opacity = true;
      
      # Colors - Dark theme
      foreground = "#c9d1d9";
      background = "#0a0a0a";
      selection_foreground = "#000000";
      selection_background = "#fffacd";
      
      # Terminal bell
      enable_audio_bell = false;
      visual_bell_duration = "0.0";
      
      # Window layout
      remember_window_size = true;
      initial_window_width = 640;
      initial_window_height = 400;
      window_padding_width = 10;
      
      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      
      # Cursor
      cursor_shape = "block";
      cursor_blink_interval = 0;
      
      # Scrollback
      scrollback_lines = 10000;
      
      # Mouse
      mouse_hide_wait = 3;
      copy_on_select = true;
      
      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      
      # Shell
      shell = "zsh";
      
      # Window decorations for dark theme
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";
      hide_window_decorations = false;
    };
    
    # Color scheme
    extraConfig = ''
      # Nord-inspired dark color scheme
      color0  #2e3440
      color1  #bf616a
      color2  #a3be8c
      color3  #ebcb8b
      color4  #81a1c1
      color5  #b48ead
      color6  #88c0d0
      color7  #e5e9f0
      color8  #4c566a
      color9  #bf616a
      color10 #a3be8c
      color11 #ebcb8b
      color12 #81a1c1
      color13 #b48ead
      color14 #8fbcbb
      color15 #eceff4
      
      # Additional blur settings for Wayland
      background_image none
      background_image_layout tiled
      background_image_linear false
      background_tint 0.0
    '';
  };
}
