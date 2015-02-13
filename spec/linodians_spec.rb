require 'spec_helper'

require 'json'

describe Linodians do
  describe '#new' do
    it 'creates Group objects' do
      VCR.use_cassette('new_data') do
        expect(Linodians.new).to be_an_instance_of Linodians::Group
      end
    end
  end

  describe '#load_data' do
    let(:saved_data) { File.open('spec/examples/data') { |fh| JSON.load fh } }
    let(:new_data) { VCR.use_cassette('new_data') { Linodians.load_data } }

    it 'downloads data from linode.com' do
      expect(new_data).to be_an_instance_of Array
      expect(new_data.first).to be_an_instance_of Linodians::Employee
    end

    it 'accepts data as input' do
      data = Linodians.load_data(saved_data)
      expect(data).to be_an_instance_of Array
      expect(data.first).to be_an_instance_of Linodians::Employee
    end
  end
end
