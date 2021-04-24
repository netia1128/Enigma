require_relative 'generatable'
require 'time'

class Enigma
    include Generatable

    def encrypt(incoming_message, key = generate_random_key, date = Date.today.strftime('%d%m%y'))

        encrypted_message = incoming_message.downcase.split('')
        shift_hash = generate_shift_hash(key, date)
        range = ('a'..'z').to_a
        range << ''

        message_length = encrypted_message.count

        times_to_loop_hash = {
            A: (message_length / 4) + (message_length % 4 > 0 ? 1 : 0),
            B: (message_length / 4) + (message_length % 4 > 1 ? 1 : 0),
            C: (message_length / 4) + (message_length % 4 > 2 ? 1 : 0),
            D: (message_length / 4) + (message_length % 4 > 3 ? 1 : 0),
        }

        count = 0
        times_to_loop_hash[:A].times do
            if range.include?(encrypted_message[count]) && encrypted_message[count] != ''
                index = range.index(encrypted_message[count])
                altered_range = range.rotate(shift_hash[:A])
                encrypted_message[count] = altered_range[index]
            end
            count += 4
        end
        count = 1
        times_to_loop_hash[:B].times do
            if range.include?(encrypted_message[count]) && encrypted_message[count]
                index = range.index(encrypted_message[count])
                altered_range = range.rotate(shift_hash[:B])
                encrypted_message[count] = altered_range[index]
            end
            count += 4
        end
        count = 2
        times_to_loop_hash[:C].times do
            if range.include?(encrypted_message[count]) && encrypted_message[count] != ''
                index = range.index(encrypted_message[count])
                altered_range = range.rotate(shift_hash[:C])
                encrypted_message[count] = altered_range[index]
            end
            count += 4
        end
        count = 3
        times_to_loop_hash[:D].times do
            if range.include?(encrypted_message[count]) && encrypted_message[count] != ''
                index = range.index(encrypted_message[count])
                altered_range = range.rotate(shift_hash[:D])
                encrypted_message[count] = altered_range[index]
            end
            count += 4
        end

        require 'pry'; binding.pry

        # The encrypt method takes a message String as an argument. It can optionally take a Key and Date as
        # arguments to use for encryption. If the key is not included, generate a random key.
        # If the date is not included, use today’s date.

        # The encrypt method returns a hash with three keys:
            # :encryption => the encrypted String
            # :key => the key used for encryption as a String
            # :date => the date used for encryption as a String in the form DDMMYY
            hash = {message: encrypted_message, key: key, date: date}
            # require 'pry'; binding.pry
    end

    # def decrypt(message, key = generate_random_key, date = Date.now.strftime('%d%m%y'))
    # # Enigma#decrypt(ciphertext, key, date)
    # # The decrypt method takes a ciphertext String and the Key used
    # # for encryption as arguments. The decrypt method can optionally take a date as the third argument.
    # #     If no date is given, this method should use today’s date for decryption.

    # # The decrypt method returns a hash with three keys:

    # # :decryption => the decrypted String
    # # # :key => the key used for decryption as a String
    # # # :date => the date used for decryption as a String in the form DDMMYY
    # hash = {message: message, key: key, date: date}
    # end

    #move this to a module
end