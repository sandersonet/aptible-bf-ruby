module Aptible
  module BillForward
    class Subscription < Resource
      def usage_periods(params = {})
        Aptible::BillForward::UsagePeriod.by_subscription_id(
          params.merge(subscription_id: id)
        )
      end

      def usage_sessions(params = {})
        Aptible::BillForward::UsageSession.by_subscription_id(
          params.merge(subscription_id: id)
        )
      end

      def create_usage_session(params = {})
        usage_params = params.merge(
          subscriptionID: id,
          sessionID: Aptible::BillForward::UsageSession.generate_session_id,
        )
        Aptible::BillForward::UsageSession.create(usage_params)
      end
    end
  end
end