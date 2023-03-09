{ config, lib, pkgs, user, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "jdsee";
    userEmail = "jdsee@protonmail.com";
    aliases = {
      last = "log - 1 - -stat";
      aa = "add - -all";
      cp = "cherry-pick";
      co = "checkout";
      cl = "clone";
      ci = "commit";
      s = "status";
      br = "branch";
      unstage = "reset HEAD - -";
      dc = "diff --cached";
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      res = "!git fetch && git reset origin/`git rev-parse --abbrev-ref HEAD` --hard";
      lh = "!git log --oneline | head";
      graph = ''log --graph --color --pretty=format:"%C (yellow)%H%C (green)%d%C (reset)%n%x20%cd%n%x20%cn%x20 (%ce)%n%x20%s%n "'';
      tags = "tag - l"; # Show verbose output about tags, branches or remotes;
      branches = "branch - a";
      remotes = "remote - v";
      amend = "commit --amend --reuse-message=HEAD"; # Amend the currently staged files to the latest commit;
      contributors = "shortlog --summary --numbered"; # List contributors with number of commits;
      alias = "!git config - l | grep ^alias | cut - c 7 - | sort";
    };
    extraConfig = {
      core.editor = "nvim";
      color.ui = true;
      init.defaultBranch = "main";
      pull = {
        ff = "only";
        rebase = true;
      };
      help = {
        autocorrect = true;
      };
    };
    ignores = [
      ".DS_Store"
      "*.pyc"
    ];

    difftastic = {
      enable = true;
      display = "side-by-side"; # one of "side-by-side", "side-by-side-show-both", "inline"
    };

    diff-so-fancy = {
      enable = false;
    };

    delta = {
      enable = false;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "DarkNeon";
      };
    };
  };

  programs.gitui = {
    enable = true;
    keyConfig = builtins.readFile ./gitui_vim_keys.ron;
    theme = builtins.readFile ./gitui_theme.ron;
  };
}



