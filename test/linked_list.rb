require_relative '../linked_list.rb'
require 'test/unit'

class LinkedListTest < Test::Unit::TestCase
  def setup
    @test_array = Array.new(100) { rand(100) }
  end

  def test_instantiation
    test_list = LinkedList.new(*@test_array)
    assert_equal(@test_array, test_list.values)
    assert_equal(@test_array.length, test_list.size)
  end

  def test_push
    test_list = LinkedList.new
    @test_array.each { |value| test_list.push_node(ListNode.new(value)) }
    assert_equal(@test_array, test_list.values)
    assert_equal(@test_array.length, test_list.size)
  end

  def test_unshift
    test_list = LinkedList.new
    @test_array.each { |value| test_list.unshift_node(ListNode.new(value)) }
    assert_equal(@test_array.reverse, test_list.values)
    assert_equal(@test_array.length, test_list.size)
  end

  def test_pop
    test_list = LinkedList.new(*@test_array)
    until(@test_array.empty?)
      @test_array.pop
      test_list.pop_node
      assert_equal(@test_array, test_list.values)
      assert_equal(@test_array.length, test_list.size)
    end
  end

  def test_shift
    test_list = LinkedList.new(*@test_array)
    until(@test_array.empty?)
      @test_array.shift
      test_list.shift_node
      assert_equal(@test_array, test_list.values)
      assert_equal(@test_array.length, test_list.size)
    end
  end

  def test_remove
    test_list = LinkedList.new(*@test_array)
    5.times {
      first = @test_array.shift
      test_list.remove_node(true) { |node| node.val == first }
      assert_equal(@test_array, test_list.values)
      assert_equal(@test_array.length, test_list.size)
    }

    5.times {
      random_value = @test_array.sample
      @test_array.delete_if { |value| value == random_value }
      test_list.remove_node { |node| node.val == random_value }
      assert_equal(@test_array, test_list.values)
      assert_equal(@test_array.length, test_list.size)
    }

    @test_array = [0,1,2,3,4,5,6,7,8,9,10]
    test_list = LinkedList.new(*@test_array)
    5.times {
      last = @test_array.pop
      test_list.remove_node(true) { |node| node.val == last }
      assert_equal(@test_array, test_list.values)
      assert_equal(@test_array.length, test_list.size)
    }
  end
end
