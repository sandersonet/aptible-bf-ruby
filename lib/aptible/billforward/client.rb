require 'sawyer'
require 'aptible/billforward/client/invoices'
require 'pry'

module Aptible
  module BillForward
    class Client
      include BillForward::Defaults
      include BillForward::Client::Invoices

      def get(url, options = {})
        request :get, url, options
      end

      def post(url, options = {})
        request :post, url, options
      end

      def put(url, options = {})
        request :put, url, options
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

      private

      def agent
        @agent ||= Sawyer::Agent.new(api_endpoint, sawyer_options) do |http|
          http.headers[:accept] = media_type
          http.headers[:content_type] = 'application/json'
          http.headers[:user_agent] = user_agent
          http.headers[:authorization] = "Bearer #{access_token}"
        end
      end

      def sawyer_options
        { faraday: Faraday.new(connection_options) }
      end

      def request(method, path, data, options = {})
        path = URI::Parser.new.escape(path.to_s)
        @last_response = agent.call(method, path, data, options)
        @last_response.data.results
      end
    end
  end
end
