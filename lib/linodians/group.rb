module Linodians
  ##
  # Group of employees
  class Group
    attr_reader :members
    def initialize
      @members = Linodians.download_data
    end
  end
end
