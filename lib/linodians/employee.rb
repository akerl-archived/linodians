require 'open-uri'

module Linodians
  ##
  # Employee object
  class Employee
    def initialize(params = {})
      @raw = params
    end

    def photo
      @photo ||= open(PHOTO_URL % username) { |x| x.read }
    end

    def [](value)
      @raw[value.to_sym] || @raw[value.to_s]
    end

    def to_json(*args, &block)
      @raw.to_json(*args, &block)
    end

    def respond_to?(method, _ = false)
      @raw.key?(method) || super
    end

    private

    def method_missing(method, *args, &block)
      return super unless @raw.key?(method)
      instance_eval "def #{method}() @raw[:'#{method}'] end"
      send(method)
    end
  end
end
