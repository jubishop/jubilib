require_relative '../binary_tree.rb'
require 'test/unit'

class BinaryTreeTest < Test::Unit::TestCase
  def testBinarySearchTree
    test_array = Array.new
    test_tree = BinarySearchTree.new

    # test insert
    500.times {
      value = rand(1000)
      next if (test_array.include? value)
      test_array.push(value).sort!
      test_tree.add(value)
      assert_equal(test_array, test_tree.values)
    }

    # test include
    500.times {
      value = rand(1000)
      assert_equal(test_array.include?(value), test_tree.include?(value))
    }

    # test delete
    until (test_array.empty?)
      index = rand(test_array.length)
      value = test_array[index]
      test_array.delete_at(index)
      test_tree.delete(value)
      assert_equal(test_array, test_tree.values)
    end
  end

end
