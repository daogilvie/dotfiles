function upup -d "Upgrade all the things"
    if command -sq brew
        brew update; brew upgrade; brew cleanup;
    end
    if command -sq nvim
        nvim +PackerSync +TSUpdateSync +qa;
    end
    if command -sq rustup
        rustup self update; rustup update;
    end
    if test -d ~/.asdf
        asdf update; asdf plugin-update --all;
        if asdf which direnv &> /dev/null
            asdf direnv setup --shell fish --version latest;
        end
    end
    if functions -q fisher
        fisher update;
    end
end
