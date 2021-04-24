require './lib/enigma'

handle = File.open(ARGV[0], 'r')

incoming_message = handle.read

handle.close

enigma = Enigma.new

decrypted_message = enigma.decrypt(incoming_message, '02715', '040895')
# encrypted_message = enigma.encrypt(incoming_message)

writer = File.open(ARGV[1], 'w')

writer.write(decrypted_message)

writer.close

puts encrypted_message