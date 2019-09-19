require "test_helper"
require "tmpdir"
require "fileutils"

class JeansInitTest < Minitest::Test
  def setup
    @test_home_dir          = Dir.mktmpdir
    @test_contacts_filename = File.join @test_home_dir, ".jeans.numbers"
    @jeans                  = Jeans.new

    @jeans.instance_variable_set(:@db_file_name, @test_contacts_filename)
  end

  def teardown
    FileUtils.remove_entry @test_home_dir
  end

  def test_init
    @jeans.init

    assert File.exist?(@test_contacts_filename),
           "#{@test_contacts_filename} was not created!"
  end

  def test_init_noops_when_file_exists
    FileUtils.cp TestFixture[:sample], @test_contacts_filename
    @jeans.init

    assert File.exist?(@test_contacts_filename),
           "#{@test_contacts_filename} was not created!"

    expected = File.read TestFixture[:sample]
    actual   = File.read @test_contacts_filename
    assert_equal actual, expected
  end
end
