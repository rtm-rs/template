setup() {
  load 'helper/common-setup'
  _common_setup
}

@test "Generate project from base template" {
  run rtm-generate base
  assert_success
}
