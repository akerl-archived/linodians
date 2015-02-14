require 'spec_helper'

describe Linodians::Employee do
  let(:employee) do
    VCR.use_cassette('new_data') { Linodians::Group.new.lookup('rohara') }
  end

  describe '#photo' do
    let(:photo) { VCR.use_cassette('photo') { employee.photo } }

    it 'returns a string' do
      expect(photo).to be_an_instance_of String
    end

    it 'is a PNG' do
      expect(photo).to match "\x89PNG".force_encoding('binary')
    end
  end

  describe '#[]' do
    it 'accesses the employee info' do
      expect(employee[:twitter]).to eql 'sirrohara'
    end

    it 'supports strings as keys' do
      expect(employee['twitter']).to eql 'sirrohara'
    end

    it 'supports symbols as keys' do
      expect(employee[:twitter]).to eql 'sirrohara'
    end

    it 'returns nil if the key does not exist' do
      expect(employee[:other]).to be_nil
    end
  end

  describe '#to_json' do
    it 'returns data as json' do
      expect(JSON.parse(employee.to_json)).to be_an_instance_of Hash
    end
  end

  describe '#respond_to?' do
    it 'truthfully responds for proxied methods' do
      expect(employee.respond_to? :twitter).to be_truthy
    end

    it 'returns false for methods that it cannot handle' do
      expect(employee.respond_to? :other).to be_falsey
    end
  end

  describe '#to_h' do
    it 'returns a hash' do
      expect(employee.to_h).to be_an_instance_of Hash
    end

    it 'dups to allow modification' do
      copy = employee.to_h
      copy[:new_key] = :data
      expect(copy[:new_key]).to eql :data
      expect(employee[:new_key]).to be_nil
    end
  end

  it 'proxies methods as data hash keys' do
    expect(employee.twitter).to eql 'sirrohara'
  end
end
