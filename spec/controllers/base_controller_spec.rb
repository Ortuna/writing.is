require 'spec_helper'

describe BaseController do
  it "finds the current user from session" do
    User.new(uid: 1, provider: 'github', name: 'test_user', auth_token: 'xyz').save
    session[:user_id] = User.first[:id]

    user = @controller.send(:current_user)
    User.first[:id].should == user[:id]
  end  

  it "#current_user returns nil if can't find a user" do
    session[:user_id] = 123
    @controller.send(:current_user).should == nil
  end
end
