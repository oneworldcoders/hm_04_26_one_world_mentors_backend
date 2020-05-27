require "active_support/core_ext/string/inflections"
require "active_support/core_ext"
require "./lib/validation_error"


class Validation
  class << self
    def validate_blank(payload)
        messages=[]
        payload.each do |key, value|
            if value.blank?
                messages << { "#{key.camelize}": "Cannot be empty" }
            end
        end
        return messages
    end


    def validate_length(attribute, length, name)
      if attribute.size < length
        return { "#{name}": "length should be #{length} characters or more" }
      end
      nil
    end

    def sign_up_validate(payload)
      errors=[ self.validate_blank(payload),self.validate_length(payload["password"],8,"password")].compact.flatten
      raise ValidationError.new(errors) unless errors.empty?
    end

    def update_user_validate(payload)
      errors=[self.validate_blank(payload)].flatten
      raise ValidationError.new(errors) unless errors.empty?
    end
  end
end
