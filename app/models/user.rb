  class User < ActiveRecord::Base

  validates_presence_of   :uid, :provider, :name
  validates_uniqueness_of :uid

  def self.create_with_omniauth(auth = {})
    return nil unless auth
    user       = User.new
    user.attributes = {
      provider:  auth['provider'],
      uid:       auth['uid'],
      name:      (auth['info'] && auth['info']['name'])  || nil,
      image_url: (auth['info'] && auth['info']['image']) || nil,
      role:      'author'
    }
    user.save ? user : nil
  end

end
