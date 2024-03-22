source lib/api.sh

_api_unit_tests(){
    # test _read_online_file_info
    echo "Testing _read_online_file_info"
    echo "Expected: http://localhost:8000/"
    echo "Result: $(_read_online_file_info "test/online_file" "api_url")"
    echo "Expected: 123456"
    echo "Result: $(_read_online_file_info "test/online_file" "session_id")"
    
    # test _get_api_url
    echo "Testing _get_api_url"
    echo "Expected: http://localhost:8000/"
    echo "Result: $(_get_api_url "test/online_file")"
    
    # test _api_request
    echo "Testing _api_request"
    echo "Expected: {\"message\":\"Hello, World!\"}"
    echo "Result: $(_api_request "http://localhost:8000/" "hello" "GET" "")"
    echo "Expected: {\"message\":\"Hello, World!\"}"
    echo "Result: $(_api_request "http://localhost:8000/" "hello" "POST" "")"
    echo "Expected: {\"message\":\"Hello, World!\"}"
    echo "Result: $(_api_request "http://localhost:8000/" "hello" "PUT" "")"
    echo "Expected: {\"message\":\"Hello, World!\"}"
    echo "Result: $(_api_request "http://localhost:8000/" "hello" "DELETE" "")"
}

_api_unit_tests
