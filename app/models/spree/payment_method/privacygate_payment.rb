require 'privacygate'
module Spree
  class PaymentMethod::PrivacyGatePayment < PaymentMethod
    preference :api_key, :string
    preference :api_version, :string
    preference :webhook_secret, :string

    def create_client
      PrivacyGate::Client.new(api_key: get_preference(:api_key),
                                   api_ver: get_preference(:api_version),
                                   api_url: api_uri)
    end

    def api_uri
      "https://api.privacygate.io"
    end
  end
end
