require "test_helper"
require "rbconfig"

# Add method to stub RbConfig::CONFIG to configure OS versions for tests
module RbConfig
  def self.with_os host_os
    warn_level = $VERBOSE
    $VERBOSE   = nil
    old_config = CONFIG

    self.const_set(:CONFIG, {"host_os" => host_os})

    yield
  ensure
    self.const_set(:CONFIG, old_config)
    $VERBOSE   = warn_level
  end
end

# Stub `exec` in Jeans so we aren't executing commands, but capturing what we
# are sending.  Since we are going to be capturing stdout anyway, just do a
# puts instead of an exec, and we will capture everything as if it was a puts.
class Jeans
  def exec(*args)
    puts(*args)
  end
end

class JeansOpenTest < Minitest::Test
  def jeans_open args = [], contacts = TestFixture[:sample]
    Jeans.new(args).with_contacts(contacts) do |jeans|
      jeans.mode = :open
      capture_io { jeans.retrieve }[0].chomp
    end
  end

  def test_open_with_search_on_test_for_osx
    RbConfig.with_os "darwin" do
      expected = 'open "bjnb://meet/id/111"'
      actual   = jeans_open ["test"]

      assert_equal actual, expected
    end
  end

  def test_open_with_search_on_alias_for_osx
    RbConfig.with_os "darwin" do
      expected = 'open "bjnb://meet/id/123456789"'
      actual   = jeans_open ["best"], TestFixture[:sample_with_aliases]

      assert_equal actual, expected
    end
  end

  def test_open_with_no_results_for_osx
    RbConfig.with_os "osx" do
      assert_raises Jeans::NoResultsFoundError, "no results found for 'bad'" do
        jeans_open ["bad"], TestFixture[:sample_with_aliases]
      end
    end
  end

  def test_open_with_bad_arguments_for_osx
    RbConfig.with_os "darwin" do
      assert_raises Jeans::TooManyResultsError, "too many results (buddy1 buddy2) for 'bud'" do
        jeans_open ["bud"], TestFixture[:sample_with_aliases]
      end
    end
  end

  def test_open_with_search_on_test_for_linux
    RbConfig.with_os "linux" do
      expected = "bjnb://meet/id/111"
      actual   = jeans_open ["test"]

      assert_equal actual, expected
    end
  end

  def test_open_with_search_on_alias_for_linux
    RbConfig.with_os "linux" do
      expected = "bjnb://meet/id/123456789"
      actual   = jeans_open ["best"], TestFixture[:sample_with_aliases]

      assert_equal actual, expected
    end
  end

  def test_open_with_no_results_for_linux
    RbConfig.with_os "linux" do
      assert_raises Jeans::NoResultsFoundError, "no results found for 'bad'" do
        jeans_open ["bad"], TestFixture[:sample_with_aliases]
      end
    end
  end

  def test_open_with_bad_arguments_for_linux
    RbConfig.with_os "linux" do
      assert_raises Jeans::TooManyResultsError, "too many results (buddy1 buddy2) for 'bud'" do
        jeans_open ["bud"], TestFixture[:sample_with_aliases]
      end
    end
  end

  def test_open_with_search_on_test_for_windows
    RbConfig.with_os "mswin" do
      expected = 'start "" "bjnb://meet/id/111"'
      actual   = jeans_open ["test"]

      assert_equal actual, expected
    end
  end

  def test_open_with_search_on_alias_for_windows
    RbConfig.with_os "mswin" do
      expected = 'start "" "bjnb://meet/id/123456789"'
      actual   = jeans_open ["best"], TestFixture[:sample_with_aliases]

      assert_equal actual, expected
    end
  end

  def test_open_with_no_results_for_windows
    RbConfig.with_os "windows" do
      assert_raises Jeans::NoResultsFoundError, "no results found for 'bad'" do
        jeans_open ["bad"], TestFixture[:sample_with_aliases]
      end
    end
  end

  def test_open_with_bad_arguments_for_windows
    RbConfig.with_os "windows" do
      assert_raises Jeans::TooManyResultsError, "too many results (buddy1 buddy2) for 'bud'" do
        jeans_open ["bud"], TestFixture[:sample_with_aliases]
      end
    end
  end

  def test_open_with_search_on_test_for_unknown_os
    RbConfig.with_os "shrug" do
      expected = "bjnb://meet/id/111"
      actual   = jeans_open ["test"]

      assert_equal actual, expected
    end
  end

  def test_open_with_search_on_alias_for_unknown_os
    RbConfig.with_os "shrug" do
      expected = "bjnb://meet/id/123456789"
      actual   = jeans_open ["best"], TestFixture[:sample_with_aliases]

      assert_equal actual, expected
    end
  end

  def test_open_with_no_results_for_unknown
    RbConfig.with_os "unknown" do
      assert_raises Jeans::NoResultsFoundError, "no results found for 'bad'" do
        jeans_open ["bad"], TestFixture[:sample_with_aliases]
      end
    end
  end

  def test_open_with_bad_arguments_for_unknown
    RbConfig.with_os "unknown" do
      assert_raises Jeans::TooManyResultsError, "too many results (buddy1 buddy2) for 'bud'" do
        jeans_open ["bud"], TestFixture[:sample_with_aliases]
      end
    end
  end
end
