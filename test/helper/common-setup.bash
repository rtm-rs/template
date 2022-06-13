_common_setup() {
    load 'helper/bats-support/load'
    load 'helper/bats-assert/load'
    load 'helper/bats-file/load'

    if [[ -z ${XDG_STATE_HOME-} ]]; then
        export XDG_STATE_HOME="$HOME/.local/state"
    fi
    export ORIGINAL_XDG_STATE_HOME=${XDG_STATE_HOME-}

    PROJECT_ROOT="$( cd "$( dirname "$BATS_TEST_FILENAME" )/.." >/dev/null 2>&1 && pwd )"
    export RTM_TEMPLATE_URL="${PROJECT_ROOT}/test/fixtures/template.git"

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    # DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$PROJECT_ROOT/scripts:$PATH"
}

# $BATS_RUN_TMPDIR $BATS_TEST_TMPDIR $BATS_SUITE_TMPDIR
# $ git init --bare ~/repos/myproject.git
# $ cd /path/to/existing/repo
# $ git remote add origin ~/repos/myproject.git
# $ git push origin master
