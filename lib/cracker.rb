class Cracker
  include Generatable
  attr_reader :shifts_hash

  def initialize(encrypted_message, date)
    @encrypted_message = encrypted_message
    @decrypted_message = ''
    @cracker_target = encrypted_message.slice(-4..-1).split('')
    @date = date
    @range = ('a'..'z').to_a << " "
    @shifts_hash = {}
    @shifts_hash_value_arr = [4, 13, 3, 26]
    @key = ''
    determine_shifts_hash_placement_for_cracker_target
  end

  def determine_shifts_hash_placement_for_cracker_target
    @cracker_target.each do |letter|
      case @encrypted_message.rindex(letter) % 4
      when 0
        @shifts_hash[:A] = letter
      when 1
        @shifts_hash[:B] = letter
      when 2
        @shifts_hash[:C] = letter
      else
        @shifts_hash[:D] = letter
      end
    end
  end
end