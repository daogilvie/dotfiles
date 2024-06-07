# Needed until https://github.com/martinvonz/jj/issues/405 is over the line
function jj_pre_commit -d "JJ workaround for using pre-commit"
    set --local jjlines (string join '££' (jj show -s -r))
    string match -raq "[AM] (?<filenames>[^£]+)(££)?" $jjlines
    pre-commit run --files $filenames
end
