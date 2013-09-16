require 'minitest'
require 'minitest/autorun'
require './lib/event_reporter'

class EventReporterTest < MiniTest::Test
	def test_it_exists
		# ASSIGN & ACTIONS
		em = EventReporter.new
		# ASSERTIONS
		assert_kind_of EventReporter, em
	end
end