require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/generatable'

RSpec.describe Generatable do
  describe '#generate_random_key' do
    it 'can generate a random 5 digit number' do
      enigma = Enigma.new

      expect(enigma.generate_random_key.length).to eq(5)
      expect(enigma.generate_random_key).to be_a(String)
      expect(enigma.generate_random_key.to_i).to be_between(0, 99_999)
    end
  end
end