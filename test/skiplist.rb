require_relative '../skiplist.rb'
require 'test/unit'

class SkipListTest < Test::Unit::TestCase
  def setup
    @test_array = Array.new(1000) { rand(1000) }
  end

  def test_skiplist_instantiation
    test_list = SkipList.new(@test_array)
    assert_equal(@test_array.sort, test_list.to_a)
  end
end
