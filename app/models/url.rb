class Url < ActiveRecord::Base
  attr_accessible :code, :url
  after_validation :ensure_url_exist

  validates :url, :uniqueness => true

  def ensure_url_exist
    if !self.errors[:url].any?
      generate_code
    else
      exist_url = Url.find_by_url(url)
      update_attribute(:code, exist_url.code)
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
        update_attribute(:code, random_code)
        return
      end

      if ticks > 3
        length += 1
      end

      ticks += 1

    end
  end
end
