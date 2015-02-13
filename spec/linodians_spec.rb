require 'spec_helper'

describe Linodians do
  describe '#new' do
    it 'creates Group objects' do
      expect(Linodians.new).to be_an_instance_of Linodians::Group
    end
  end
end
