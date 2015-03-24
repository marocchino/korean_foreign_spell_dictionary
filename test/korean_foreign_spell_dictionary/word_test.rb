require 'minitest_helper'

class KoreanForeignSpellDictionary::WordTest < Minitest::Test
  def setup
    @word = KoreanForeignSpellDictionary::Word.new('1')
  end

  def test_it_does_something_useful
    assert_equal @word.id, '1'
  end

  def test_attributes_assign
    @word.attributes = { korean: '수정' }
    assert_equal @word.korean, '수정'
  end

  def test_to_hash
    assert_equal @word.to_hash,       'original'  => nil,
                                      'korean'    => nil,
                                      'nation'    => nil,
                                      'relate'    => nil,
                                      'mean'      => nil,
                                      'reference' => nil
  end
end
