class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ## OAuth
  field :uid, type: String
  field :provider, type: String
  field :username, type: String

  ## Database authenticatable
  field :email, type: String
  field :encrypted_password, type: String

  ## Recoverable
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: DateTime

  ## Rememberable
  field :remember_created_at, type: DateTime

  ## Trackable
  field :sign_in_count, type: Integer
  field :current_sign_in_at, type: DateTime
  field :last_sign_in_at, type: DateTime
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  index({ email: 1 }, { unique: true, background: true })

  devise :database_authenticatable, :rememberable, :trackable, :omniauthable, :registerable

  attr_accessible :uid, :provider, :username, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at

  has_many :urls

  validates :username, :presence => true

  validates :email,    :presence => true,
                       :format => { :with => /@/ },
                       :uniqueness => true,
                       :allow_nil => true,
                       :allow_blank => false

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => Devise.password_length }


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

  def self.find_or_create_for_twitter(response)
    data = response.info

    User.where(uid: response.uid,
               username: data[:nickname],
               provider: 'twitter').first_or_create
  end

end
