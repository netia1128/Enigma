require 'simplecov'
SimpleCov.start
require './lib/enigma'
require './lib/cracker'
require './lib/generatable'

RSpec.describe Cracker do
  describe '#initialize' do
    it 'exists' do
      cracker = Cracker.new

      expect(cracker).to be_a(Cracker)
    end
  end
end
