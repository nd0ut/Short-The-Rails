class Url < ActiveRecord::Base
  attr_accessible :code, :url

  after_validation :generate_code, :unless => :url_already_exist

  validates :url, :format => {
      :with => /^(http|https|ftp|mailto|magnet)(?::)(?:\/\/|\?)?(?=[a-zA-Z0-9])/,
      :message => 'Invalid url format'
  }

  def url_already_exist
    exist_url = Url.find_by_url(url)

    if exist_url.nil?
      return false
    else
      write_attribute(:code, exist_url.code)
      return true
    end
  end

  def generate_code
  	chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'

    length = 5
    ticks = 0

    while true do
      random_code = ''

      length.times do
        random_code << chars[rand(chars.size)]
      end

      if(Url.find_by_code(random_code).nil?)
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
