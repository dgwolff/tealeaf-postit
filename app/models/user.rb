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

  def two_factor_auth?
    !phone.blank?
  end

  def generate_pin!
    update_column(:pin, rand(10**6))
  end

  def remove_pin!
    update_column(:pin, nil)
  end

  def send_pin_to_twilio
    account_sid = ENV["TWILIO_ACCOUNT_SID"]
    auth_token = ENV["TWILIO_AUTH_TOKEN"]

    client = Twilio::REST::Client.new(account_sid, auth_token)

    msg = "Hi, please input the following PIN to login: #{pin}"
    account = client.account
    message = client.account.sms.messages.create(from: "+15005550006",
                                                 to: "+14108675309",
                                                 body: msg)
  end
end
