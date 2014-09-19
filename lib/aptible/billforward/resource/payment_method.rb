module Aptible
  module BillForward
    class PaymentMethod < Resource
      def self.basename
        'payment-methods'
      end

      def serialize
        to_attrs
      end

      def self.by_account_id(account_id, params = {})
        client.get "#{collection_path}/account/#{account_id}", params
      end
    end
  end
end