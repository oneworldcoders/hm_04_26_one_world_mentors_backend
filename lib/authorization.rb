class Authorization
  def self.social_auth(decoded_token_data, headers)
    puts decoded_token_data
    if !decoded_token_data && headers && social_auth_user_details = JsonWebToken.verify(headers)
      puts social_auth_user_details
      user = User.find_or_create(social_auth_user_details[0])
      return { "email" => user.email, "id" => user.id, "firstname" => user.first_name, "lastname" => user.last_name }
    end
    nil
  end

  def self.authorize(headers)
    if headers["Authorization"].present?
      decoded_token_data = JsonWebToken.decode(headers["Authorization"].split(" ").last)
      if decoded_token_data && User.find(decoded_token_data[:id])
        return decoded_token_data
      end
      return Authorization.social_auth(decoded_token_data, headers["Authorization"].split(" ").last)
    end
    nil
  end
end
