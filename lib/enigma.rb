require_relative 'generatable'
require 'time'

class Enigma
    include Generatable
    attr_reader :range

    def initialize
      @range = ('a'..'z').to_a << ''
    end

    def encrypt(incoming_message, key = generate_random_key, date = Date.today.strftime('%d%m%y'))
      message = incoming_message.downcase.split('')
      shifts_hash = generate_shift_hash(key, date)
      encrypted_message = encrypt_message(message, shifts_hash[:shifts_array])
      return_hash = {message: encrypted_message, key: shifts_hash[:key], date: shifts_hash[:date]}
    end

    def decrypt(encypted_message, key, date = Date.now.strftime('%d%m%y'))
    # # Enigma#decrypt(ciphertext, key, date)
    # # The decrypt method takes a ciphertext String and the Key used
    # # for encryption as arguments. The decrypt method can optionally take a date as the third argument.
    # #     If no date is given, this method should use today’s date for decryption.

    # # The decrypt method returns a hash with three keys:

    # # :decryption => the decrypted String
    # # # :key => the key used for decryption as a String
    # # # :date => the date used for decryption as a String in the form DDMMYY
    # hash = {message: message, key: key, date: date}
    end


    private

    def encrypt_message(message, shifts_array)
      encrypted_message = message.map.with_index do |element, index|
        if @range.include?(message[index])
          altered_range = @range.rotate(shifts_array[index % 4])
          message[index] = altered_range[@range.index(message[index])]
        else
          message[index]
        end
      end.join
    end
end