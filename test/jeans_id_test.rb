require "test_helper"

class JeansRetrieveTest < Minitest::Test
  def jeans_id args = [], contacts = TestFixture[:sample]
    Jeans.new(args).with_contacts(contacts) do |jeans|
      jeans.mode = :id
      capture_io { jeans.retrieve }[0].chomp
    end
  end

  def test_id
    expected = %w[111 123456789 234567890].join("\n")
    actual   = jeans_id [""]

    assert_equal actual, expected
  end

  def test_id_with_search_on_bud
    expected = %w[123456789 234567890].join("\n")
    actual   = jeans_id ["bud"]

    assert_equal actual, expected
  end

  def test_id_with_search_on_test
    expected = "111"
    actual   = jeans_id ["test"]

    assert_equal actual, expected
  end

  def test_id_with_search_on_alias
    expected = "123456789"
    actual   = jeans_id ["best"], TestFixture[:sample_with_aliases]

    assert_equal actual, expected
  end
end
