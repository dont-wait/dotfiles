{ pkgs, ... }:

{
  # Tại đây khai báo các môi trường lập trình và LSP Server
  environment.systemPackages = with pkgs; [
    # --- C/C++ ---
    gcc
    clang
    # clang-tools # bao gồm clangd (LSP)

    # --- Node/Web ---
    nodejs
    nodePackages.typescript-language-server # LSP cho Typescript/Javascript
    nodePackages.vscode-langservers-extracted # Chứa LSP cho HTML, CSS, JSON, ESLint

    # --- Lua ---
    lua-language-server

    # --- Go (Golang) ---
    go
    gopls # LSP chính chủ cho Go

    # --- Python ---
    python3
    pyright # LSP cho Python

    # --- Nix ---
    nil # LSP cho Nix

    # --- Shell/Bash ---
    shfmt # Formatter
    shellcheck # Linter
    bash-language-server # LSP cho Bash
  ];
}
