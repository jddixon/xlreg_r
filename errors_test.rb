
require 'test/unit'
require './xlreg_errors.rb'

class TestErrors < Test::Unit::TestCase

  def testBasic
    # DEBUG
    sleep 0.010
    $stderr.print("START TEST RUN\n")
    sleep 0.010
    # END DEBUG
    
    begin
      # DEBUG
      err = BadAttrsLine.new('some message')  # not seen
      sleep 0.010
      # END DEBUG
      raise err, 'additional comment'         # seen
      flunk ('raised BadAttrsLine but not caught')

    rescue BadAttrsLine
      # DEBUG
      $stdout.print("BadAttrsLine has been caught\n")   # DEBUG
      sleep 0.010
      # END DEBUG
      msg = $!.message
      #             expected,                           actual
      assert_equal('bad attrs line: additional comment', msg)
    
    rescue XLRegException 
      msg = $!.message
      #             expected,                           actual
      assert_equal('bad attrs line: additional comment', msg)
    
    rescue  StandardError
      msg = $!.message
      #             expected,                           actual
      assert_equal('bad attrs line: additional comment', msg)
    end
  end
end
