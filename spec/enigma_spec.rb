require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/generatable'

RSpec.describe Enigma do
  before do
    @enigma = Enigma.new
  end

  describe '#initialize' do
    it 'exists' do

      expect(@enigma).to be_a(Enigma)
    end
  end

  describe '#encrypt' do
    it 'returns a hash including the encrypted message, key, and date' do
      expect(@enigma.encrypt('hello world')).to be_a(Hash)
      expect(@enigma.encrypt('hello world').keys).to eq([:message, :key, :date])
    end
    it 'returns a key that is a 5 digit number rendered as a string' do
      expect(@enigma.encrypt('hello world')[:key].length).to eq(5)
      expect(@enigma.encrypt('hello world')[:key]).to be_a(String)
      expect(@enigma.encrypt('hello world')[:key].to_i).to be_between(0, 99_999)
    end
    it 'returns a date that is formated as DDMMYY and is rendered as a string' do
      expect(@enigma.encrypt('hello world')[:date].length).to eq(6)
      expect(@enigma.encrypt('hello world')[:date]).to be_a(String)
      expect(@enigma.encrypt('hello world')[:date].slice(0..1).to_i).to be < (32)
      expect(@enigma.encrypt('hello world')[:date].slice(2..3).to_i).to be < (13)
    end
    it 'encrypts the message based on the provided key and date' do
      expect(@enigma.encrypt('hello world.', '02715', '040895')[:message]).to eq('keder ohulw.')
    end
    it 'has optional key and date parameters' do
      expect(@enigma.encrypt('hello world')).to be_a(Hash)
      expect(@enigma.encrypt('heLlo wOrld.', '02715', '040895')[:message]).to eq('keder ohulw.')
    end
    it 'skips non-alphabetical characters except space and downcases the message' do
      expect(@enigma.encrypt('heLlo wO!!!!ld.', '02715', '040895')[:message]).to eq('keder oh!!!!od.')
    end
  end

  describe '#decrypt' do
    it 'returns a hash including the encrypted message, key, and date' do
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895')).to be_a(Hash)
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895').keys).to eq([:message, :key, :date])
    end
    it 'returns a key that is a 5 digit number rendered as a string' do
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895')[:key].length).to eq(5)
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895')[:key]).to be_a(String)
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895')[:key].to_i).to be_between(0, 99_999)
    end
    it 'returns a date that is formated as DDMMYY and is rendered as a string' do
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895')[:date].length).to eq(6)
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895')[:date]).to be_a(String)
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895')[:date].slice(0..1).to_i).to be < (32)
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895')[:date].slice(2..3).to_i).to be < (13)
    end
    it 'decrypts the message based on the provided key and date' do
      expect(@enigma.decrypt('keder ohulw.', '02715', '040895')[:message]).to eq('hello world.')
    end
    it 'has an optional date parameter' do
      expect(@enigma.decrypt('qgfaxbqd ny!?#', '02715')[:message]).to eq('hello world!?#')
    end
    it 'skips non-alphabetical characters except spaces' do
      expect(@enigma.decrypt('qgfaxbqd ny!?#', '02715')[:message]).to eq('hello world!?#')
    end
  end

  describe '#transform_message' do
    it 'takes a message array and encrypts/decrypts it based on a provided shifts array' do
      expect(@enigma.transform_message(['h', 'e', 'l', 'l', 'o'], [3, 27, 73, 20])).to eq('keder')
      expect(@enigma.transform_message(['k', 'e', 'd', 'e', 'r'], [-3, -27, -73, -20])).to eq('hello')
    end
  end
end