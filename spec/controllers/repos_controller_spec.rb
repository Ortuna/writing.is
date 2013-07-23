require 'spec_helper'
describe ReposController do
  def user_hash
    { uid: 'uid',
      role: 'author',
      provider: 'github',
      name: 'test_user',
      image_url: 'blank',
      auth_token: 'some_token'
    }
  end

  before(:each) do
    @user = User.create(user_hash)
    session[:user_id] = @user[:id]
  end

  it 'can list all the repos' do
    require 'pry';binding.pry
    controller.should_receive(:get_user_repos).and_return('a')
    get :index
    response.should == 'a'
  end

end
