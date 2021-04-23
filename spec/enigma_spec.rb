require 'simplecov'
SimpleCov.start
require './lib/enigma'

RSpec.describe Enigma do
  describe '#initialize' do
    it 'exists' do
      enigma = Enigma.new

      expect(enigma).to be_a(Enigma)
    end
  end

  describe '#encrypt' do
    it 'returns a hash including the encrypted message, key, and date' do
      enigma = Enigma.new

      expect(enigma.encrypt('hello world')).to be_a(Hash)
      expect(enigma.encrypt('hello world')).to be_a(Hash)
      expect(enigma.encrypt('hello world')[:key].length).to eq(5)
      expect(enigma.encrypt('hello world')[:key]).to be_a(String)
      expect(enigma.encrypt('hello world')[:key].to_i).to be_between(0, 99_999)
      expect(enigma.encrypt('hello world')[:date].length).to eq(6)
      expect(enigma.encrypt('hello world')[:date]).to be_a(String)
      expect(enigma.encrypt('hello world')[:date].slice(0..1).to_i).to be < (32)
      expect(enigma.encrypt('hello world')[:date].slice(2..3).to_i).to be < (13)
    end
  end

  #move this to a module
  describe '#generate_random_key' do
    it 'can generate a random 5 digit number' do
      enigma = Enigma.new

      expect(enigma.generate_random_key.length).to eq(5)
      expect(enigma.generate_random_key).to be_a(String)
      expect(enigma.generate_random_key.to_i).to be_between(0, 99_999)
    end
  end
end