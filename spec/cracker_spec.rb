require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/cracker'
require './lib/generatable'

RSpec.describe Cracker do
  describe '#initialize' do
    it 'exists' do
      cracker = Cracker.new('keder ohulwthnw', '040895')

      expect(cracker).to be_a(Cracker)
    end
    #perhpas a 'has attributes' test here?
  end

#message sent to instructors for help with this
  describe '#determine_shift_hash_order' do
    it 'determines the shift letter for the last four letters of the message' do
      cracker = Cracker.new('keder ohulwthnw', '040895')
      pre_shifts_hash = { :A => ['h', 1],
                          :B => ['n', 2],
                          :C => ['w', 3],
                          :D => ['t', 0] }

      expect(cracker.determine_shift_hash_order).to be_a(Hash)
      expect(cracker.determine_shift_hash_order).to eq(pre_shifts_hash)
    end
  end

  describe '#determine_shifts_hash' do
    it 'cracks the shift hash for the encrypted message' do
      cracker = Cracker.new('keder ohulwthnw', '040895')
      pre_shifts_hash = { :A => ['h', 1],
                          :B => ['n', 2],
                          :C => ['w', 3],
                          :D => ['t', 0] }
      shifts_hash = { A: 3, B: 0, C: 19, D: 20 }

      expect(cracker.determine_shifts_hash(pre_shifts_hash)).to eq(shifts_hash)
    end
  end

  describe '#determine_key_hash' do
    it 'generates a non-negative key hash' do
      cracker = Cracker.new('keder ohulwthnw', '040895')
      shifts_hash = { A: 3, B: 0, C: 19, D: 20 }
      key_hash = {:A=>2, :B=>0, :C=>17, :D=>15}

      expect(cracker.determine_key_hash(shifts_hash)).to eq(key_hash)
    end
  end

  describe '#determine_key_array' do
    it 'turns the key hash into a formatted array' do
      cracker = Cracker.new('keder ohulwthnw', '040895')
      key_hash = {:A=>2, :B=>0, :C=>17, :D=>15}
      key_array = ["02", "00", "17", "15"]

      expect(cracker.determine_key_array(key_hash)).to eq(key_array)
    end
  end

  describe '#determine_key' do
    it 'finds the key' do
      cracker1 = Cracker.new('keder ohulwthnw', '040895')
      cracker2 = Cracker.new('w xqcvhtfgpetip', '260421')
      cracker3 = Cracker.new('rxfeysqhadytofy', '260421')
      cracker4 = Cracker.new('ctdnjooqm wb bw', '260421')
      cracker5 = Cracker.new('ajsvhecykqkjysk', '240421')


      expect(cracker1.determine_key).to eq('02715')
      expect(cracker2.determine_key).to eq('62085')
      expect(cracker3.determine_key).to eq('84446')
      expect(cracker4.determine_key).to eq('69428')
      expect(cracker5.determine_key).to eq('40309')
    end
  end

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
