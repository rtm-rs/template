setup() {
  load 'helper/common-setup'
  _common_setup
}

@test "Generate base template project with defaults" {
  run rtm-generate --verbose --monochrome base
  assert_success
  assert_output --partial "Using (RTM_TEMPLATE_DATA):"
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "$(pwd)"
}

@test "Generate base template project from environment" {
  RTM_TPL_AUTHORS=me
  RTM_TPL_PARENT_DIR="$BATS_TMPDIR"

  run rtm-generate --verbose --monochrome base

  assert_success
  assert_output --partial "Using (RTM_TEMPLATE_DATA):"
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
  assert_dir_exists "${BATS_TMPDIR}"
}
