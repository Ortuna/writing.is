require 'spec_helper'
describe UsersController do
  it 'can get to the login page' do
    get :login
    response.should be_success
  end
  
  it 'can logout user' do
    session[:stuff] = "some session info"

    get :logout
    assert_redirected_to user_login_path
    session[:stuff].should == nil
  end

  # xtest 'shows an error flash' do
  #   flash.now[:error] = 'invalid login!'
    
  #   get :login
  #   assert_select '.alert.alert-error'
  # end

end
