class User < ApplicationRecord
  TEST_PASSWORD = "mentorspassword1234"

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, :uniqueness => true
  validates :password, presence: true
  validates :user_type, presence: true

  belongs_to :course, optional: true

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && BCrypt::Password.new(user.password)==password
      return user
    end
    nil
  end

end
