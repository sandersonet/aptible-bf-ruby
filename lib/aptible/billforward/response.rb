require 'logger'

module Sawyer
  class Response
     def initialize(agent, res, options = {})
      @res = res
      @agent   = agent
      @status  = res.status
      @headers = res.headers
      @env     = res.env
      @data    = @headers[:content_type] =~ /json|msgpack/ ? process_data(@agent.decode_body(res.body)) : res.body
      @rels    = process_rels
      @started = options[:sawyer_started]
      @ended   = options[:sawyer_ended]
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