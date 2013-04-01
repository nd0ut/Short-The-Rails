class User < ActiveRecord::Base
  devise :rememberable, :trackable, :omniauthable

  attr_accessible :uid, :provider, :username

  has_many :urls

  def self.find_or_create_for_vkontakte(response)
    data = response.info

    if user = User.where(:uid => response.uid, :provider => 'vkontakte').first
      user
    else
      user = User.new :uid => response.uid, :username => data.name
      user.uid = response.uid
      user.provider = 'vkontakte'
      user.save
      user
    end
  end
end
