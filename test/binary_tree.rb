require_relative '../binary_tree.rb'
require 'test/unit'

class BinaryTreeTest < Test::Unit::TestCase
  def testSortedInsertAndInclude
    test_array = Array.new
    test_tree = SortedBinaryTree.new
    500.times {
      value = rand(1000)
      next if (test_array.include? value)
      test_array.push(value).sort!
      test_tree.add(value)
      assert_equal(test_array, test_tree.values)
    }

    500.times {
      value = rand(1000)
      assert_equal(test_array.include?(value), test_tree.include?(value))
    }
  end
end
