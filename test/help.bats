setup() {
  load 'helper/common-setup'
  _common_setup
}

@test "RTM help" {
  run rtm-generate --help
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Usage:" ]
  [ "${lines[1]}" = "     -h|--help          Display this help" ]
  [ "${lines[2]}" = "     -m|--monochrome    Disable colour output" ]
  [ "${lines[3]}" = "     -q|--quiet         Run silently unless an error occurs" ]
  [ "${lines[4]}" = "     -v|--verbose       Display verbose output" ]
}
