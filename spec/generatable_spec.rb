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

  describe '#generate_key_hash' do
    it 'can generate offsets' do
      enigma = Enigma.new

      expect(enigma.generate_key_hash).to be_a(Hash)
      expect(enigma.generate_key_hash.keys).to eq([:A, :B, :C, :D])
      expect(enigma.generate_key_hash.values[0]).to be_between(0, 99)
      expect(enigma.generate_key_hash.values.sum).to be < (396)
    end
  end

  describe '#generate_key_hash' do
    it 'generates a key hash' do
      enigma = Enigma.new

      expect(enigma.generate_key_hash).to be_a(Hash)
      expect(enigma.generate_key_hash.keys).to eq([:A, :B, :C, :D])
      expect(enigma.generate_key_hash.values[0]).to be_between(0, 99)
      expect(enigma.generate_key_hash.values.sum).to be < (396)
    end
  end

  describe '#generate_offset_hash' do
    it 'can generate offsets' do
      enigma = Enigma.new

      expect(enigma.generate_offset_hash).to be_a(Hash)
      expect(enigma.generate_offset_hash.keys).to eq([:A, :B, :C, :D])
      expect(enigma.generate_offset_hash.values[0]).to be_between(0, 9)
      expect(enigma.generate_offset_hash.values.sum).to be < (36)
    end
  end

  describe '#generate_shift_hash' do
    it 'can generate shifts' do
      enigma = Enigma.new

      expect(enigma.generate_shift_hash).to be_a(Hash)
      expect(enigma.generate_shift_hash.keys).to eq([:A, :B, :C, :D])
      expect(enigma.generate_shift_hash.values[0]).to be_between(0, 108)
      expect(enigma.generate_shift_hash.values.sum).to be < (432)
    end
  end
end