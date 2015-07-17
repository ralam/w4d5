class User < ActiveRecord::Base
  after_initialize :ensure_session_token

  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :subs,
    class_name: :Sub,
    foreign_key: :moderator_id
  )

  attr_reader :password
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    @user && @user.is_password?(password) ? @user : nil
  end

  def generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token
    self.session_token = generate_session_token
    self.save!
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
