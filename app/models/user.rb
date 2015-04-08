class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :email, uniqueness: true
  validates :username, :password_digest, :session_token, :email, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  before_validation :ensure_session_token
  
  belongs_to :group
  has_many :owned_groups, class_name: Group, foreign_key: :leader_id
  
  def self.find_by_credentials(username, password, email)
    user = User.find_by(username: username, email: email)
    return nil if user.nil?
    user.password_digest.is_password?(password) ? user : nil
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def password_digest
    BCrypt::Password.new(super)
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end
  
end