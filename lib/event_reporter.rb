require 'csv'

class EventReporter

	attr_accessor :queue, :file

#-------------------------------
# Queue Section

	def queue
		@queue ||= []
	end

#-------------------------------
# File Section

	def load(file_input)
		if file_input == ""
			file = default_file
		else file = file_input
		end
		@file = file
		puts "You have now opened: #{file}"
		format_file(file)
	end

	def clean_zipcode(zipcode)
  	zipcode.to_s.rjust(5,"0")[0..4]
	end

	def format_file(file)
		contents = CSV.open file, headers: true, header_converters: :symbol
		contents.each do |row|
			first_name = row[:first_name]
			last_name = row[:last_name]
			email = row[:email]
			zipcode = clean_zipcode(row[:zipcode])
			city = row[:city]
			state = row[:state]
			addess = row[:address]
			phone = row[:phone]
		end
		prompt
	end

	def attribute_list
		["first name", "last name", "email", "zipcode", "city", "state", "address", "phone"]
	end

	def list_attributes
		attribute_list.each do |a|
			print "'#{a}'"
		end
	end

	def read(file)
		lines = File.readlines file
		lines.each do |line|
  	puts line
end
	end

	def default_file
		"event_attendees.csv"
	end

	def find_clean(directive, directive_array)
		puts directive
		if directive == ""
			error_message
		elsif directive.include? "first name"
			attribute = directive_array[2..-1]
		elsif directive.include? "last name"
			attribute = directive_array[2..-1]
		elsif directive.include? "email"
			attribute = directive_array[1..-1]
		elsif directive.include? "zipcode"
			attribute = directive_array[1..-1]
		elsif directive.include? "city"
			attribute = directive_array[1..-1]
		elsif directive.include? "state"
			attribute = directive_array[1..-1]
		elsif directive.include? "address"
			attribute = directive_array[1..-1]
		elsif directive.include? "phone"
			attribute = directive_array[1..-1]
		else
			puts "This is not an attribute. Acceptable attributes are: " 
			list_attributes
			puts ''
			prompt
		end
		#if attribute == "" || criteria == ""
		#	error_message
		#else
		#	if attribute_list.include? attribute
		#	else
		#		puts "This is not an attribute. Please enter your command again."
		#		prompt
		#	end
		#end
	end

#-------------------------------
# Run Section

	def run
		puts "Welcome to the Event Reporter"
		print "enter command "
		prompt
	end

	#def command_list_array
	#	["load", "queue count", "queue clear", "queue print", "queue save to", "find", "exit"]
	#end

	def command_list
		{"load" => "Loads a CSV file that can be searched", "queue count" => "Counts the records in the queue", "queue clear" => "Clears your queue", "queue print" => "Prints your queue", "queue save to" => "Saves your queue to the specified queue", "find" => "Finds records based on your specified search attributes.", "exit" => "Exits the programm."}
	end

	def command_list_split
	end

	def construction_message
		puts "We are still working on this functionality"
		puts "Please try another function"
		prompt
	end

	def error_message
		puts "I do not recognize this function. Please try again. Type help for a list of commands. Or exit to leave."
		prompt
	end

	def process_input(input)
		parts = input.split(" ")
		command = parts[0]
		directive_array = parts[1..5]
		directive_join = directive_array.join(" ")
		directive = parts[1] || ""
		directive2 = parts[2] || ""
		directive3 = parts[3] || ""
		case command
			when "exit" then puts "Goodbye!"
			when "load" then load(directive_join)
			when "help" then help_command(command, directive_join)
			when "find" then find_clean(directive_join, directive_array)
			else error_message
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
		input = gets.chomp.to_s
		process_input(input)
	end

#-------------------------------
# Help Section

	def help_command(command, directive_join)
		if directive_join != ""
			if command_list.include? directive_join
				puts command_list[directive_join]
			else
				error_message
			end
		else
			puts "Here is a list of each command available. Please type help and the command for more details."
			command_list.each do |command, description|
				puts command
			end
			prompt
		end
	end
end
eventreporter = EventReporter.new
eventreporter.run
