require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/generatable'

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
      expect(enigma.encrypt('hello world.', '02715', '040895')[:message]).to eq('keder ohulw.')
      expect(enigma.encrypt('hello world')[:key].length).to eq(5)
      expect(enigma.encrypt('hello world')[:key]).to be_a(String)
      expect(enigma.encrypt('hello world')[:key].to_i).to be_between(0, 99_999)
      expect(enigma.encrypt('hello world')[:date].length).to eq(6)
      expect(enigma.encrypt('hello world')[:date]).to be_a(String)
      expect(enigma.encrypt('hello world')[:date].slice(0..1).to_i).to be < (32)
      expect(enigma.encrypt('hello world')[:date].slice(2..3).to_i).to be < (13)
    end
  end

  describe '#decrypt' do
    it 'returns a hash including the encrypted message, key, and date' do
      enigma = Enigma.new

      expect(enigma.decrypt('keder ohulw.', '02715', '040895')).to be_a(Hash)
      expect(enigma.decrypt('keder ohulw.', '02715', '040895')[:message]).to eq('hello world.')
      expect(enigma.decrypt('keder ohulw.', '02715', '040895')[:key].length).to eq(5)
      expect(enigma.decrypt('keder ohulw.', '02715', '040895')[:key]).to be_a(String)
      expect(enigma.decrypt('keder ohulw.', '02715', '040895')[:key].to_i).to be_between(0, 99_999)
      expect(enigma.decrypt('keder ohulw.', '02715', '040895')[:date].length).to eq(6)
      expect(enigma.decrypt('keder ohulw.', '02715', '040895')[:date]).to be_a(String)
      expect(enigma.decrypt('keder ohulw.', '02715', '040895')[:date].slice(0..1).to_i).to be < (32)
      expect(enigma.decrypt('keder ohulw.', '02715', '040895')[:date].slice(2..3).to_i).to be < (13)
    end
  end
end