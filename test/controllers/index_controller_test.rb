require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get Index" do
    get root_path
    assert_response 200
  end

  test "should create file" do
    post "/upload_file", params: { code: 'body { color: #fff; }' }
    assert_response 201
  end

  test "should return no length" do
    post "/upload_file", params: { code: '' }
    assert_response 411
  end

  test "should return too long" do
    post "/upload_file", params: { code: 'a' * 2501 }
    assert_response 413
  end
end
