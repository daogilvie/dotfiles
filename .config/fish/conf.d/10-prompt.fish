# Disable virtualenv's default ugly prompt.
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

if status --is-interactive
    # Activate starship prompt
    if command -sq starship
        starship init fish | source
    end
end
