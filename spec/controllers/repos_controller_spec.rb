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

  def repo_hash
    [{"name" => 'example1', "description" => 'desc1'},
     {"name" => 'example2', "description" => 'desc2'}]
  end

  before(:each) do
    @user = User.create(user_hash)
    controller.stub(:current_user).and_return(@user)
  end

  describe :index do 
    render_views
    it 'it should render the correct template' do
      controller.stub(:get_user_repos).and_return(repo_hash)
      get :index
      expect(response).to render_template("index")
    end

    it 'can list all the repos' do
      
      controller.stub(:get_user_repos).and_return(repo_hash)
      get :index
      expect(response.body).to match /example1/m
      expect(response.body).to match /example2/m

      expect(response.body).to match /desc1/m
      expect(response.body).to match /desc2/m
    end
  end


end
