require "test_helper"

class JeansRetrieveTest < Minitest::Test
  def jeans_url args = [], contacts = TestFixture[:sample]
    Jeans.new(args).with_contacts(contacts) do |jeans|
      jeans.mode = :url
      capture_io { jeans.retrieve }[0].chomp
    end
  end

  def test_url
    expected = [
                 "bjnb://meet/id/111",
                 "bjnb://meet/id/123456789",
                 "bjnb://meet/id/234567890"
               ].join("\n")
    actual   = jeans_url [""]

    assert_equal actual, expected
  end

  def test_url_with_search_on_bud
    expected = %w[bjnb://meet/id/123456789 bjnb://meet/id/234567890].join("\n")
    actual   = jeans_url ["bud"]

    assert_equal actual, expected
  end

  def test_url_with_search_on_test
    expected = "bjnb://meet/id/111"
    actual   = jeans_url ["test"]

    assert_equal actual, expected
  end

  def test_url_with_search_on_alias
    expected = "bjnb://meet/id/123456789"
    actual   = jeans_url ["best"], TestFixture[:sample_with_aliases]

    assert_equal actual, expected
  end
end
