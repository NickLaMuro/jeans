require "test_helper"
require "tempfile"
require "fileutils"

class JeansAddTest < Minitest::Test
  def setup
    @test_contacts_file = Tempfile.open
  end

  def teardown
    @test_contacts_file.close  unless @test_contacts_file.closed?
    @test_contacts_file.unlink
  end

  # Helper to do the following
  #
  # - Loads the :sample_with_aliases fixture
  # - Writes that data to the @test_contacts_file
  # - Runs the `add` action
  # - Re-opens the tempfile (for reading in the test method)
  # - Returns the output of the command
  #
  def jeans_add *args
    @test_contacts_file.close
    FileUtils.cp TestFixture[:sample_with_aliases], @test_contacts_file.path

    Jeans.new(args).with_contacts(@test_contacts_file.path) do |jeans|
      jeans.action = :add
      capture_io { jeans.add }[0].chomp.tap do
        @test_contacts_file.open
      end
    end
  end

  def test_add
    expected_output = '34567890: buddy3, guy, besterestbud'
    actual_output   = jeans_add '34567890', 'buddy3', 'guy', 'besterestbud'

    assert_equal actual_output, expected_output
    assert_equal @test_contacts_file.read, <<-DATA.gsub(/^ {6}/, '')
      111,testcall
      123456789,buddy1,bestbud
      234567890,buddy2,okay_I_guess,meh
      34567890,buddy3,guy,besterestbud
    DATA
  end

  def test_add_to_and_existing_number
    expected_output = '111: testcall, foreveralone'
    actual_output   = jeans_add '111', 'testcall', 'foreveralone'

    assert_equal actual_output, expected_output
    assert_equal @test_contacts_file.read, <<-DATA.gsub(/^ {6}/, '')
      123456789,buddy1,bestbud
      234567890,buddy2,okay_I_guess,meh
      111,testcall,foreveralone
    DATA
  end
end
