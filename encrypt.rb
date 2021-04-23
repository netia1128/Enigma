handle = File.open(ARGV[0], 'r')

incoming_message = handle.read

handle.close

encrypted_message = incoming_message.downcase

writer = File.open(ARGV[1], 'w')

writer.write(encrypted_message)

writer.close

puts encrypted_message