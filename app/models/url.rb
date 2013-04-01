class Url < ActiveRecord::Base
  attr_accessible :code, :url, :user_id

  before_save :new?

  validates :url, :format => {
      :with => /^(http|https|ftp|mailto|magnet)(?::)(?:\/\/|\?)?(?=[a-zA-Z0-9])/,
      :message => 'Invalid url format'
  }

  def new?
    exist_url = Url.find_by_url(url)

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

      if Url.find_by_code(random_code).nil?
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
