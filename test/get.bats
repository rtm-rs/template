setup() {
  load 'helper/common-setup'
  _common_setup
}

@test "Get authors" {
    load rtm-generate
    RTM_TPL_AUTHORS=me
    get_authors
    [ "$RTM_TPL_AUTHORS" = 'me' ]
}
