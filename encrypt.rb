require './lib/enigma'

handle = File.open(ARGV[0], 'r')

incoming_message = handle.read

handle.close

enigma = Enigma.new

# encryption_report = enigma.encrypt(incoming_message, '02715', '040895')
  encryption_report = enigma.encrypt(incoming_message)

writer = File.open(ARGV[1], 'w')

writer.write(encryption_report[:message])

writer.close

 puts "Created #{ARGV[1]} with the key #{encryption_report[:key]} and date #{encryption_report[:date]}"

# ruby encrypt.rb message_to_encrypt.txt encrypted_message.txt