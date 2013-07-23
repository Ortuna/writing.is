require 'spec_helper'

describe User do
  it "validates presence of :uid, :provider, :name" do
    user = User.new(uid: 1, provider: 'github', name: 'test_user', auth_token: 'xyz')
    user.save.should == true

    user = User.new(provider: 'github', name: 'test_user', auth_token: 'xyz')
    user.save.should == false
    user.errors[:uid].should_not be_empty

    user = User.new(uid: 1, name: 'test_user', auth_token: 'xyz')
    user.save.should == false
    user.errors[:provider].should_not be_empty

    user = User.new(uid: 1, provider: 'github', auth_token: 'xyz')
    user.save.should == false
    user.errors[:name].should_not be_empty

    user = User.new(uid: 1, provider: 'github', name: 'test_user')
    user.save.should == false
    user.errors[:auth_token].should_not be_empty
  end

  it "validates uniqueness of :uid" do
    user = User.new(uid: 1, provider: 'github', name: 'test_user', auth_token: '123')
    user.save

    user = User.new(uid: 1, provider: 'github', name: 'test_user', auth_token: '123')
    user.save.should == false
    user.errors[:uid].should_not be_empty
  end

  it "#create_with_omniauth" do
    user = User.create_with_omniauth(fake_hash)

    user.uid.should == 'uid'
    user.provider.should == 'github'
    user.name.should == 'test_user'
    user.image_url.should == 'some_string'
    user.role.should == 'author'

    user = User.create_with_omniauth({})
    user.should == nil
  end

  it "#create_with_omniauth returns nil when nil is passed in" do
    assert_equal nil,User.create_with_omniauth(nil)
  end

  it "#find_with_omniauth finds a user with omniauth hash" do
    User.create_with_omniauth(fake_hash)
    user = User.find_with_omniauth(fake_hash)
    user[:uid].should == 'uid'
  end

  it "#find_with_omniauth returns nil when user is not found" do
    User.find_with_omniauth({}).should == nil
  end
end
 
