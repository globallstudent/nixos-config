{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "simple";
      plugins = [
        "git"
        "docker"
        "kubectl"
        "npm"
        "python"
        "rust"
        "golang"
      ];
    };
    initContent = ''
      # Custom ZSH configurations
      setopt AUTO_CD              # Auto changes to a directory without typing cd
      setopt AUTO_PUSHD          # Push the old directory onto the stack on cd
      setopt PUSHD_IGNORE_DUPS   # Do not store duplicates in the stack
      setopt PUSHD_SILENT        # Do not print the directory stack after pushd or popd
      
      # History configurations
      HISTFILE="$HOME/.zsh_history"
      HISTSIZE=10000
      SAVEHIST=10000
      setopt HIST_IGNORE_ALL_DUPS  # Delete old recorded entry if new entry is a duplicate
      setopt HIST_FIND_NO_DUPS     # Don't display a line previously found
      setopt HIST_IGNORE_SPACE     # Don't record an entry starting with a space
      setopt HIST_SAVE_NO_DUPS     # Don't write duplicate entries in the history file
      
      # Better directory navigation
      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      
      # Better ls with exa
      alias ls='eza --icons'
      alias ll='eza -l --icons'
      alias la='eza -la --icons'
      alias lt='eza --tree --icons'
      
      # Git aliases
      alias g='git'
      alias gs='git status'
      alias ga='git add'
      alias gc='git commit'
      alias gp='git push'
      alias gl='git pull'
      
      # Development shortcuts
      alias py='python'
      alias pip='pip3'
      alias n='nvim'
      
      # System aliases
      alias sys='systemctl'
      alias sysu='systemctl --user'
      alias hm='home-manager'
      
      # Set a simple prompt without fancy characters
      PROMPT='%F{blue}%n@%m%f:%F{green}%~%f$ '
    '';
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake .#";
      upgrade = "nix flake update && sudo nixos-rebuild switch --flake .#";
      hms = "home-manager switch --flake .#yunus";
      clean = "sudo nix-collect-garbage -d";
      config = "cd ~/nixos-config";
    };
  };
}
