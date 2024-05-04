# shellcheck source=lib/api.sh
. lib/api.sh

_api_unit_tests(){
    # test _read_online_file_info
    echo "Testing _read_online_file_info"
    echo "Expected: gameshell.org"
    echo "Result: $(_read_online_file_info "test/online.txt" "api_url")"
    echo "Expected: 2"
    echo "Result: $(_read_online_file_info "test/online.txt" "session_id")"
    
    # test _get_api_url
    echo "Testing _get_api_url"
    echo "Expected: http://gameshell.org/"
    echo "Result: $(_get_api_url "test/online.txt")"
    
    # test _api_request
    echo "Testing _api_request"
    echo "Expected: {\"message\":\"Hello, World!\"}"
    echo "Result: $(_api_request localhost:8080 hello GET)"
    echo "Expected: {\"message\":\"Hello, World!\"}"
    echo "Result: $(_api_request localhost:8080 hello POST "{\"hellothere\":\"general kenobi\"}")"
    echo "Expected: {\"message\":\"Hello, World!\"}"
    echo "Result: $(_api_request localhost:8080 hello PUT)"
    echo "Expected: {\"message\":\"Hello, World!\"}"
    echo "Result: $(_api_request localhost:8080 hello DELETE)"
}

_api_unit_tests
