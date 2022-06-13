setup() {
  load 'helper/common-setup'
  _common_setup
}

@test "Get RTM install source from env" {
    load rtm-generate
    RTM_TPL_SOURCE='mit'
    get_source
    [ "$RTM_TPL_SOURCE" = 'mit' ]
}

@test "Get parent directory for the project from env" {
    load rtm-generate
    RTM_TPL_PARENT_DIR="$BATS_TMPDIR"
    get_parent_dir
    [ $RTM_TPL_PARENT_DIR = "$BATS_TMPDIR" ]
}

@test "Get authors from env" {
    load rtm-generate
    RTM_TPL_AUTHORS=me
    get_authors
    [ "$RTM_TPL_AUTHORS" = 'me' ]
}

@test "Get crate type from env" {
    load rtm-generate
    RTM_TPL_CRATE_TYPE='binary library'
    get_crate_type
    [ "$RTM_TPL_CRATE_TYPE" = 'binary library' ]
}

@test "Get storage adapters from env" {
    load rtm-generate
    RTM_TPL_STORAGE_ADAPTERS='csv http json sql yaml'
    get_storage_adapters
    [ "$RTM_TPL_STORAGE_ADAPTERS" = 'csv http json sql yaml' ]
}

@test "Get licenses from env" {
    load rtm-generate
    RTM_TPL_LICENSES='mit'
    get_licenses
    [ "$RTM_TPL_LICENSES" = 'mit' ]
}