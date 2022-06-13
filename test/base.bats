setup() {
  load 'helper/common-setup'
  _common_setup
}

# @test "Generate base template project with defaults" {
#   run rtm-generate --verbose --monochrome base
#   assert_success
#   assert_output --partial "Using (RTM_TEMPLATE_DATA):"
#   assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
#   assert_dir_exists "$(pwd)"
# }

# Here we provide non-default values to check they are passed through.
@test "Generate base template project from environment" {
  export RTM_TPL_AUTHORS=me
  export RTM_TPL_PARENT_DIR="$BATS_TMPDIR"
  export RTM_TPL_CRATE_TYPE="binary library"
  export RTM_TPL_STORAGE_ADAPTERS='csv http json sql yaml'
  export RTM_TPL_LICENSES='mit'

  run rtm-generate --verbose --monochrome base

  assert_success
  assert_output --partial "Using (RTM_TEMPLATE_DATA):"
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
  assert_output --partial "Project authors: me"
  assert_output --partial "Project parent directory: $BATS_TMPDIR"
  assert_output --partial "Crate type: binary library"
  assert_output --partial "Storage adapters: csv http json sql yaml"
  assert_output --partial "Licenses: mit"
}
