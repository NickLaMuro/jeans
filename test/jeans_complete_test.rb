require "test_helper"

class JeansCompleteTest < Minitest::Test
  def jeans_complete args = [], contacts = TestFixture[:sample]
    Jeans.new(args).with_contacts(contacts) do |jeans|
      jeans.mode = :complete
      capture_io { jeans.retrieve }[0].chomp
    end
  end

  def test_complete_with_empty_search
    expected = "buddy1 buddy2 testcall"
    actual   = jeans_complete [""]

    assert_equal actual, expected
  end

  def test_complete_with_search_on_bud
    expected = "buddy1 buddy2"
    actual   = jeans_complete ["bud"]

    assert_equal actual, expected
  end

  def test_complete_with_search_on_test
    expected = "testcall"
    actual   = jeans_complete ["test"]

    assert_equal actual, expected
  end

  def test_complete_with_search_on_alias
    expected = "bestbud"
    actual   = jeans_complete ["best"], TestFixture[:sample_with_aliases]

    assert_equal actual, expected
  end

  def test_complete_with_aliases_search_on_both
    expected = "bestbud buddy1 buddy2"
    actual   = jeans_complete ["b"], TestFixture[:sample_with_aliases]

    assert_equal actual, expected
  end
end
