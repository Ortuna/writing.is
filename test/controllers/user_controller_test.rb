require 'test_helper'
class UserControllerTest < ActionController::TestCase
  test 'can get to the login page' do
    get :login
    assert_response :success
  end

end
