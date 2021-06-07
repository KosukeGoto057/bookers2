require 'test_helper'

class BookCommentControllerTest < ActionDispatch::IntegrationTest
  test "should get comment:text" do
    get book_comment_comment:text_url
    assert_response :success
  end

  test "should get user_id:integer" do
    get book_comment_user_id:integer_url
    assert_response :success
  end

  test "should get book_id:integer" do
    get book_comment_book_id:integer_url
    assert_response :success
  end

end
