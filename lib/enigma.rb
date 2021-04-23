require 'time'

class Enigma

#def encrypt(message, key = need_method_to_generate_random_key, date = Date.now.strftime('%d%m%y'))
    # The encrypt method takes a message String as an argument. It can optionally take a Key and Date as 
    # arguments to use for encryption. If the key is not included, generate a random key. 
    # If the date is not included, use today’s date.

    # The encrypt method returns a hash with three keys:
        # :encryption => the encrypted String
        # :key => the key used for encryption as a String
        # :date => the date used for encryption as a String in the form DDMMYY
# end

#def decrypt(message, key = need_method_to_generate_random_key, date = Date.now.strftime('%d%m%y'))
# Enigma#decrypt(ciphertext, key, date)
# The decrypt method takes a ciphertext String and the Key used 
# for encryption as arguments. The decrypt method can optionally take a date as the third argument. 
#     If no date is given, this method should use today’s date for decryption.

# The decrypt method returns a hash with three keys:

# :decryption => the decrypted String
# # :key => the key used for decryption as a String
# # :date => the date used for decryption as a String in the form DDMMYY
# end

#move this to a module
def generate_random_key
    random_key = rand
    random_key = random_key.to_s.slice(2..6)
end

end