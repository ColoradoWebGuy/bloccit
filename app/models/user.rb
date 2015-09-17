class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  before_save :format_data
  before_save { self.role ||= :member }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 100 },
             format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  has_secure_password

  def format_data
      self.email = email.downcase if email.present?
  end

  enum role: [:member, :admin]
end
