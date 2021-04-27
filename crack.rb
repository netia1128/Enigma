require './lib/enigma'
require './lib/cracker'
require 'time'

handle = File.open(ARGV[0], 'r')

incoming_message = handle.read

if ARGV[2].nil?
  date = Date.today.strftime('%d%m%y')
else
  date = ARGV[2]
end

cracker = Cracker.new(incoming_message, date)
key = cracker.key

handle.close

enigma = Enigma.new

cracked_report = enigma.decrypt(incoming_message, key, date)

writer = File.open(ARGV[1], 'w')

writer.write(cracked_report[:message])

writer.close

puts cracked_report[:message]

puts "Created #{ARGV[1]} with the key #{cracked_report[:key]} and date #{cracked_report[:date]}"

# ruby crack.rb encrypted_message.txt cracked.txt