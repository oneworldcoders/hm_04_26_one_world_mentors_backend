require "net/http"
require "uri"

class JsonWebToken
  class << self
    def verify(token)
      JWT.decode(token, nil,
                 true, # Verify the signature of this token
                 algorithm: "RS256",
                 iss: Rails.application.credentials.iss,
                 verify_iss: true,
                 aud: Rails.application.secrets.auth0_api_audience,
                 verify_aud: true) do |header|
        jwks_hash[header["kid"]]
      end
    rescue JWT::VerificationError, JWT::DecodeError
      return nil
    end

    def jwks_hash
      jwks_raw = Net::HTTP.get URI(Rails.application.credentials.jwks_url)
      jwks_keys = Array(JSON.parse(jwks_raw)["keys"])
      Hash[
        jwks_keys
          .map do |k|
          [
            k["kid"],
            OpenSSL::X509::Certificate.new(
              Base64.decode64(k["x5c"].first)
            ).public_key,
          ]
        end
      ]
    end

    def encode(payload, exp = 24.hours.from_now, secret = Rails.application.credentials.jwks_url)
      payload[:exp] = exp.to_i
      JWT.encode(payload, secret)
    end

    def decode(token)
      body = JWT.decode(token, secret = Rails.application.credentials.jwks_url)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end
  end
end
