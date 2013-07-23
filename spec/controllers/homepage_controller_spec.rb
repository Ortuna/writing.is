require 'spec_helper'

describe HomepageController do
  render_views
  it "should get index" do
    get :index
    expect(response).to be_success
  end

  it "it should have the login link" do
    get :index
    response.body.should have_css('a.login', text: 'Login')
  end

  it "it should have a contact us link" do
    get :index
    response.body.should have_css('a.contact-us', text: 'Contact Us')
  end  
end
