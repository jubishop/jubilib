require_relative '../array.rb'
require 'test/unit'

class ArrayTest < Test::Unit::TestCase
  def test_bsearch_insert_remove_and_each
    100.times {
      test_array = Array.new

      500.times {
        value = rand(1000)
        test_array.bsearch_insert(value)
        assert_equal(test_array, test_array.sort)
      }
      assert_equal(500, test_array.length)

      new_length = 500
      200.times {
        value = rand(1000)
        new_length -= 1 if test_array.include?(value)
        test_array.bsearch_remove(value)
        assert_equal(test_array, test_array.sort)
      }
      assert_equal(new_length, test_array.length)

      100.times {
        target_num = rand(1000)
        index = test_array.index(target_num)
        bsearch_index = test_array.each_binary_index { |x| test_array[x] <=> target_num }
        if (index.nil? or bsearch_index.nil?)
          assert_equal(index, bsearch_index)
        else
          assert_equal(test_array[index], test_array[bsearch_index])
        end
      }
    }
  end
end
