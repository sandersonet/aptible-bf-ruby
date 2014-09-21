require 'sawyer'
require 'aptible/billforward/serializer'

module Aptible
  module BillForward
    class Client
      include BillForward::Defaults
      attr_reader :agent
      attr_reader :last_response

      def get(url, query = {})
        request :get, url, nil, { query: query }
      end

      def post(url, resource, query = {})
        request(:post, url, resource, { query: query }).first
      end

      def put(url, resource, query = {})
        request :put, url, resource
      end

      def patch(url, options = {})
        request :patch, url, options
      end

      def delete(url, options = {})
        request :delete, url, options
      end

      def head(url, options = {})
        request :head, url, options
      end

       def agent
        @agent ||= Sawyer::Agent.new(api_endpoint, sawyer_options) do |http|
          http.headers[:accept] = media_type
          http.headers[:user_agent] = user_agent
          http.headers[:authorization] = "Bearer #{access_token}"
        end
      end

      private

      def sawyer_options
        {
          faraday: Faraday.new(connection_options),
          serializer: Aptible::BillForward::Serializer.any_json
        }
      end

      def request(method, path, data, options = {})
        options[:headers] ||= {}
        unless method == :get
          options[:headers][:content_type] = 'application/json'
        end

        @last_response = agent.call(method, path, data, options)
        @last_response.data
      end
    end
  end
end
