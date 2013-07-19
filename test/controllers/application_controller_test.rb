require 'test_helper'
class ApplicationControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
  end

  test "it should have the login link" do
    get :index
    assert_select 'a.login', 'Login'
  end

  test "it should have a contact us link" do
    get :index
    assert_select 'a.contact-us', 'Contact Us'
  end

end

