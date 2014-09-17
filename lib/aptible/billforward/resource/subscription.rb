module Aptible
  module BillForward
    class Subscription < Resource
      def usage_sessions
        Aptible::BillForward::UsageSession.by_subscription_id(
          subscription_id: id,
          active: true
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