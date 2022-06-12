setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'
  load 'test_helper/bats-file/load'

  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
  # make executables in src/ visible to PATH
  PATH="$DIR/../scripts:$PATH"
}

@test "RTM help" {
  run rtm-generate --help
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Usage:" ]
  [ "${lines[1]}" = "     -h|--help                  Displays this help" ]
  [ "${lines[2]}" = "     -v|--verbose               Displays verbose output" ]
  [ "${lines[3]}" = "    -nc|--no-colour             Disables colour output" ]
  [ "${lines[4]}" = "    -cr|--cron                  Run silently unless we encounter an error" ]
}
