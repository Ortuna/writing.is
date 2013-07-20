require 'test_helper'
class UsersControllerTest < ActionController::TestCase
  test 'can get to the login page' do
    get :login
    assert_response :success
  end
  
  test 'can logout user' do
    session[:stuff] = "some session info"

    get :logout
    assert_redirected_to user_login_path
    assert_equal nil, session[:stuff]
  end

  # xtest 'shows an error flash' do
  #   flash.now[:error] = 'invalid login!'
    
  #   get :login
  #   assert_select '.alert.alert-error'
  # end

end
