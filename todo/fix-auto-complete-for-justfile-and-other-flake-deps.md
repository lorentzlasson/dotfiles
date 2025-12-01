# fix autocomplete for justfile and other flake deps

## problem

tools installed via nix flakes (like just) don't have shell completion available in zsh, even though the tools themselves are installed and functional

## investigation

1. check if just provides completion files
   - just likely ships with completion scripts for zsh
   - need to determine if nixpkgs makes these available

2. review how completion is currently configured
   - .zshrc:36-40 shows basic compinit setup
   - kubectl completion is handled via `source <(kubectl completion zsh)` (.zshrc:127-129)
   - need to understand where nix stores completion files

3. identify other tools that need completion
   - just (primary issue)
   - potentially other flake-installed tools that ship completions
   - check if tools in packages.nix have missing completions

## implementation plan

1. determine where nixpkgs stores zsh completions
   - check /nix/store paths for completion files
   - look for standard completion directories

2. configure zsh to source completions from nix
   - may need to set fpath before compinit
   - or explicitly source completion files after tool availability check

3. add just-specific completion
   - follow kubectl pattern if just supports dynamic completion
   - or add fpath configuration for static completions

4. verify other tools work
   - test completion for various installed tools
   - document pattern for future tool additions

## success criteria

- tab completion works for just commands in new shell sessions
- solution scales to other nix-installed tools
- no performance regression in shell startup
