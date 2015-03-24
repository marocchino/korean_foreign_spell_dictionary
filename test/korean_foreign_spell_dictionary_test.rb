require 'minitest_helper'

class KoreanForeignSpellDictionaryTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::KoreanForeignSpellDictionary::VERSION
  end
end
