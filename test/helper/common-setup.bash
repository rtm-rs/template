bats_require_minimum_version 1.5.0

_common_setup() {
    load 'helper/bats-support/load'
    load 'helper/bats-assert/load'
    load 'helper/bats-file/load'

    _setup_rtm_env

    if [[ -z ${XDG_STATE_HOME-} ]]; then
        export XDG_STATE_HOME="$HOME/.local/state"
    fi
    export ORIGINAL_XDG_STATE_HOME=${XDG_STATE_HOME-}

    PROJECT_ROOT="$( cd "$( dirname "$BATS_TEST_FILENAME" )/.." >/dev/null 2>&1 && pwd )"
    export RTM_TEMPLATE_URL="${PROJECT_ROOT}/test/fixtures/template.git"
    export RTM_TEMPLATE_DATA=$(mktemp --directory)
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    # DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$PROJECT_ROOT/scripts:$PATH"
}

_setup_rtm_env() {
  export RTM_TPL_AUTHORS=me
  export RTM_TPL_PROJECT_NAME=mtr
  export RTM_TPL_CRATE_TYPE='binary library'
  export RTM_TPL_LICENSES='mit'
  export RTM_TPL_PARENT_DIR="$BATS_TMPDIR"
  export RTM_TPL_SOURCE='github.com'
  export RTM_TPL_STORAGE_ADAPTERS='sql'
  export RTM_TPL_TLS='rustls'
  export RTM_TPL_SQL_ORM='diesel'
  export RTM_TPL_SQL_MIGRATION='sea-orm'
  export RTM_TPL_SQL_VENDOR='postgres'
  export RTM_TPL_SQL_DB_USER='me'
  export RTM_TPL_SQL_DB_PASSWORD='sekr3t'
  export RTM_TPL_SQL_DB_HOST='localhost'
  export RTM_TPL_SQL_DB_PORT='5432'
  export RTM_TPL_SQL_DB_NAME='mtr'
}