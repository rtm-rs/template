setup() {
  load 'helper/common-setup'
  _common_setup
}

@test "Generate base snippet: cargo_lib" {
    load rtm-generate
    RTM_TPL_VERBOSE=true

    run generate_base_snippets

    assert_file_exists "${RTM_TEMPLATE_DATA}/snippets.txt"
    assert_output <<'EOF'
rtm_tpl_base_cargo_lib="a
b"
EOF
}