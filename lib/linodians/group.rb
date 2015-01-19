require 'delegate'

module Linodians
  ##
  # Group of employees
  class Group < Delegator
    attr_reader :members
    alias_method :__getobj__, :members

    def initialize(data = nil)
      @members = data || Linodians.download_data
      @members.freeze
      super(@members)
    end

    def __setobj__(_)
      @members
    end
  end
end
