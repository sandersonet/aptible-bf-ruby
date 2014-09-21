require 'logger'
require 'aptible/billforward/exceptions'

module Sawyer
  class Response
     def initialize(agent, res, options = {})
      if res.status >= 400
        binding.pry
        raise Aptible::BillForward::ResponseError.new(@status.to_s,
          response: @res,
          body: @data,
          cause: @status
        )
      end
      @res = res
      @agent = agent
      @status = res.status
      @headers = res.headers
      @env = res.env
      @rels = process_rels
      @started = options[:sawyer_started]
      @ended = options[:sawyer_ended]
      @data = if @headers[:content_type] =~ /json|msgpack/
                process_data(@agent.decode_body(res.body))
              else
                res.body
              end
    end

    def process_data(data)
      data = data[:results] if data.key? :results
      case data
      when Hash  then klass_from_type(data).new(agent, data)
      when Array then data.map { |hash| process_data(hash) }
      when nil   then nil
      else data
      end
    end

    def klass_from_type(result)
      "Aptible::BillForward::#{result[:@type].classify}".constantize
    end
  end
end

# {:errorType=>"ValidationError",
#  :errorMessage=>
#   "Validation Error - Entity: PaymentMethodSubscriptionLink Field: paymentMethodID Value: null Message: may not be null\nValidation Error - Entity: PaymentMethodSubscriptionLink Field: subscription Value: null Message: may not be null\n",
#  :errorParameters=>["paymentMethodID", "subscription"]}