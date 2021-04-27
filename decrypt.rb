require './lib/enigma'

handle = File.open(ARGV[0], 'r')

incoming_message = handle.read

handle.close

enigma = Enigma.new

# decryption_report = enigma.decrypt(incoming_message, '02715', '040895')
decryption_report = enigma.decrypt(incoming_message, '72616', '260421')
# decryption_report = enigma.decrypt(incoming_message, '13036')

writer = File.open(ARGV[1], 'w')

writer.write(decryption_report[:message])

writer.close

puts decryption_report[:message]
puts "Created #{ARGV[1]} with the key #{decryption_report[:key]} and date #{decryption_report[:date]}"
# ruby decrypt.rb encrypted_message.txt decrypted_message.txt