require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/cracker'
require './lib/generatable'

RSpec.describe Cracker do
  describe '#initialize' do
    it 'exists' do
      # cracker = Cracker.new('ctdnjooqm wb bw', '260421')
      # cracker = Cracker.new('keder ohulwthnw', '040895')
      # cracker = Cracker.new('ajsvhecykqkjysk', '240421')
      # cracker = Cracker.new('bvpeiq hlbhtzdh', '260421')
      cracker = Cracker.new('w xqcvhtfgpetip', '260421')
      # cracker = Cracker.new('rxfeysqhadytofy', '260421')

      expect(cracker).to be_a(Cracker)
    end
    #perhpas a 'has attributes' test here?
    #but what if i dont need my attributes in my attr_reader?
  end

  #should I test this somehow? Issue is, by the time I call it, the shift hash values have
  #already changed to the values from #finalize_cracked_shifts_array
  #ask instructors for help with approach
  # describe '#determine_shifts_hash_placement_for_cracker_target' do
  #   it 'determines which shift each letter in the craker target belongs to' do
  #     cracker = Cracker.new('keder ohulwthnw', '040895')

  #     expect(cracker.shifts_hash.count).to eq(4)
  #     expect(cracker.shifts_hash[:A]).to be_a(Array)
  #     expect(cracker.shifts_hash[:A][1]).to be_a(Integer)
  #     expect(cracker.shifts_hash[:A][0]).to be_a(String)
  #   end
  # end

  # describe '#finalize_cracked_shifts_hash' do
  #   it 'determines final shifts that can be used for decrypting' do
  #     # cracker = Cracker.new('ctdnjooqm wb bw', '260421')
  #     # cracker = Cracker.new('keder ohulwthnw', '040895')
  #     cracker = Cracker.new('rxfeysqhadytofy', '260421')

  #     expect(cracker.shifts_hash.count).to eq(4)
  #     expect(cracker.shifts_hash[:A]).to be_a(Integer)
  #     expect(cracker.shifts_hash[:A]).to be < (28)
  #   end
  # end

  # describe '#decrypt_message' do
  #   it 'decrypts the message' do
  #     # cracker = Cracker.new('ctdnjooqm wb bw', '260421')
  #     # cracker = Cracker.new('keder ohulwthnw', '040895')
  #     cracker = Cracker.new('rxfeysqhadytofy', '260421')

  #     expect(cracker.shifts_hash.count).to eq(4)
  #     expect(cracker.shifts_hash[:A]).to be_a(Integer)
  #     expect(cracker.shifts_hash[:A]).to be < (28)
  #   end
  # end
end
