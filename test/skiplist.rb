require_relative '../skiplist.rb'
require 'test/unit'

class SkipListTest < Test::Unit::TestCase
  def setup
    @test_array = Array.new(1000) { rand(1000) }
    @test_array_dupes = Array.new(1000) { rand(100) }
    @test_array_sparse = Array.new(1000) { rand(10000) }
    @all_arrays = [@test_array, @test_array_dupes, @test_array_sparse]
  end

  def test_instantiation
    @all_arrays.each { |array|
      test_list = SkipList.new(*array)
      assert_equal(array.sort, test_list.values)
    }
  end

  def test_find_by_value
    @all_arrays.each { |array|
      test_list = SkipList.new(*array)
      200.times {
        value = array.sample
        node = test_list.find(value)
        assert_equal(node.value, value)
      }
      200.times {
        value = rand(array.length)
        node = test_list.find(value)
        if (array.include?(value))
          assert_equal(node.value, value)
        else
          assert_false(node)
        end
      }
    }
  end

  def test_remove_node
    @all_arrays.each { |array|
      test_list = SkipList.new(*array)
      200.times {
        value = array.sample
        array.slice!(array.index(value))
        node = test_list.delete(value)
        assert_equal(node.value, value)
        assert_instance_of(SkipNode, node)
        assert_equal(array.sort, test_list.values)
      }
      200.times {
        value = rand(array.length)
        node = test_list.delete(value)
        if (array.include?(value))
          array.slice!(array.index(value))
          assert_equal(node.value, value)
          assert_instance_of(SkipNode, node)
        else
          assert_false(node)
        end
        assert_equal(array.sort, test_list.values)
      }
    }
  end

  def test_remove_every_node
    @all_arrays.each { |array|
      array_clone = array.clone
      test_list = SkipList.new(*array)
      array.length.times {
        value = array.sample
        array.slice!(array.index(value))
        node = test_list.delete(value)
        assert_equal(node.value, value)
        assert_instance_of(SkipNode, node)
        assert_equal(array.sort, test_list.values)
      }
      array_clone.each { |value|
        test_list.add(value)
      }
      assert_equal(array_clone.sort, test_list.values)
    }
  end
end
