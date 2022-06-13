setup() {
  load 'helper/common-setup'
  _common_setup
}

@test "Generate base template project with defaults" {
  run rtm-generate --verbose --monochrome base
  assert_success
  assert_output --partial "Using (RTM_TEMPLATE_DATA):"
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
}

@test "Generate base template project from environment" {
  run rtm-generate --verbose --monochrome base <<< 'y'
  # run enquirer input --message "Project authors?" <<< 'me'
  assert_success
  assert_output --partial "Using (RTM_TEMPLATE_DATA):"
  assert_dir_not_exists "${RTM_TEMPLATE_DATA}"
}
