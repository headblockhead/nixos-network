{ config, pkgs, ... }:

with import <nixpkgs> { };
let
  vim-purpura = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-purpura";
    version = "2398344cb16af941a9057e6b0cf4247ce1abb5de";

    src = fetchFromGitHub {
      owner = "yassinebridi";
      repo = "vim-purpura";
      rev = "2398344cb16af941a9057e6b0cf4247ce1abb5de";
      sha256 = "KhacybPPzplSs6oyJtKSkgQ3JFxOjLSqvueafkYRPSw=";
    };
  };
  lspSignatureNvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "lsp_signature.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ray-x";
      repo = "lsp_signature.nvim";
      rev = "f7c308e99697317ea572c6d6bafe6d4be91ee164";
      sha256 = "0s48bamqwhixlzlyn431z7k3bhp0y2mx16d36g66c9ccgrs5ifmm";
    };
  };
  cocnvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "coc.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "neoclide";
      repo = "coc.nvim";
      rev = "v0.0.82";
      sha256 = "TIkx/Sp9jnRd+3jokab91S5Mb3JV8yyz3wy7+UAd0A0=";
    };
  };
  my-python-packages = python-packages: with python-packages; [
    pandas
    requests
    pyautogui
  ]; 
  python-with-pyautogui = python3.withPackages my-python-packages;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "headb";
  home.homeDirectory = "/home/headb";

  # Allow ObinsKit to use outdated software.
  nixpkgs.config.permittedInsecurePackages = [
    "electron-13.6.9"
  ];

  # Packages for this user.
  home.packages = [
    python-with-pyautogui # Defined above
#    pkgs.chromium # Needed to manage chrome extensions - normal chrome does not allow extention control.
#    pkgs.zoom-us # Plague
#    pkgs.vscodium # Non-proprietary version of vscode
#    pkgs.gnomeExtensions.dash-to-panel # Extention to pretend you want a taskbar
    pkgs.nixfmt
    pkgs.ngrok
    pkgs.awscli2
    pkgs.musescore
    pkgs.obs-studio # Streaming and recording software
    pkgs.asciinema # Terminal recorder
    pkgs.onedrive # Cloud storage from school
    pkgs.google-chrome # Web Browser
    pkgs.minecraft # Block Game
    pkgs.cura # 3D Printing Slicer
    pkgs.unityhub # Game-making tool - Launcher for Unity
    pkgs.neofetch # System show-off tool
    pkgs.cmatrix # Pretend you are in The Matrix
    pkgs.gopass # Password manager
    pkgs.gh # GitHub command-line tool
    pkgs.go # Go programming language compiler
    pkgs.vscode # Code editor
    pkgs.gnome.gnome-terminal # Customisable terminal - not in the default installation of gnome
    pkgs.p7zip # 7zip compression and extraction tool.
    pkgs.deja-dup # Backup software
    pkgs.vlc # Video and audio player
    pkgs.tinygo # Go programming language complier but for small places
    pkgs.gnumake # Runs Makefiles
    pkgs.nodejs # Javascript stuff
    pkgs.oh-my-zsh # ZSH customiser
    pkgs.gopls # Go programming language formatting tools
    pkgs.nodePackages.prettier # Code tidier
    pkgs.nixpkgs-fmt # Nix formatting tools
    pkgs.kdenlive # Video editing software
    pkgs.gimp # Image editing software
    pkgs.spotify # Desktop music player
    pkgs.thunderbird # Email client
    pkgs.libreoffice # Microsoft Office alternative for Linux
    pkgs.hugo # Website builder written in Go
    pkgs.obinskit # Anne Pro keyboard configurer - has to be run with 'sudo $(which obinskit) --no-sandbox' to interface with keyboard.
  ];

  # Configure installed packages
  # https://github.com/nix-community/home-manager/tree/master/modules/programs
  programs.git = {
    enable = true;
    userName = "headblockhead";
    userEmail = "headblockhead@gmail.com";
    signing = {
      key = "7B485B936DB40FD57939E2A8A5D1F48A8CDD4F44";
      gpgPath = "/run/current-system/sw/bin/gpg2";
      signByDefault = true;
    };
    extraConfig = {
      pull.rebase = false;
    };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-airline-themes
      vim-fugitive
      vim-prettier
      vim-purpura # theme defined from github
      vim-lastplace
      vim-nix
      vim-go
      cocnvim # plugin defined from github
    ];
    extraConfig = ''
      " Dont try to be compatible with vi - be iMproved
      set nocompatible
      " Dont check filetype
      filetype off
      " Theming - for the looks only.
      colorscheme purpura
      set background=dark
      set termguicolors
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      let g:netrw_banner = 0
      let g:netrw_liststyle = 3
      let g:airline_theme='purpura'
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#formatter = 'unique_tail'
      hi Normal guibg=NONE ctermbg=NONE
      hi LineNr ctermbg=NONE guibg=NONE guifg=NONE 
      hi EndOfBuffer ctermbg=NONE guibg=NONE
      hi SignColumn  ctermbg=NONE guibg=NONE
      " Claim space in the column for when there are errors in the future
      set signcolumn=yes
      " Disable mouse input reading.
      set mouse=
      " Add line numbers.
      set nu
      " Syntax highlighting.
      syntax enable
      " Don't spill gopass secrets.
      au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
      " Set an easier to reach leader.
      let mapleader = ","
      " Change how vim represents characters on the screen.
      set encoding=utf-8
      set fileencoding=utf-8
      " Use leader + f to format the document.
      xmap <leader>f  <Plug>(coc-format)
      nmap <leader>f  <Plug>(coc-format)
    '';
  };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "aws" "git" ];
    };
    initExtra = ''
      source ~/custom.zsh-theme;
      export PATH="$GOBIN:$PATH";
      export NIXPKGS_ALLOW_UNFREE=1;
    '';
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "IT3wpfw8zhiNQsrw59lbSWYh0NQ1CUdUtFzRzHlURH0=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "IT3wpfw8zhiNQsrw59lbSWYh0NQ1CUdUtFzRzHlURH0=";
        };
      }
    ];
    localVariables = {
      EDITOR = "nvim";
      GOPATH = "/home/$USER/go";
      GOBIN = "/home/$USER/go/bin";
    };
    shellAliases = {
      q = "exit";
      p = "gopass show -c -n";
      obinskit = "pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY ~/.nix-profile/bin/obinskit --no-sandbox"; # ObinsKit has to be run without sandbox to interface with keyboard.
      ns = "nix-shell -p";
      #code = "codium";
    };
  };
  programs.vscode = {
    enable = true;
    #    package = pkgs.vscodium;
    userSettings = {
      "git.enableCommitSigning" = true;
      "editor.cursorSmoothCaretAnimation" = true;
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "files.eol" = "\n";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.productIconTheme" = "material-product-icons";
      "editor.formatOnSave" = true;
      "terminal.integrated.fontFamily" = "fontawesome";
      "terminal.integrated.fontSize" = 16;
      "editor.formatOnPaste" = true;
      "terminal.integrated.allowChords" = false;
      "terminal.integrated.altClickMovesCursor" = false;
      "terminal.integrated.drawBoldTextInBrightColors" = false;
      "workbench.colorTheme" = "Shades of Purple";
      "editor.inlineSuggest.enabled" = true;
      "security.workspace.trust.enabled" = true;
      "security.workspace.trust.untrustedFiles" = "open";
    "playdate.source" = "source";
    "playdate.output" = "builds/out.pdx";
    "Lua.runtime.version" = "Lua 5.4";
    "Lua.diagnostics.globals"= [ "playdate" "import" ];
    "Lua.diagnostics.disable" = [ "undefined-global" "lowercase-global" ];
    "Lua.runtime.nonstandardSymbol" = [ "+=" "-=" "*=" "/=" ];
    "Lua.workspace.library" = ["/home/headb/playdate_sdk-1.12.3/CoreLibs"];
    "Lua.workspace.preloadFileSize" = 1000;
    "platformio-ide.useBuiltinPIOCore" = false;
    "github.copilot.enable" = {"*" = true;"yaml" = false;"plaintext" = true;"markdown" = true;};
    };
    # https://marketplace.visualstudio.com/vscode
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "platformio-ide";
        publisher = "platformio";
        version = "2.5.4";
        sha256 = "KbXlegQSLjMCVotR1mU/CDiaQMKLLSX+nnbRJgdFTz8=";
      }
      {
        name = "lua";
        publisher = "sumneko";
        version = "3.5.6";
        sha256 = "ZJsuYe74lsF1gcqyKCFqD+KlcX3tNgWu6tGOJfq4H6c=";
      }
      {
        name = "lua-plus";
        publisher = "jep-a";
        version = "1.1.1";
        sha256 = "wuZaVYemm05AFIJyBqhKEJxiwkeYHHuQN8+ARqq35OE=";
      }

