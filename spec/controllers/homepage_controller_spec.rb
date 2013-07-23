require 'spec_helper'

describe HomepageController do

  it "should get index" do
    get :index
    expect(response).to be_success
  end

  xit "it should have the login link" do
    get :index
    assert_select 'a.login', text: 'Login'
  end

  xit "it should have a contact us link" do
    get :index
    assert_select 'a.contact-us', text: 'Contact Us'
  end  
end
