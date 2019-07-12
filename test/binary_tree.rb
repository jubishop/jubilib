require_relative '../binary_tree.rb'
require 'test/unit'

class BinaryTreeTest < Test::Unit::TestCase
  def testSortedInsert
    test_array = Array.new
    test_tree = SortedBinaryTree.new
    200.times {
      value = rand(1000)
      next if (test_array.include? value)
      test_array.push(value).sort!
      test_tree.insert(value)
      assert_equal(test_array, test_tree.values)
    }
  end
end
