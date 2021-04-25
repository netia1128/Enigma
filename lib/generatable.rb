module Generatable

  def generate_random_key
    random_key = rand.to_s.slice(2..6)
  end

  def generate_key_hash(key)
    hash = {
      A: key.slice(0..1).to_i,
      B: key.slice(1..2).to_i,
      C: key.slice(2..3).to_i,
      D: key.slice(3..4).to_i
    }
  end

  def generate_offset_hash(date)
    offset_base = (date.to_i ** 2).to_s[-4..-1]
    hash = {
      A: offset_base.slice(0).to_i,
      B: offset_base.slice(1).to_i,
      C: offset_base.slice(2).to_i,
      D: offset_base.slice(3).to_i
    }
  end

  def generate_shift_hash(
                          key = generate_random_key,
                          date = Date.today.strftime('%d%m%y').to_i,
                          encrypt_decrypt_command
                         )
    key_hash = generate_key_hash(key)
    offset_hash = generate_offset_hash(date)
    shifts_array = [
      (key_hash[:A] + offset_hash[:A]) * encrypt_decrypt_command,
      (key_hash[:B] + offset_hash[:B]) * encrypt_decrypt_command,
      (key_hash[:C] + offset_hash[:C]) * encrypt_decrypt_command,
      (key_hash[:D] + offset_hash[:D]) * encrypt_decrypt_command,
    ]
    require 'pry'; binding.pry
    shifts_hash = {shifts_array: shifts_array, key: key, date: date}
  end

  def generate_cracked_key(message, date)
    range = ('a'..'z').to_a << " "
    shift_hash = {}
    offset_hash = generate_offset_hash(date)

    message.slice(-4..-1).split('').each do |letter|
      case message.rindex(letter) % 4
      when 0
        shift_hash[:A] = if range.index(letter) >= 4
          range.index(letter) - 4
        else
          range.rotate(range.index(letter) - 4).reverse.index(' ')
        end
      when 1
        shift_hash[:B] = if range.index(letter) >= 13
          range.index(letter) - 13
        else
          range.rotate(range.index(letter) - 13).reverse.index(' ')
        end
      when 2
        shift_hash[:C] = if range.index(letter) >= 3
          range.index(letter) - 3
        else
          range.rotate(range.index(letter) - 3).reverse.index(' ')
        end
      else
        shift_hash[:D] = if range.index(letter) == 26
          0
        else
          range.rotate(range.index(letter) - 26).reverse.index(' ')
        end
      end
    end

    shifts_array = [shift_hash[:A].to_i, shift_hash[:B].to_i, shift_hash[:C].to_i, shift_hash[:D].to_i]

    shifts_array = shifts_array.map do |element|
      element * -1
    end

  #   key_hash = {
  #     A: shift_hash[:A] - offset_hash[:A],
  #     B: shift_hash[:B] - offset_hash[:B],
  #     C: shift_hash[:C] - offset_hash[:C],
  #     D: shift_hash[:D] - offset_hash[:D]
  #   }

  #   key_arr = [key_hash[:A], key_hash[:B], key_hash[:C], key_hash[:D]]

  #   key_arr = key_arr.map do |key|
  #     key.to_s
  #   end

  #   if key_arr[0].to_i < 10
  #     key_arr[0] = '0' + key_arr[0]
  #   end

  #   if key_arr[1].to_i == 0
  #     key_arr[1] = '7'
  #   elsif key_arr[1].to_i < 10
  #     key_arr[1]
  #   else
  #     if key_arr[0].include?(key_arr[1][0])
  #       key_arr[1] = key_arr[1][1]
  #     else
  #       key_arr[1] = key_arr[1][0]
  #     end
  #   end

  #   if key_arr[2].to_i < 10
  #     key_arr[2]
  #   else
  #     if key_arr[1].include?(key_arr[2][0])
  #       key_arr[2] = key_arr[2][1]
  #     else
  #       key_arr[2] = key_arr[2][0]
  #     end
  #   end

  #   if key_arr[3].to_i < 10
  #     key_arr[3]
  #   else
  #     if key_arr[2].include?(key_arr[3][0])
  #       key_arr[3] = key_arr[3][1]
  #     else

  #       key_arr[3] = key_arr[3][0]
  #     end
  #   end
  # key = key_arr.join
  end
end



# require 'pry'; binding.pry