#      {
#        name = "vim";
#        publisher = "vscodevim";
#        version = "1.23.2";
#        sha256 = "QC+5FJYjWsEaao1ifgMTJyg7vZ5JUbNNJiV+OuiIaM0=";
#      }
      {
        name = "copilot";
        publisher = "GitHub";
        version = "1.43.6621";
        sha256 = "JrD0t8wSvz8Z1j6n0wfkG6pfIjt2DNZmfAbaLdj8olQ=";
      }
      {
        name = "shades-of-purple";
        publisher = "ahmadawais";
        version = "6.13.0";
        sha256 = "DcrLeI7k1ZDX9idL8J5nk2OvtT3gW2t067nkAe9EeQY=";
      }
      {
        name = "material-icon-theme";
        publisher = "PKief";
        version = "4.20.0";
        sha256 = "OfFN//lnRPouREucEJKpKfXcyCN/nnZtH5oD23B4YX0=";
      }
      {
        name = "material-product-icons";
        publisher = "PKief";
        version = "1.4.0";
        sha256 = "cPH6IgQePfhfVpiEXusAXmNo2+owZW1k+5poJyxlbz8=";
      }
      {
        name = "Go";
        publisher = "golang";
        version = "0.35.2";
        sha256 = "YQPKB6dtIwmghw1VnYu+9krVICV2gm7Vq1FRq7lJbto=";
      }
      {
        name = "vscode-docker";
        publisher = "ms-azuretools";
        version = "1.22.1";
        sha256 = "okR1mmwg1ZEUfP924LTa98LxCenwDZ1BIS/FLt0wo8c=";
      }
      {
        name = "python";
        publisher = "ms-python";
        version = "2022.15.12451011";
        sha256 = "zO7L2we37bbn5i/vVhNoxUgMeY5WaPVS895wK8UbT2Q=";
      }
      {
        name = "cpptools";
        publisher = "ms-vscode";
        version = "1.13.2";
        sha256 = "c45grknJPcIICYhDWH+dwr1XsCsshxTJFGHYZPHrCQs=";
      }
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "2022.8.3105";
        sha256 = "3MyPCTZGD6axHvMd8yi9JWjviMdflbF7WhBIA2JXXYU=";
      }
      {
        name = "remote-containers";
        publisher = "ms-vscode-remote";
        version = "0.252.0";
        sha256 = "pXd2IjbRwYgUAGVIMLE9mQwR8mG/x0MoMfK8zVh3Mvs=";
      }
      {
        name = "auto-rename-tag";
        publisher = "formulahendry";
        version = "0.1.10";
        sha256 = "uXqWebxnDwaUVLFG6MUh4bZ7jw5d2rTHRm5NoR2n0Vs=";
      }
      {
        name = "vsliveshare";
        publisher = "MS-vsliveshare";
        version = "1.0.5705";
        sha256 = "4Tv97WqrFSk7Mtcq6vF0NnsggVj9HPKFV+GKgX15ogM=";
      }
      {
        name = "path-intellisense";
        publisher = "christian-kohler";
        version = "2.8.1";
        sha256 = "lTKzMphkGgOG2XWqz3TW2G9sISBc/kG7oXqcIH8l+Mg=";
      }
      {
        name = "indent-rainbow";
        publisher = "oderwat";
        version = "8.3.1";
        sha256 = "dOicya0B2sriTcDSdCyhtp0Mcx5b6TUaFKVb0YU3jUc=";
      }
      {
        name = "vscode-todo-highlight";
        publisher = "wayou";
        version = "1.0.5";
        sha256 = "CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
      }
      {
        name = "rainbow-brackets";
        publisher = "2gua";
        version = "0.0.6";
        sha256 = "TVBvF/5KQVvWX1uHwZDlmvwGjOO5/lXbgVzB26U8rNQ=";
      }
      {
        name = "nix-ide";
        publisher = "jnoortheen";
        version = "0.1.23";
        sha256 = "64gwwajfgniVzJqgVLK9b8PfkNG5mk1W+qewKL7Dv0Q=";
      }
    ];
  };
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "fpnmgdkabkmnadcjpehmlllkndpkmiak" # wayback archiver
      "mefhakmgclhhfbdadeojlkbllmecialg" # cat new tab page
      "ljeonhoonibcofjepiphcekbihoiaife" # shades of purple theme
      "mnjggcdmjocbbbhaepdhchncahnbgone" # youtube sponsor block
      "amaaokahonnfjjemodnpmeenfpnnbkco" # codegrepper
    ];
  };
  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    themeVariant = "dark";
    profile.nix = {
      default = true;
      visibleName = "Nix Custom";
      cursorBlinkMode = "on";
      cursorShape = "ibeam";
      font = null;
      allowBold = true;
      scrollOnOutput = true;
      showScrollbar = false;
      scrollbackLines = 10000;
      customCommand = null;
      loginShell = false;
      backspaceBinding = "ascii-delete";
      boldIsBright = false;
      deleteBinding = "delete-sequence";
      audibleBell = false;
      transparencyPercent = 80;
    };
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
