require_relative 'generatable'
require 'time'

class Enigma
    include Generatable
    attr_reader :range

    def initialize
      @range = ('a'..'z').to_a << " "
    end

    def encrypt(incoming_message, key = generate_random_key, date = Date.today.strftime('%d%m%y'))
      message = incoming_message.downcase.split('')
      shifts_hash = generate_shift_hash(key, date, 1)
      encrypted_message = transform_message(message, shifts_hash[:shifts_array])
      return_hash = {message: encrypted_message, key: shifts_hash[:key], date: shifts_hash[:date]}
    end

    def decrypt(encrypted_message, key, date = Date.today.strftime('%d%m%y'))
      message = encrypted_message.downcase.split('')
      shifts_hash = generate_shift_hash(key, date, -1)
      decrypted_message = transform_message(message, shifts_hash[:shifts_array])
      return_hash = {message: decrypted_message, key: key, date: date}
    end

    private

    def transform_message(message, shifts_array)
      transformed_message = message.map.with_index do |element, index|
        if @range.include?(message[index])
          altered_range = @range.rotate(shifts_array[index % 4])
          message[index] = altered_range[@range.index(message[index])]
        else
          message[index]
        end
      end.join
    end

    #take a range, a - z
    #shift it by a number. if your shift is 3, you shift 3 off the front of the range so it starts with d
    #find the position of the element in question in the original range
    #find the letter in that same position in the altered range

    #imagine your position is 3
    #in the altered range the position is now 19
end