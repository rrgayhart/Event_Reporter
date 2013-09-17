require 'csv'

class EventReporter

	attr_accessor :queue

#-------------------------------
	def queue
		@queue ||= []
	end

	def run
		puts "Welcome to the Event Reporter"
		print "enter command "
		prompt
		input = gets.chomp.to_s
		process_input(input)

	end

	def command_list
		["load", "queue count", "queue clear", "queue print", "queue save to", "find", "exit"]
	end

	def command_list_split
	end

	def error_message
		puts "We are still working on this functionality"
		puts "Please try another function"
		prompt
		input = gets.chomp.to_s
		process_input(input)
	end

	def help_command(command, directive, directive2, directive3)
		if directive != ""
			error_message
		else
			puts "Here is a list of each command available. Please type help and the command for more details."
			command_list.each do |command|
				puts command
			end
			prompt
			input = gets.chomp.to_s
			process_input(input)
		end
	end

	def process_input(input)
		parts = input.split(" ")
		command = parts[0]
		directive = parts[1] || ""
		directive2 = parts[2] || ""
		directive3 = parts[3] || ""
		case command
			when "exit" then "Goodbye!"
			when "help" then help_command(command, directive, directive2, directive3)
		end

		# command = parts[0]
		# directive = parts[1]
		# case command
		# 	when "exit" then puts "Goodbye!"
		# 	when "load" then puts "load not done yet"
		# 	when "help" then puts "help not done yet"
		# 	when "queue" then puts "queue not done yet"
		# 	when "find" then puts "find not done yet"
		# 	else
		# 		puts "Sorry, I don't know how to #{command}"
		# end
	end

	def prompt
		print "> "
	end

	def load(file = default_file)
		CSV.open file, headers: true
	end

	def default_file
		"event_attendees.csv"
	end
end
eventreporter = EventReporter.new
eventreporter.run
