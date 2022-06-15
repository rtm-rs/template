setup() {
  load 'helper/common-setup'
  _common_setup
}

# Provide non-default values to test they are passed through.
@test "Generate base SQL (non-SQLite) template project from environment" {
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

  run rtm-generate --verbose --monochrome base

  assert_success

  refute_output --partial 'warning: You appear to have cloned an empty repository.'

  assert_output --partial 'Using (RTM_TEMPLATE_DATA):'
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
  assert_output --partial 'Project authors: me'
  assert_output --partial 'Project name: mtr'
  assert_output --partial "Project parent directory: $BATS_TMPDIR"
  assert_output --partial 'Crate type: binary library'
  assert_output --partial 'Storage adapters: sql'
  assert_output --partial 'Licenses: mit'
  assert_output --partial 'RTM install source: github.com'
  assert_output --partial 'Transport Layer Security (TLS): rustls'
  assert_output --partial 'SQL Object Relation Mapping crate: diesel'
  assert_output --partial 'SQL migration crate: sea-orm'
  assert_output --partial 'SQL vendor: postgres'
  assert_output --partial 'SQL vendor DB user name: me'
  assert_output --partial 'SQL vendor DB user password: sekr3t'
  assert_output --partial 'SQL vendor DB host: localhost'
  assert_output --partial 'SQL vendor DB port: 5432'
  assert_output --partial 'SQL vendor DB name: mtr'
}

@test "Generate base SQL (SQLite) template project from environment" {
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
  export RTM_TPL_SQL_VENDOR='sqlite'
  export RTM_TPL_SQL_DB_PATH='/tmp/main.db'

  run rtm-generate --verbose --monochrome base

  assert_success
  assert_output --partial 'Using (RTM_TEMPLATE_DATA):'
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
  assert_output --partial 'Project authors: me'
  assert_output --partial 'Project name: mtr'
  assert_output --partial "Project parent directory: $BATS_TMPDIR"
  assert_output --partial 'Crate type: binary library'
  assert_output --partial 'Storage adapters: sql'
  assert_output --partial 'Licenses: mit'
  assert_output --partial 'RTM install source: github.com'
  assert_output --partial 'Transport Layer Security (TLS): rustls'
  assert_output --partial 'SQL Object Relation Mapping crate: diesel'
  assert_output --partial 'SQL migration crate: sea-orm'
  assert_output --partial 'SQL vendor: sqlite'
  assert_output --partial 'SQL vendor DB path: /tmp/main.db'
}

@test "Generate base SQL (non-SQLite) and unimplemented template project from environment" {
  export RTM_TPL_AUTHORS=me
  export RTM_TPL_PROJECT_NAME=mtr
  export RTM_TPL_CRATE_TYPE='binary library'
  export RTM_TPL_LICENSES='mit'
  export RTM_TPL_PARENT_DIR="$BATS_TMPDIR"
  export RTM_TPL_SOURCE='github.com'
  export RTM_TPL_STORAGE_ADAPTERS='sql yaml'
  export RTM_TPL_TLS='rustls'
  export RTM_TPL_SQL_ORM='diesel'
  export RTM_TPL_SQL_MIGRATION='sea-orm'
  export RTM_TPL_SQL_VENDOR='postgres'
  export RTM_TPL_SQL_DB_USER='me'
  export RTM_TPL_SQL_DB_PASSWORD='sekr3t'
  export RTM_TPL_SQL_DB_HOST='localhost'
  export RTM_TPL_SQL_DB_PORT='5432'
  export RTM_TPL_SQL_DB_NAME='mtr'

  run rtm-generate --verbose --monochrome base

  assert_failure
  assert_output --partial 'Using (RTM_TEMPLATE_DATA):'
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
  assert_output --partial 'Project authors: me'
  assert_output --partial 'Project name: mtr'
  assert_output --partial "Project parent directory: $BATS_TMPDIR"
  assert_output --partial 'Crate type: binary library'
  assert_output --partial 'Storage adapters: sql yaml'
  assert_output --partial 'Licenses: mit'
  assert_output --partial 'RTM install source: github.com'
  assert_output --partial 'Transport Layer Security (TLS): rustls'
  assert_output --partial 'SQL Object Relation Mapping crate: diesel'
  assert_output --partial 'SQL migration crate: sea-orm'
  assert_output --partial 'SQL vendor: postgres'
  assert_output --partial 'SQL vendor DB user name: me'
  assert_output --partial 'SQL vendor DB user password: sekr3t'
  assert_output --partial 'SQL vendor DB host: localhost'
  assert_output --partial 'SQL vendor DB port: 5432'
  assert_output --partial 'SQL vendor DB name: mtr'
  assert_output --partial 'Not yet implemented.  Pull requests welcome: https://github.com/rtm-rs/template'
}

@test "Generate base with unknown storage adapter from environment" {
  export RTM_TPL_AUTHORS=me
  export RTM_TPL_PROJECT_NAME=mtr
  export RTM_TPL_CRATE_TYPE='binary library'
  export RTM_TPL_LICENSES='mit'
  export RTM_TPL_PARENT_DIR="$BATS_TMPDIR"
  export RTM_TPL_SOURCE='github.com'

  export RTM_TPL_STORAGE_ADAPTERS='unknown'

  export RTM_TPL_TLS='rustls'
  export RTM_TPL_SQL_ORM='diesel'
  export RTM_TPL_SQL_MIGRATION='sea-orm'
  export RTM_TPL_SQL_VENDOR='sqlite'
  export RTM_TPL_SQL_DB_PATH='/tmp/main.db'

  run rtm-generate --verbose --monochrome base

  assert_failure
  assert_output --partial 'Using (RTM_TEMPLATE_DATA):'
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
  assert_output --partial 'Project authors: me'
  assert_output --partial 'Project name: mtr'
  assert_output --partial "Project parent directory: $BATS_TMPDIR"
  assert_output --partial 'Crate type: binary library'
  assert_output --partial 'Storage adapters: unknown'
  assert_output --partial 'Licenses: mit'
  assert_output --partial 'RTM install source: github.com'
  assert_output --partial 'Transport Layer Security (TLS): rustls'
  assert_output --partial 'Unknown storage adapter in RTM_TPL_STORAGE_ADAPTERS: unknown'
}

