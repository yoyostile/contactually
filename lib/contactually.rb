require "contactually/version"
require "json"
require "rest_client"

module Contactually
  class API

    BASE_URI = "https://www.contactually.com/api/v1"

    def initialize(api_key)
      @api_key = api_key
    end

    def call(method, args)
      parsed_response = make_call(method, args)
      parsed_response
    end

    def method_missing(method, *args)
      args = {} if args.class == Array
      call(method, args)
    end

    private
    def param_fields(args)
      params = {}
      params = args.first.merge(params) if args.first
      params
    end

    def make_call(method, args={})
      http_method, contactually_method = get_methods(method)
      uri = build_uri(contactually_method, args)
      if http_method.to_sym == :post
        response = RestClient.send(http_method.to_sym, uri, param_fields(args).to_json, content_type: :json)
      else
        response = RestClient.send(http_method.to_sym, uri, param_fields(args))
      end
      JSON.load response
    end

    def build_uri(contactually_method, args={})
      if args[:id]
        "#{BASE_URI}/#{contactually_method}/#{args[:id]}.json?api_key=#{@api_key}"
      else
        "#{BASE_URI}/#{contactually_method}.json?api_key=#{@api_key}"
      end
    end

    def get_methods(method)
      methods = method.to_s.split("_", 2)
    end

  end
end
