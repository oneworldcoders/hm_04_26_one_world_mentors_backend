class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :user_type, presence: true

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.authenticate(password)
      return user
    end
    nil
  end
end
