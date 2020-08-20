class User < ApplicationRecord
  before_create do
    self.password = BCrypt::Password.create(password) if password
  end

  after_create do
    Mentee.create(user_id: self.id) if self.user_type == "mentee"
    Mentor.create(user_id: self.id) if self.user_type == "mentor"
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, :uniqueness => true
  validates :password, presence: true
  validates :user_type, presence: true

  belongs_to :course, optional: true
  has_many :mentees

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && BCrypt::Password.new(user.password) == password
      return user
    end
    nil
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
