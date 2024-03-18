{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "psiayn";
  home.homeDirectory = "/home/psiayn";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  nixpkgs.config.allowUnfreePredicate = _: true;
  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    discord
    neofetch
    neovim
    htop
    ripgrep
    xclip
    wl-clipboard
    tmux
    git
    starship
    bat
    clang
    unzip
    emacs
    direnv
    lorri
    python3
    rnix-lsp
    vscode
    file
    godot_4
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/psiayn/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    VISUAL = "emacsclient -c";
    TERM = "xterm-direct";
  };

  programs.git = {
    enable = true;
    userName = "Pranav Kesavarapu";
    userEmail = "pranavkesavarapu@gmail.com";
    extraConfig.diff.tool = "nvimdiff";
  };
  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(starship init bash)"
      eval "$(direnv hook bash)"
    '';
    shellAliases = {
      hm = "home-manager";
      hms = "home-manager switch";
      hmsb = "home-manager switch -b backup";
      ehmc = "emacsclient -c ~/.config/home-manager/home.nix";
      # git aliases
      g = "git config";
      gst = "git status";
      gc = "git commit";
      gcl = "git clone";
      ga = "git add";
      gp = "git push";
      gl = "git pull";
      glo = "git log";
      gsw = "git switch";
      gb = "git branch";
      gswc = "git switch -c";
      gd = "git diff";
      gwt = "git worktree";
      gwta = "git worktree add";
      # docker
      d = "docker";
      db = "docker build";
      # docker compose
      dc = "docker-compose";
      dcu = "docker-compose up";
      dcd = "docker-compose down";
      dcb = "docker-compose build";
      # normal shell utils
      cat = "bat";
      ls = "ls --color=auto";
      em = "emacsclient -t";
      tmux = "tmux -u";
    };
  };
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
