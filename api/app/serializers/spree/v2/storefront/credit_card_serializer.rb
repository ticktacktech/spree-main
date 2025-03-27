module Spree
  module V2
    module Storefront
      class CreditCardSerializer < BaseSerializer
        set_type :credit_card

        attributes :cc_type, :last_digits, :month, :year, :name, :default, :gateway_payment_profile_id, :public_metadata

        belongs_to :payment_method
      end
    end
  end
end
