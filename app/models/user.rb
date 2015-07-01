class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  validates_confirmation_of :password

  before_save :generate_slug

  def generate_slug
    self.slug = username.gsub(" ", "-").downcase
  end

  def to_param
    slug
  end
end
