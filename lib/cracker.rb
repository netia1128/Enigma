require_relative 'enigma'

class Cracker
  include Generatable
  attr_reader :key,
              :shifts_hash

  def initialize(encrypted_message, date)
    @encrypted_message = encrypted_message
    @decrypted_message = ''
    @cracker_target = encrypted_message.slice(-4..-1).split('')
    @date = date
    @range = ('a'..'z').to_a << " "
    @shifts_hash = {}
    @shifts_hash_key_index = {'0' => [' ', 26] , '1' => ['e', 4], '2' => ['n', 13], '3' => ['d', 3]}
    @shifts_array = []
    @key_arr = []
    @key_arr_start = ''
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
        # altered_range = @range.rotate(encrypted_letter_range_index - decrypted_letter_range_index)
        altered_range = @range.rotate(encrypted_letter_range_index + 1 - 27)
        # require 'pry'; binding.pry
        26 - altered_range.index(@shifts_hash_key_index[value[1].to_s][0])
        # altered_range.reverse.index(@shifts_hash_key_index[value[1].to_s][0])
      end
    end
    @shifts_array = [-shifts_hash[:A], -shifts_hash[:B], -shifts_hash[:C], -shifts_hash[:D]]
    generate_key_hash
  end

  def generate_key_hash
    offset_hash = generate_offset_hash(@date)
      key_hash = {
      A: @shifts_hash[:A] - offset_hash[:A],
      B: @shifts_hash[:B] - offset_hash[:B],
      C: @shifts_hash[:C] - offset_hash[:C],
      D: @shifts_hash[:D] - offset_hash[:D]
    }

    key_hash.each do |key, value|
      if value.to_i < 0
        key_hash[key] = (value.to_i + 27)
      end
    end
    generate_key(key_hash)
  end

  def generate_key(key_hash)
    @key_arr = [key_hash[:A], key_hash[:B], key_hash[:C], key_hash[:D]]
    @key_arr = @key_arr.map do |num|
     '%02d' % num
    end
    index = 0
    big_attempts = 0
    small_attempts = 0

    until big_attempts == 3 do
      until small_attempts == 6 do
        if @key_arr[index][1] != @key_arr[index + 1][0]
          if small_attempts == 0
            try_getting_sides_to_match(index)
          elsif small_attempts == 1 && @key_arr[0].to_i + 27 < 99
            @key_arr[0] = (@key_arr[0].to_i + 27).to_s
            try_getting_sides_to_match(index)
          elsif small_attempts == 2 && @key_arr[1].to_i + 27 < 99
            @key_arr[1] = (@key_arr[1].to_i + 27).to_s
            try_getting_sides_to_match(index)
          elsif small_attempts == 3 && @key_arr[0].to_i + 27 < 99
            @key_arr[0] = (@key_arr[0].to_i + 27).to_s
            try_getting_sides_to_match(index)
          elsif small_attempts == 4 && @key_arr[1].to_i + 27 < 99
            @key_arr[1] = (@key_arr[1].to_i + 27).to_s
            try_getting_sides_to_match(index)
          elsif small_attempts == 5 && @key_arr[0].to_i + 27 < 99
            @key_arr[0] = (@key_arr[0].to_i + 27).to_s
            try_getting_sides_to_match(index)
          elsif small_attempts == 6 && @key_arr[1].to_i + 27 < 99
            @key_arr[1] = (@key_arr[1].to_i + 27).to_s
            try_getting_sides_to_match(index)
          end
        else
        end
        small_attempts +=1
      end
      index += 1
      big_attempts += 1
      small_attempts = 0
    end

    @key = "#{@key_arr[0]}#{@key_arr[2]}#{@key_arr[3][1]}"
  end

  def increment_right_side_to_match(index)
    until @key_arr[index + 1].to_i + 27 > 99 || @key_arr[index][1] == @key_arr[index + 1][0]
      @key_arr[index + 1] = (@key_arr[index + 1].to_i + 27).to_s
    end
  end

  def increment_left_side_to_match(index)
    until @key_arr[index].to_i + 27 > 99 || @key_arr[index][1] == @key_arr[index + 1][0]
      @key_arr[index] = (@key_arr[index].to_i + 27).to_s
    end
  end

  def note_key_start_value(index)
    @key_arr_start = @key_arr[index]
  end

  def reset_key_start_value(index)
    @key_arr[index] = @key_arr_start
  end

  def try_getting_sides_to_match(index)
    @key_arr_start = ''
    note_key_start_value(index)

    if index == 0
      increment_left_side_to_match(index)
    end

    if @key_arr[index][1] == @key_arr[index + 1][0]
      #if it worked, keep it
      @key_arr[index]
    else
      #if it didnt work, try resetting the left side incrementing the right side to match the left
      reset_key_start_value(index)
      note_key_start_value(index + 1)
      increment_right_side_to_match(index)

      if @key_arr[index][1] == @key_arr[index + 1][0]
        #if it worked, keep the right side set to whatever it is now
        @key_arr[index + 1]
      else
        #if it didn't work, reset the left side and go back to the big looper
        reset_key_start_value(index + 1)
      end
    end
  end

  private

  def determine_shifts_hash_placement_for_cracker_target

    index = -4
    4.times do
      letter = @encrypted_message.slice(index)
        case (@encrypted_message.length + index) % 4
        when 0
          @shifts_hash[:A] = [letter, 4 + index]
        when 1
          @shifts_hash[:B] = [letter, 4 + index]
        when 2
          @shifts_hash[:C] = [letter, 4 + index]
        else
          @shifts_hash[:D] = [letter, 4 + index]
        end
      index += 1
    end
    finalize_cracked_shifts_hash
    end
end