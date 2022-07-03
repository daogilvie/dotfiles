# If a login shell, we might need to check agents
# Adapted the setup from fish-ssh-agent package and various
# other sources. Checks if the agents are running because
# adding keys from the keychain takes a couple of seconds
# and simply isn't needed more than once per run of the agent.
if status --is-login

    # GPG Agent. If present we use it for both gpg and ssh,
    # hence the if/else structure here with ssh-agent
    if command -sq gpgconf
        # Currently the least bad way I know to do this
        set -e SSH_AUTH_SOCK
        set -x SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh
        if not pgrep gpg-agent >/dev/null
            gpgconf --launch gpg-agent
            # If we want to use GPG Agent as the SSH agent
            # then uncomment the lines below:
            ssh-add -q --apple-load-keychain
        end
    else if command -sq ssh-agent
        if test -z "$SSH_ENV"
            set -xg SSH_ENV $HOME/.ssh/environment
        end
        if not __is_ssh_agent_running
            ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
            chmod 600 $SSH_ENV
            source $SSH_ENV > /dev/null
            ssh-add -q --apple-load-keychain
        end
    end
end
