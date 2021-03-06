require_relative 'enigma'

class Cracker
  include Generatable
  attr_reader :key

  def initialize(encrypted_message, date)
    @encrypted_message = encrypted_message
    @decrypted_message = ''
    @date = date
    @key_arr = []
    @key = ''
    cracker_sequence
  end

  def cracker_sequence
    pre_shifts_hash = determine_shift_hash_order
    shifts_hash = determine_shifts_hash(pre_shifts_hash)
    key_hash = determine_key_hash(shifts_hash)
    key_array = determine_key_array(key_hash)
    @key = determine_key
  end

  def determine_shift_hash_order
    pre_shifts_hash = {}
    index = -4
    4.times do
      letter = @encrypted_message.slice(index)
        case (@encrypted_message.length + index) % 4
        when 0
          pre_shifts_hash[:A] = [letter, 4 + index]
        when 1
          pre_shifts_hash[:B] = [letter, 4 + index]
        when 2
          pre_shifts_hash[:C] = [letter, 4 + index]
        else
          pre_shifts_hash[:D] = [letter, 4 + index]
        end
      index += 1
    end
    pre_shifts_hash
  end

  def determine_shifts_hash(pre_shifts_hash)
    decryption_key = {'0' => [' ', 26] , '1' => ['e', 4], '2' => ['n', 13], '3' => ['d', 3]}
    range = ('a'..'z').to_a << " "
    shifts_hash = {}
    pre_shifts_hash.each_with_index do |(key, value), index|
      encrypted_letter = range.index(value[0])
      decrypted_letter = decryption_key[value[1].to_s]
      shifts_hash[key] = if encrypted_letter >= decrypted_letter[1]
        encrypted_letter - decrypted_letter[1]
      else
        altered_range = range.rotate(encrypted_letter + 1 - 27)
        26 - altered_range.index(decrypted_letter[0])
      end
    end
    shifts_hash
  end

  def determine_key_hash(shifts_hash)
    offset_hash = generate_offset_hash(@date)
      key_hash = {
      A: shifts_hash[:A] - offset_hash[:A],
      B: shifts_hash[:B] - offset_hash[:B],
      C: shifts_hash[:C] - offset_hash[:C],
      D: shifts_hash[:D] - offset_hash[:D]
    }

    key_hash.each do |key, value|
      if value.to_i < 0
        key_hash[key] = (value.to_i + 27)
      end
    end
  end

  def determine_key_array(key_hash)
    @key_arr = [key_hash[:A], key_hash[:B], key_hash[:C], key_hash[:D]]
    @key_arr = @key_arr.map do |num|
      '%02d' % num
    end
  end

  def determine_key
    index = 0
    3.times do
      manipulate_key_array(index)
      until @key_arr[index][1] == @key_arr[index + 1][0]
            @key_arr[0] = (@key_arr[0].to_i + 27).to_s
            manipulate_key_array(index)
      end
      index += 1
    end
    @key = "#{@key_arr[0]}#{@key_arr[2]}#{@key_arr[3][1]}"
  end

  private

  def manipulate_key_array(index)
      key_arr_start = @key_arr[index + 1]
      until @key_arr[index + 1].to_i + 27 > 99 || @key_arr[index][1] == @key_arr[index + 1][0]
        @key_arr[index + 1] = (@key_arr[index + 1].to_i + 27).to_s
      end
      if @key_arr[index][1] == @key_arr[index + 1][0]
        @key_arr[index + 1]
      else
        @key_arr[index + 1] = key_arr_start
      end
  end
end