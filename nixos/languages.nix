{ pkgs, ... }:

{
  # Tại đây khai báo các môi trường lập trình và LSP Server
  environment.systemPackages = with pkgs; [
    # --- C/C++ ---
    gcc
    clang
    gnumake
    # clang-tools # bao gồm clangd (LSP)

    # --- Node/Web ---
    nodejs
    nodePackages.typescript-language-server # LSP cho Typescript/Javascript
    nodePackages.vscode-langservers-extracted # Chứa LSP cho HTML, CSS, JSON, ESLint
    yarn-berry_3

    # --- Lua ---
    lua-language-server

    # --- Go (Golang) ---
    # --- Python ---
    python3
    pyright # LSP cho Python

    # --- Nix ---
    nil # LSP cho Nix

    # --- Shell/Bash ---
    shfmt # Formatter
    shellcheck # Linter
    bash-language-server # LSP cho Bash

    pkg-config
    ninja
    docker-compose
    lazydocker
    lazygit
    jdt-language-server
    google-java-format
    tree-sitter
  ];
}
