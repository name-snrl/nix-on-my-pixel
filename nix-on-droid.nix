{ pkgs, ... }:

{
  environment.packages = with pkgs; [
      # base
      nvim.full
      neovim
      htop
      tmux
      page
      #page-as-less
      difftastic
      gojq-as-jq
      ripgrep
      fd
      exa
      bat
      file
      tree
      wget
      scripts.sf

      # cli
      et
      fzf
      ffmpeg
      zoxide
      tokei
      tealdeer
      librespeed-cli
  ];

  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "22.11";
}
