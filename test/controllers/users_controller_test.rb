require 'test_helper'
class UsersControllerTest < ActionController::TestCase
  test 'can get to the login page' do
    get :login
    assert_response :success
  end
  
  test 'shows an error flash' do
    flash[:error] = 'invalid login!'
    
    get :login
    assert_select '.alert.alert-error'
  end

end
