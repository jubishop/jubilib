require_relative '../skiplist.rb'
require 'test/unit'

class SkipListTest < Test::Unit::TestCase
  def setup
    @test_array = Array.new(1000) { rand(1000) }
    @test_array_dupes = Array.new(1000) { rand(100) }
    @test_array_sparse = Array.new(100) { rand(100000) }
    @all_arrays = [@test_array, @test_array_dupes, @test_array_sparse]
  end

  def test_skiplist_instantiation
    @all_arrays.each { |array|
      test_list = SkipList.new(array)
      assert_equal(array.sort, test_list.to_a)
    }
  end
end
