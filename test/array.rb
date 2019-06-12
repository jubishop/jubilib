require_relative '../array.rb'
require 'test/unit'

class ArrayTest < Test::Unit::TestCase
  def test_bsearch_insert_and_each_binary_index
    100.times {
      test_array = Array.new
      rand(1000).times { test_array.bsearch_insert(rand(1000)) }
      assert_equal(test_array, test_array.sort)
      target_num = rand(1000)
      index = test_array.index(target_num)
      bsearch_index = test_array.each_binary_index { |x| test_array[x] <=> target_num }
      if (index.nil? or bsearch_index.nil?)
        assert_equal(index, bsearch_index)
      else
        assert_equal(test_array[index], test_array[bsearch_index])
      end
    }
  end
end
