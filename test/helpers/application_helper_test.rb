require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase
  test "should find the current user from session" do
    User.new(uid: 1, provider: 'github', name: 'test_user').save
    session[:user_id] = User.first[:id]

    user = current_user
    assert_equal user[:id], User.first[:id]
  end

  test "#current_user returns nil if can't find a user" do
    session[:user_id] = 123
    assert_equal current_user, nil    
  end
end