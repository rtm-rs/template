rm -f "${XDG_STATE_HOME}/rtm_setup"
if [[ -n ${ORIGINAL_XDG_STATE_HOME-} ]]; then
    export XDG_STATE_HOME="$ORIGINAL_XDG_STATE_HOME"
fi
