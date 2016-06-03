require 'byebug'
class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, :presence => true
  validates :session_token, :uniqueness => true
  validates :email, :uniqueness => true

  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :notes,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Note",
    dependent: :destroy

  attr_reader :password

  def password=(pwd)
    @password = pwd
    self.password_digest = BCrypt::Password.create(pwd)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save
    self.session_token
  end

  def is_password?(pwd)
    BCrypt::Password.new(self.password_digest).is_password?(pwd)
  end

  def self.find_by_credentials(email, password)
    user = self.find_by_email(email)
    return nil if user.nil?
    return user if user.is_password?(password)
    nil
  end

end
