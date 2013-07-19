require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "validates presence of :uid, :provider, :name" do
    user = User.new(uid: 1, provider: 'github', name: 'test_user')
    assert user.save

    user = User.new(provider: 'github', name: 'test_user')
    refute user.save
    refute_empty user.errors[:uid], ":uid errors should not be empty"

    user = User.new(uid: 1, name: 'test_user')
    refute user.save
    refute_empty user.errors[:provider], ":provider errors should not be empty"

    user = User.new(uid: 1, provider: 'github')
    refute user.save
    refute_empty user.errors[:name], ":name errors should not be empty"
  end

  test "validates uniqueness of :uid" do
    user = User.new(uid: 1, provider: 'github', name: 'test_user')
    user.save

    user = User.new(uid: 1, provider: 'github', name: 'test_user')
    refute user.save
    refute_empty user.errors[:uid]
  end

  test "#create_with_omniauth" do
    github_hash = {
      provider: 'github',
      uid:      'uid',
      info: {
        name: 'test_user',
        image: 'some_string',
        role:  'author'
      }
    }.with_indifferent_access

    user = User.create_with_omniauth(github_hash)

    assert_equal 'uid', user.uid
    assert_equal 'github', user.provider
    assert_equal 'test_user', user.name
    assert_equal 'some_string', user.image_url
    assert_equal 'author', user.role

    user = User.create_with_omniauth({})
    assert_equal nil, user
  end

  test "#create_with_omniauth returns nil when nil is passed in" do
    assert_equal nil,User.create_with_omniauth(nil)
  end
end
 
