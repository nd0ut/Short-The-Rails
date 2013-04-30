class Url
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code, type: String
  field :url, type: String
  field :user_id, type: String

  attr_accessible :code, :url, :user_id, :created_at

  before_save :new?

  validates :url, :format => {
      :with => /^(http|https|ftp|mailto|magnet)(?::)(?:\/\/|\?)?(?=[a-zA-Z0-9])/,
      :message => 'Invalid url format'
  }

  def new?
    exist_url = Url.where(url: url,
                          user_id: user_id).first

    if exist_url.nil?
      generate_code_and_save
      true
    else
      write_attribute(:code, exist_url.code)
      false
    end
  end

  def generate_code_and_save
  	chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'

    length = 5
    ticks = 0

    while true do
      random_code = ''

      length.times do
        random_code << chars[rand(chars.size)]
      end

      unless Url.where(code: random_code).exists?
        write_attribute(:code, random_code)
        return true
      end

      if ticks > 3
        length += 1
      end

      ticks += 1

    end
  end
end
