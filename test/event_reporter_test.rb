require 'minitest'
require 'minitest/autorun'
require './lib/event_reporter'

class EventReporterTest < MiniTest::Test
	def setup
		@event = EventReporter.new
		@list = Array.new
	end

	def test_find_should_exist
		assert_equal "Hello", @event.find(1, 1)
	end

	def test_queue_should_exist
		assert_equal [], @event.queue
	end

	def test_it_should_find_records_by_attribute
		#find zipcode 20011 should work
		#find last_name Johnson should work
		#find state VA should work
	end

	def test_process_input_for_exit
		skip
		assert_equal "Goodbye!", @event.prompt
	end

	def test_it_should_load_default_file
		skip
		event_reporter = EventReporter.new
		contents = event_reporter.load
		first_row = contents.first
		first_name = first_row["first_Name"]
		assert_equal "Allison", first_name
		#Erase any loaded data and parse the specified file. If no filename is given, default to event_attendees.csv
	end

	def test_it_should_list_help_commands
		#reporter = EventReporter.new
		#value = reporter.process_input("help")
		#must_include "find", value
		#help should list all available individual commands
	end

	def test_it_should_list_help_commands_for_a_command
		
	end

	def test_it_should_count_the_queue
		#queue.count should get the correct number
	end

	def test_it_should_clear_the_queue
		#q = queue[data]
		#q.clear
		#q should equal queue[empty]
	end

	def test_it_should_print_the_queue
		#queue.print should print the queue
	end

	def test_it_should_print_a_table_with_formatting
		#tab-delimited data should be printed out in this format: LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE
	end

	def test_it_should_print_by_attribute
		#the queue should print sorted by the attribute that was specified
	end

	def test_it_should_save_queue_to_file
		#queue save to <filename.csv> should save the current queue to the filename that was specified as a CSV. 
		#The file should should include data and headers for last name, first name, email, zipcode, city, state, address, and phone number.
	end



	def search_should_be_case_insensitive
		#"Mary" should match "mary"
	end

	def search_should_be_insensitive_to_internal_whitespace
		#"John" should match "John "
	end

	def search_should_be_sensitive_to_external_whitespace
		#"John Paul" should NOT match "Johnpaul"
	end

	def search_should_not_do_substring_matches
		#find first_name Mary should not find a record with first name as "marybeth"
	end


end







