# Install Fisher once when missing.
#
# `fisher update` fetches plugins via background `fish --command` workers.
# Those workers re-source conf.d. An unguarded `fisher update` here used to
# fork-bomb on first apply: every worker re-entered this file and ran
# another `fisher update`. Restricting to interactive shells stops that,
# because the fetch workers are non-interactive.
if status is-interactive && not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    and fisher update
end
