class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uid, type: String
  field :provider, type: String
  field :username, type: String

  field :remember_created_at, type: DateTime

  field :sign_in_count, type: Integer
  field :current_sign_in_at, type: DateTime
  field :last_sign_in_at, type: DateTime
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String


  devise :rememberable, :trackable, :omniauthable

  attr_accessible :uid, :provider, :username

  has_many :urls

  def self.find_or_create_for_vkontakte(response)
    data = response.info

    User.where(uid: response.uid,
               username: data[:name],
               provider: 'vkontakte').first_or_create
  end

  def self.find_or_create_for_github(response)
    data = response.info

    User.where(uid: response.uid,
               username: data[:nickname],
               provider: 'github').first_or_create
  end
end
