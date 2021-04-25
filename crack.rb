require './lib/enigma'
require './lib/generatable'

include Generatable

handle = File.open(ARGV[0], 'r')

incoming_message = handle.read
date = ARGV[2]
shifts_array = generate_cracked_key(incoming_message, date)
# key = generate_cracked_key(incoming_message, date)

handle.close

enigma = Enigma.new

cracked_report = enigma.crack(incoming_message, shifts_array, date)

writer = File.open(ARGV[1], 'w')

writer.write(cracked_report[:message])

writer.close

puts cracked_report[:message]

#  puts "Created #{ARGV[1]} with the key #{cracked_report[:key]} and date #{cracked_report[:date]}"

# ruby crack.rb encrypted_message.txt cracked.txt 040895