@test "Generate base CSV template project from environment" {
  export RTM_TPL_AUTHORS=me
  export RTM_TPL_PROJECT_NAME=mtr
  export RTM_TPL_CRATE_TYPE='binary library'
  export RTM_TPL_LICENSES='mit'
  export RTM_TPL_PARENT_DIR="$BATS_TMPDIR"
  export RTM_TPL_SOURCE='github.com'
  export RTM_TPL_STORAGE_ADAPTERS='csv'
  export RTM_TPL_TLS='rustls'

  run rtm-generate --verbose --monochrome base

  assert_failure
  assert_output --partial 'Using (RTM_TEMPLATE_DATA):'
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
  assert_output --partial 'Project authors: me'
  assert_output --partial 'Project name: mtr'
  assert_output --partial "Project parent directory: $BATS_TMPDIR"
  assert_output --partial 'Crate type: binary library'
  assert_output --partial 'Storage adapters: csv'
  assert_output --partial 'Licenses: mit'
  assert_output --partial 'RTM install source: github.com'
  assert_output --partial 'Transport Layer Security (TLS): rustls'
  assert_output --partial 'Not yet implemented.  Pull requests welcome: https://github.com/rtm-rs/template'
}

@test "Generate base HTTP template project from environment" {
  export RTM_TPL_AUTHORS=me
  export RTM_TPL_PROJECT_NAME=mtr
  export RTM_TPL_CRATE_TYPE='binary library'
  export RTM_TPL_LICENSES='mit'
  export RTM_TPL_PARENT_DIR="$BATS_TMPDIR"
  export RTM_TPL_SOURCE='github.com'
  export RTM_TPL_STORAGE_ADAPTERS='http'
  export RTM_TPL_TLS='rustls'

  run rtm-generate --verbose --monochrome base

  assert_failure
  assert_output --partial 'Using (RTM_TEMPLATE_DATA):'
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
  assert_output --partial 'Project authors: me'
  assert_output --partial 'Project name: mtr'
  assert_output --partial "Project parent directory: $BATS_TMPDIR"
  assert_output --partial 'Crate type: binary library'
  assert_output --partial 'Storage adapters: http'
  assert_output --partial 'Licenses: mit'
  assert_output --partial 'RTM install source: github.com'
  assert_output --partial 'Transport Layer Security (TLS): rustls'
  assert_output --partial 'Not yet implemented.  Pull requests welcome: https://github.com/rtm-rs/template'
}

@test "Generate base JSON template project from environment" {
  export RTM_TPL_AUTHORS=me
  export RTM_TPL_PROJECT_NAME=mtr
  export RTM_TPL_CRATE_TYPE='binary library'
  export RTM_TPL_LICENSES='mit'
  export RTM_TPL_PARENT_DIR="$BATS_TMPDIR"
  export RTM_TPL_SOURCE='github.com'
  export RTM_TPL_STORAGE_ADAPTERS='json'
  export RTM_TPL_TLS='rustls'

  run rtm-generate --verbose --monochrome base

  assert_failure
  assert_output --partial 'Using (RTM_TEMPLATE_DATA):'
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
  assert_output --partial 'Project authors: me'
  assert_output --partial 'Project name: mtr'
  assert_output --partial "Project parent directory: $BATS_TMPDIR"
  assert_output --partial 'Crate type: binary library'
  assert_output --partial 'Storage adapters: json'
  assert_output --partial 'Licenses: mit'
  assert_output --partial 'RTM install source: github.com'
  assert_output --partial 'Transport Layer Security (TLS): rustls'
  assert_output --partial 'Not yet implemented.  Pull requests welcome: https://github.com/rtm-rs/template'
}

@test "Generate base YAML template project from environment" {
  export RTM_TPL_AUTHORS=me
  export RTM_TPL_PROJECT_NAME=mtr
  export RTM_TPL_CRATE_TYPE='binary library'
  export RTM_TPL_LICENSES='mit'
  export RTM_TPL_PARENT_DIR="$BATS_TMPDIR"
  export RTM_TPL_SOURCE='github.com'
  export RTM_TPL_STORAGE_ADAPTERS='yaml'
  export RTM_TPL_TLS='rustls'

  run rtm-generate --verbose --monochrome base

  assert_failure
  assert_output --partial 'Using (RTM_TEMPLATE_DATA):'
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
  assert_output --partial 'Project authors: me'
  assert_output --partial 'Project name: mtr'
  assert_output --partial "Project parent directory: $BATS_TMPDIR"
  assert_output --partial 'Crate type: binary library'
  assert_output --partial 'Storage adapters: yaml'
  assert_output --partial 'Licenses: mit'
  assert_output --partial 'RTM install source: github.com'
  assert_output --partial 'Transport Layer Security (TLS): rustls'
  assert_output --partial 'Not yet implemented.  Pull requests welcome: https://github.com/rtm-rs/template'
}
