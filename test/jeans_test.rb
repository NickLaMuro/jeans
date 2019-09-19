require "test_helper"

class JeansTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Jeans::VERSION
  end

  def test_jeans_version
    assert_equal capture_io { Jeans.new.version }[0].chomp, Jeans::VERSION
  end

  def test_jeans_help
    expected = <<-HELP.gsub(/^ {6}/, '')
      usage:  jeans [ACTION] [ARG]...

      Subcommands:

          id          Retrieve the id for a given number
          url         Retrieve the url for a given number
          add         Add a new number (example: `jeans 111 alias1 alias2`)
          list        List all numbers
          init        Init an address book
          contrib     Info about where to find completion and other info
          complete    Auto complete based on current arg
          version     Prints the version number
          help        This help

    HELP

    assert_equal capture_io { Jeans.new.help }[0], expected
  end

  def test_jeans_contrib
    contrib_dir = File.expand_path File.join("..", "..", "contrib"), __FILE__
    expected    = <<-CONTRIB.gsub(/^ {6}/, '')
      # A Bash completion script can be found and loaded by adding the
      # following to your .bashrc:

      source #{File.join contrib_dir, "completion", "jeans.bash"}
    CONTRIB

    assert_equal capture_io { Jeans.new.contrib }[0], expected
  end
end
