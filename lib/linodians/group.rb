require 'delegate'

module Linodians
  ##
  # Group of employees
  class Group < Delegator
    attr_reader :members
    alias_method :__getobj__, :members

    def initialize
      @members = Linodians.download_data
      super(@members)
    end

    def __setobj__(_)
      @members
    end
  end
end
