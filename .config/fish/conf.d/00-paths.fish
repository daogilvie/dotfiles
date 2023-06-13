# Homebrew
if test -f /opt/homebrew/bin/brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
end

# Set gopath
set -g -x GOPATH ~/go

# Add Cargo to path
fish_add_path ~/.cargo/bin

# Add .local/bin to path (used by pipsi)
fish_add_path ~/.local/bin

# Add the icubin for paths
fish_add_path /usr/local/opt/icu4c/bin
fish_add_path /usr/local/opt/icu4c/sbin

# Add sbin
fish_add_path /usr/local/sbin

# Gcloud sdk
fish_add_path ~/.google-cloud-sdk/bin

# Rancher Desktop
fish_add_path ~/.rd/bin

# Hook in asdf if present
if test -d ~/.asdf
    source ~/.asdf/asdf.fish
    if ! test -L ~/.config/fish/completions/asdf.fish
        mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
    end
end

# Hook in zoxide if present
if command -sq zoxide
    zoxide init fish | source
end
