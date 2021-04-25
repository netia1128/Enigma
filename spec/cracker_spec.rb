require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/cracker'
require './lib/generatable'

RSpec.describe Cracker do
  describe '#initialize' do
    it 'exists' do
      cracker = Cracker.new('hello world end', '040895')

      expect(cracker).to be_a(Cracker)
    end
    #perhpas a 'has attributes' test here?
    #but what if i dont need my attributes in my attr_reader?
  end

  describe '#determine_shifts_hash_placement_for_cracker_target' do
    it 'determines which shift each letter in the craker target belongs to' do
      cracker = Cracker.new('hello world end', '040895')

      expect(cracker.shifts_hash.count).to eq(4)
      expect(cracker.shifts_hash[:A]).to be_a(String)
    end
    #perhpas a 'has attributes' test here?
    #but what if i dont need my attributes in my attr_reader?
  end
end
