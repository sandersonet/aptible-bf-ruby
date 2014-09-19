module Aptible
  module BillForward
    class Account < Resource
      def serialize
        to_attrs
      end

      def create_payment_method(params)
        Aptible::BillForward::PaymentMethod.create(
          params.merge({ accountID: id })
        )
      end

      def create_subscription(params)
        Aptible::BillForward::Subscription.create(
          params.merge({ accountID: id })
        )
      end

      def payment_methods(params = {})
        Aptible::BillForward::PaymentMethod.by_account_id(id, params)
      end

      def subscriptions(params = {})
        Aptible::BillForward::Subscription.by_account_id(id, params)
      end
    end
  end
end