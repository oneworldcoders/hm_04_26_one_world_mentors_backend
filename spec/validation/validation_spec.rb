require "./lib/validation"

RSpec.describe Validation do
  context "validate_blank" do
    it "should return error message if attribute is nil" do
      expect(Validation.validate_blank("", "name")).to eql(:name => "Cannot be empty")
    end
    it "should return nil if attribute isnot nil" do
      expect(Validation.validate_blank("not nil", "name")).to eql(nil)
    end
  end

  context "validate_length" do
    it "should return error message if attribute length is not greater than specified" do
      expect(Validation.validate_length("five", 8, "password")).to eql(:password => "length should be 8 characters or more")
    end
    it "should return nil if attribute length is greater than specified" do
      expect(Validation.validate_length("morethaneight", 8, "password")).to eql(nil)
    end
  end

  context "sign_up_validate" do
    missing_user_attribute_values = {
      "first_name": "",
      "last_name": "",
      "email": "ken1@gmail.com",
      "password": "",
      "user_type": "mentor",
    }
    user_attribute = {
      "first_name" => "firstname",
      "last_name" => "lastname",
      "email" => "ken1@gmail.com",
      "user_type" => "mentor",
      "password" => "password123",
    }
    it "should return error message if attributes are invalid" do
      expect(Validation.sign_up_validate(missing_user_attribute_values)).not_to be_empty
    end
    it "should return nil if attribute length is greater than specified" do
      expect(Validation.sign_up_validate(user_attribute)).to be_empty
    end
  end

  context "update_user_validate" do
    missing_user_attribute_values = {
      "first_name": "",
      "last_name": "",
      "email": "ken1@gmail.com",
      "user_type": "mentor",
    }
    user_attribute = {
      "first_name" => "firstname",
      "last_name" => "lastname",
      "email" => "ken1@gmail.com",
      "user_type" => "mentor",
    }
    it "should return error message if attributes are invalid" do
      expect(Validation.update_user_validate(missing_user_attribute_values)).not_to be_empty
    end
    it "should return nil if attribute length is greater than specified" do
      expect(Validation.update_user_validate(user_attribute)).to be_empty
    end
  end
end
