require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/encryptable'

RSpec.describe Encryptable do
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

      expect(enigma.generate_key_hash(enigma.generate_random_key)).to be_a(Hash)
      expect(enigma.generate_key_hash(enigma.generate_random_key).keys).to eq([:A, :B, :C, :D])
      expect(enigma.generate_key_hash(enigma.generate_random_key).values[0]).to be_between(0, 99)
      expect(enigma.generate_key_hash(enigma.generate_random_key).values.sum).to be < (396)
    end
  end

  describe '#generate_offset_hash' do
    it 'can generate offsets' do
      enigma = Enigma.new

      expect(enigma.generate_offset_hash(Date.today.strftime('%d%m%y'))).to be_a(Hash)
      expect(enigma.generate_offset_hash(Date.today.strftime('%d%m%y')).keys).to eq([:A, :B, :C, :D])
      expect(enigma.generate_offset_hash(Date.today.strftime('%d%m%y')).values[0]).to be_between(0, 9)
      expect(enigma.generate_offset_hash(Date.today.strftime('%d%m%y')).values.sum).to be < (36)
    end
  end

  describe '#generate_shift_hash' do
    it 'can generate shifts' do
      enigma = Enigma.new

      expect(enigma.generate_shift_hash).to be_a(Hash)
      expect(enigma.generate_shift_hash.keys).to eq([:shifts_array, :key, :date])
      expect(enigma.generate_shift_hash[:shifts_array].length).to eq(4)
    end
  end
end