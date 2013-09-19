require 'csv'
require 'pry'

class EventReporter

	attr_accessor :queue, :file

#-------------------------------
# Test Section

	def new_csv
	queue = @queue
	print "ID\tFirst Name\tLast Name\n"
	queue.each do |entry|
		print "#{entry[:id]}\t#{entry[:first_name]}\t#{entry[:last_name]}"
	end
  #  :write_headers=> true,
  #  :headers => ["numerator","denominator","calculation"] #< column header
  #) do|hdr|
  #1.upto(12){|numerator|
  #  1.upto(12){ |denominator|
  #    data_out = [numerator, denominator, numerator/denominator.to_f]
  #    hdr << data_out
  #  }
  #}
	end
	#end

	def print_template
		queue = @queue
		print "ID\tFirst Name\tLast Name\n"
		queue.each do |row|
			print row
		end
	end

#-------------------------------
# Queue Section

	def queue
		@queue ||= {}
	end

	def queue_count
		puts queue.count
		prompt
	end

	def print_queue
		queue = @queue
		if queue == nil
			puts "Nothing in queue"
		else
			print queue
		end
		prompt
	end

	def clear_queue
		@queue = []
		prompt
	end

	def queue_command(directive, directive_array, directive3)
		if directive == "clear"
			clear_queue
		elsif directive == "print"
			if directive3 == ""
			print_queue
			else
				puts directive_array[2..-1]
				construction_message
			end
		elsif directive == "count"
			queue_count
		elsif directive == "save"
			file_name = directive_array[-1]
			save_to(file_name)
		else
			error_message
		end
	end

#-------------------------------
# Find Section

	def find_first_names(name)
		@queue = []
		array = []
		file = @file
		file = format_file(file)
		id = 0
		file.each do |row|
			first_name = row[:first_name]
			if first_name.upcase == name.upcase
			id += 1
			 puts "#{id} #{row[:first_name]} #{row[:last_name]} "
			 #column = [id, row[:last_name], row[:first_name]]
			 #column = {:id => id, :last_name => row[:last_name], :first_name => row[:first_name]}
			 #queue << column
			 queue << row
			end
		end
		#queue << array
		prompt
	end

	def find_clean(directive, directive_array)
		directive = directive.downcase
		if @file == nil
			puts "No file has been loaded. The default file will be loaded"
			load("")
		else
		puts "I will search the file for #{directive}" 
		if directive == ""
			error_message
		elsif directive.include? "first name"
			attribute = directive_array[2..-1]
			attribute_string = attribute.join
			puts attribute_string.inspect
			find_first_names(attribute_string)
		elsif directive.include? "last name"
			attribute = directive_array[2..-1]
			attribute_string = attribute.join
			puts attribute_string.inspect
			construction_message
			#find_last_names(attribute_string)
		elsif directive.include? "email"
			attribute = directive_array[1..-1]
			attribute_string = attribute.join
			puts attribute_string.inspect
			construction_message
			#find_email(attribute_string)
		elsif directive.include? "zipcode"
			attribute = directive_array[1..-1]
			construction_message
		elsif directive.include? "city"
			attribute = directive_array[1..-1]
			construction_message
		elsif directive.include? "state"
			attribute = directive_array[1..-1]
			construction_message
		elsif directive.include? "address"
			attribute = directive_array[1..-1]
			construction_message
		elsif directive.include? "phone"
			attribute = directive_array[1..-1]
			construction_message
		else
			attribute = 'error'
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
		prompt
	end

	def clean_zipcode(zipcode)
  	zipcode.to_s.rjust(5,"0")[0..4]
	end

	def save_to(file_name)
		queue = @queue
		if file_name.include? '.csv'
			puts "Saving to #{file_name}"
			CSV.open(file_name, "wb") do |csv|
					csv << queue
				end
		else
			puts "A default_event_reporter0000.csv file will be generated for you, or updated if existing."
			CSV.open("default_event_reporter0000.csv", "wb") do |csv|
				csv << queue
			end
		end
		prompt	
	end

	def format_file(file)
		file = @file
		CSV.open file, headers: true, header_converters: :symbol
		#contents.each do |row|
		#	first_name = row[:first_name]
		#	last_name = row[:last_name]
		#	email = row[:email]
		#	zipcode = clean_zipcode(row[:zipcode])
		#	city = row[:city]
		#	state = row[:state]
		#	addess = row[:address]
		#	phone = row[:phone]
		#end
		#prompt 
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
			when "exit" then print "Goodbye!" "\n"
			when "load" then load(directive_join)
			when "help" then help_command(command, directive_join)
			when "find" then find_clean(directive_join, directive_array)
			when "queue" then queue_command(directive, directive_array, directive3)
			# These commands will not be used but can test out new ideas
#-------------------Don't Forget to Delete Below-------------------
			when "test" then new_csv
			when "ptest" then print_template
#-------------------Don't Forget to Delete Above-------------------
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
				prompt
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
binding.pry
eventreporter = EventReporter.new
eventreporter.run
