require 'spec_helper'

describe Linodians::Group do
  let(:group) { VCR.use_cassette('new_data') { Linodians::Group.new } }

  describe '@members' do
    it 'is an array' do
      expect(group.members).to be_an_instance_of Array
    end

    it 'is frozen' do
      expect(group.members.frozen?).to be_truthy
    end

    it 'contains employees' do
      expect(group.members).to all(be_an_instance_of(Linodians::Employee))
    end
  end

  describe '#lookup' do
    it 'looks up employees' do
      expect(group.lookup('jstitt').username).to eql 'jstitt'
    end

    it 'returns nil if no match exists' do
      expect(group.lookup('akerl')).to be_nil
    end
  end

  it 'proxies methods to @members' do
    expect(group.size).to be_a Numeric
    expect(group.size).to be > 1
  end

  it 'raises if the method does not exist' do
    expect { group.fake }.to raise_error NoMethodError
  end

  it 'correctly responds to respond_to?' do
    expect(group.respond_to?(:size)).to be_truthy
    expect(group.respond_to?(:fake)).to be_falsey
  end
end
