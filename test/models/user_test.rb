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

    assert user.uid       == 'uid'
    assert user.provider  == 'github'
    assert user.name      == 'test_user'
    assert user.image_url == 'some_string'
    assert user.role      == 'author'

    user = User.create_with_omniauth({})
    assert user == nil
  end
end
 