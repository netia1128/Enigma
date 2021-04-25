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
    @shifts_hash_key_index = {'0' => [' ', 26] , '1' => ['e', 4], '2' => ['n', 13], '3' => ['d', 3]}
    @key = ''
    determine_shifts_hash_placement_for_cracker_target
  end

  def finalize_cracked_shifts_hash
    @shifts_hash.each_with_index do |(key, value), index|
      encrypted_letter_range_index = @range.index(value[0])
      decrypted_letter_range_index = @shifts_hash_key_index[value[1].to_s][1]
      @shifts_hash[key] = if encrypted_letter_range_index >= decrypted_letter_range_index
        encrypted_letter_range_index - decrypted_letter_range_index
      else
        altered_range = @range.rotate(encrypted_letter_range_index - decrypted_letter_range_index)
        altered_range.reverse.index(@shifts_hash_key_index[value[1].to_s][0])
      end
    end
  end

  private

  def determine_shifts_hash_placement_for_cracker_target
    @cracker_target.each do |letter|
      case @encrypted_message.rindex(letter) % 4
      when 0
        @shifts_hash[:A] = [letter, @cracker_target.index(letter)]
      when 1
        @shifts_hash[:B] = [letter, @cracker_target.index(letter)]
      when 2
        @shifts_hash[:C] = [letter, @cracker_target.index(letter)]
      else
        @shifts_hash[:D] = [letter, @cracker_target.index(letter)]
      end
    end
    finalize_cracked_shifts_hash
  end
end