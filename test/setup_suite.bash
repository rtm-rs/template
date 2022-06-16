setup_suite() {

    export PROJECT_ROOT="$( cd "$( dirname "$BATS_TEST_FILENAME" )/.." >/dev/null 2>&1 && pwd )"
    export RTM_TEMPLATE_URL="https://github.com/rtm-rs/template.git"
    export RTM_TEMPLATE_DATA=$(mktemp --directory)
    git clone --depth 1 -b main "${RTM_TEMPLATE_URL}" "${RTM_TEMPLATE_DATA}"

    echo setup_suite
}

teardown_suite() {
    rm -rf "${RTM_TEMPLATE_DATA}"
    echo teardown_suite
}
