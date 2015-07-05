class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  validates_confirmation_of :password

  sluggable_column :username

  def admin?
    role == "admin"
  end

  def moderator?
    role == "moderator"
  end
end
