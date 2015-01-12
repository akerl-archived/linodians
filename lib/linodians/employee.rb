module Linodians
  ##
  # Employee object
  class Employee
    def initialize(params = {})
      @raw = params
    end

    def [](value)
      @raw[value.to_sym] || @raw[value.to_s]
    end

    def respond_to?(method, _)
      @raw.key?(method) || super
    end

    def method_missing(method, *args, &block)
      return super unless @raw.key?(method)
      instance_eval "def #{method}() @raw[:'#{method}'] end"
      send(method)
    end
  end
end
