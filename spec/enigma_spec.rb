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