require_relative '../modules/enumerable.rb'
require 'test/unit'

class EnumerableTest < Test::Unit::TestCase
  def setup
    @test_array = Array.new(100) { |index| index }
  end

  def test_to_skiplist
    skiplist = @test_array.to_skiplist
    assert_equal(@test_array, skiplist.values)
  end

  def test_to_linked_list
    linked_list = @test_array.to_linked_list
    assert_equal(@test_array, linked_list.values)
  end
end
