require 'csv'

class EventReporter
	def initialize
	end

	def run
		puts "Welcome to the Event Reporter"
		prompt = ""
			while prompt != "exit"
				printf "enter command: "
				input = gets.chomp.to_s
				process_input(input)
			end
	end

	#def prompt(data)
	#	data = gets.chomp
	#end
end
#eventreporter = EventReporter.new
#eventreporter.run
