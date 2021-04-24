require './lib/enigma'


handle = File.open(ARGV[0], 'r')

incoming_message = handle.read

handle.close

enigma = Enigma.new

encrypted_message = enigma.encrypt(incoming_message, '02715', '040895')

writer = File.open(ARGV[1], 'w')

writer.write(encrypted_message)

writer.close

puts encrypted_message