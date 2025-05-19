require "test_helper"

class SummarizerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get summarizer_new_url
    assert_response :success
  end

  test "should get create" do
    get summarizer_create_url
    assert_response :success
  end
end
