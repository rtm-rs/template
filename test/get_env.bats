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

@test "Get name from env" {
    load rtm-generate
    RTM_TPL_PROJECT_NAME=mtr
    get_project_name
    [ "$RTM_TPL_PROJECT_NAME" = 'mtr' ]
}

@test "Get authors from env" {
    load rtm-generate
    RTM_TPL_AUTHORS=me
    get_authors
    [ "$RTM_TPL_AUTHORS" = 'me' ]
}

@test "Get project licenses from env" {
    load rtm-generate
    RTM_TPL_LICENSES='mit'
    get_licenses
    [ "$RTM_TPL_LICENSES" = 'mit' ]
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

@test "Get Transport Layer Security (TLS) from env" {
    load rtm-generate
    RTM_TPL_TLS='rustls'
    get_tls
    [ "$RTM_TPL_TLS" = 'rustls' ]
}

@test "Get SQL Object Relation Mapping crate" {
    load rtm-generate
    RTM_TPL_SQL_ORM='diesel'
    get_sql_orm
    [ "$RTM_TPL_SQL_ORM" = 'diesel' ]
}

@test "Get SQL migration crate" {
    load rtm-generate
    RTM_TPL_SQL_MIGRATION='sea-orm'
    get_sql_migration
    [ "$RTM_TPL_SQL_MIGRATION" = 'sea-orm' ]
}

@test "Get SQL vendor" {
    load rtm-generate
    RTM_TPL_SQL_VENDOR='postgres'
    get_sql_vendor
    [ "$RTM_TPL_SQL_VENDOR" = 'postgres' ]
}

@test "Get SQL vendor DB user name" {
    load rtm-generate
    RTM_TPL_SQL_DB_USER='me'
    get_sql_db_user
    [ "$RTM_TPL_SQL_DB_USER" = 'me' ]
}

@test "Get SQL vendor DB user password" {
    load rtm-generate
    RTM_TPL_SQL_DB_PASSWORD='sekr3t'
    get_sql_db_password
    [ "$RTM_TPL_SQL_DB_PASSWORD" = 'sekr3t' ]
}

@test "Get SQL vendor DB host" {
    load rtm-generate
    RTM_TPL_SQL_DB_HOST='localhost'
    get_sql_db_host
    [ "$RTM_TPL_SQL_DB_HOST" = 'localhost' ]
}

@test "Get SQL vendor DB port" {
    load rtm-generate
    RTM_TPL_SQL_DB_PORT=5432
    get_sql_db_port
    [ "$RTM_TPL_SQL_DB_PORT" = '5432' ]
}

@test "Get SQL vendor DB name" {
    load rtm-generate
    RTM_TPL_SQL_DB_NAME='mtr'
    get_sql_db_name
    [ "$RTM_TPL_SQL_DB_NAME" = 'mtr' ]
}

@test "Get SQL vendor DB path" {
    load rtm-generate
    RTM_TPL_SQL_DB_PATH='/tmp/main.db'
    get_sql_db_path
    [ "$RTM_TPL_SQL_DB_PATH" = '/tmp/main.db' ]
}

@test "Get input for storage adapter CSV" {
    load rtm-generate
    run gather_input_base_csv
    assert_failure
    assert_output "Not yet implemented.  Pull requests welcome: https://github.com/rtm-rs/template"
}

@test "Get input for storage adapter http" {
    load rtm-generate
    run gather_input_base_http
    assert_failure
    assert_output "Not yet implemented.  Pull requests welcome: https://github.com/rtm-rs/template"
}

@test "Get input for storage adapter JSON" {
    load rtm-generate
    run gather_input_base_json
    assert_failure
    assert_output "Not yet implemented.  Pull requests welcome: https://github.com/rtm-rs/template"
}

@test "Get input for storage adapter SQL (known vendor)" {
    load rtm-generate

    export RTM_TPL_SQL_ORM='diesel'
    export RTM_TPL_SQL_MIGRATION='sea-orm'
    export RTM_TPL_SQL_VENDOR='postgres'
    export RTM_TPL_SQL_DB_USER='me'
    export RTM_TPL_SQL_DB_PASSWORD='sekr3t'
    export RTM_TPL_SQL_DB_HOST='localhost'
    export RTM_TPL_SQL_DB_PORT='5432'
    export RTM_TPL_SQL_DB_NAME='mtr'

    run gather_input_base_sql
    assert_success
    refute_output
}

@test "Get input for storage adapter SQL (unknown vendor)" {
    load rtm-generate

    export RTM_TPL_SQL_ORM='diesel'
    export RTM_TPL_SQL_MIGRATION='sea-orm'
    export RTM_TPL_SQL_VENDOR='sled'
    export RTM_TPL_SQL_DB_USER='me'
    export RTM_TPL_SQL_DB_PASSWORD='sekr3t'
    export RTM_TPL_SQL_DB_HOST='localhost'
    export RTM_TPL_SQL_DB_PORT='5432'
    export RTM_TPL_SQL_DB_NAME='mtr'

    run gather_input_base_sql
    assert_failure
    assert_output "Unknown SQL vendor in RTM_TPL_SQL_VENDOR: sled"
    assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
}

@test "Get input for storage adapter YAML" {
    load rtm-generate
    run gather_input_base_yaml
    assert_failure
    assert_output "Not yet implemented.  Pull requests welcome: https://github.com/rtm-rs/template"
}
