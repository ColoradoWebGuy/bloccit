class User < ActiveRecord::Base

  before_save :format_data

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }

  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 100 },
             format: { with: EMAIL_REGEX }

  has_secure_password

  def format_data
      self.email = email.downcase if email.present?

      if name.present?
        tempName = name.split(' ')
        tempName.each { |i|
          i = i.capitalize
        }
        self.name = tempName.join(' ')
      end
  end

end
