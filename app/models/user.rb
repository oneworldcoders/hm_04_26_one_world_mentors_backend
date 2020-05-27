class User < ApplicationRecord
  validates :email, presence: true
  validates :user_type, presence: true

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == password
      return user
    end
    nil
  end

  def self.find_or_create(auth)
    find_or_create_by(sub: auth["sub"]) do |user|
      user.sub = auth["sub"]
      user.first_name ||= auth["given_name"]
      user.last_name ||= auth["family_name"]
      user.email = auth["email"]
      user.user_type = "mentee"
      user.save!
    end
  end
end
