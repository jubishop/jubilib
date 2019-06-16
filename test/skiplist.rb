require_relative '../skiplist.rb'
require 'test/unit'

class SkipListTest < Test::Unit::TestCase
  def setup
    @test_array = Array.new(1000) { rand(1000) }
    @test_array_dupes = Array.new(1000) { rand(100) }
    @test_array_sparse = Array.new(100) { rand(100000) }
    @all_arrays = [@test_array, @test_array_dupes, @test_array_sparse]
  end

  def test_instantiation
    @all_arrays.each { |array|
      test_list = SkipList.new(array)
      assert_equal(array.sort, test_list.to_a)
    }
  end

  def test_find_by_value
    @all_arrays.each { |array|
      test_list = SkipList.new(array)
      50.times {
        value = array.sample
        node = test_list.find_node_by_value(value)
        assert_equal(node.value, value)
      }
      50.times {
        value = rand(array.length)
        node = test_list.find_node_by_value(value)
        if (array.include?(value))
          assert_equal(node.value, value)
        else
          assert_false(node)
        end
      }
    }
  end
end
