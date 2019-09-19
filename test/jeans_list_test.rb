require "test_helper"

class JeansListTest < Minitest::Test
  def assert_jeans_list sample_contacts, expected
    Jeans.new.with_contacts(sample_contacts) do |jeans|
      actual, _ = capture_io { jeans.list }
      actual.gsub!(/ *$/, '') # remove trailing whitespace
      assert_equal actual, expected
    end
  end

  def test_list
    expected = <<-EXPECTED.gsub(/^ {6}/, '')
          number    |  aliases
      ----------------------------------
               111  |  testcall
         123456789  |  buddy1
         234567890  |  buddy2
    EXPECTED

    assert_jeans_list TestFixture[:sample], expected
  end

  def test_list_with_aliases
    expected = <<-EXPECTED.gsub(/^ {6}/, '')
          number    |  aliases
      ------------------------------------------------------
               111  |  testcall
         123456789  |  buddy1          (bestbud)
         234567890  |  buddy2          (okay_I_guess, meh)
    EXPECTED

    assert_jeans_list TestFixture[:sample_with_aliases], expected
  end
end
