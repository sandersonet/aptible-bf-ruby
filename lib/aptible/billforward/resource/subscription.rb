module Aptible
  module BillForward
    class Subscription < Resource
      def serialize
        to_attrs
      end

      def usage_periods(params = {})
        @usage_periods ||= Aptible::BillForward::UsagePeriod.by_subscription_id(id)
      end

      def usage_sessions(params = {})
        @usage_sessions ||=
        Aptible::BillForward::UsageSession.by_subscription_id(id)
      end

      def usage(params = {})
        @usage ||= Aptible::BillForward::Usage.by_subscription_id(id)
      end

      def create_usage_session(params = {})
        usage_params = params.merge(
          subscriptionID: id,
          sessionID: Aptible::BillForward::UsageSession.generate_session_id,
        )
        Aptible::BillForward::UsageSession.create(usage_params)
      end

      def link_payment_method(payment_method)
        Aptible::BillForward::PaymentMethodSubscriptionLink.create(
          { subscriptionID: id, paymentMethodID: payment_method.id }
        )
      end

      def self.by_account_id(account_id, params = {})
        client.get "#{collection_path}/account/#{account_id}", params
      end

      def href
        "#{self.class.collection_path}"
      end
    end
  end
end