require "active_support/core_ext"

class Validation
  class << self
    def validate_blank(attribute, name)
      if attribute.blank?
        return { "#{name}": "Cannot be empty" }
      end
      nil
    end

    def validate_password(password)
      self.validate_blank(password, "password") || self.validate_length(password, 8, "password")
    end

    def validate_length(attribute, length, name)
      if attribute.size < length
        return { "#{name}": "length should be #{length} characters or more" }
      end
      nil
    end

    def sign_up_validate(payload)
      [
        self.validate_blank(payload["first_name"], "FirstName"),
        self.validate_blank(payload["user_type"], "UserType"),
        self.validate_blank(payload["last_name"], "LastName"),
        self.validate_password(payload["password"]),
      ].compact
    end

    def update_user_validate(payload)
      [
        self.validate_blank(payload["first_name"], "FirstName"),
        self.validate_blank(payload["user_type"], "UserType"),
        self.validate_blank(payload["last_name"], "LastName"),
      ].compact
    end
  end
end
