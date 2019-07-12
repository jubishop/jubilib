require_relative '../binary_tree.rb'

tree = SortedBinaryTree.new(TreeNode.new(4,[2,1,3],5))
normal_tree = BinaryTree.new(TreeNode.new(4,[2,1,3],5))
tree.each { |node| puts node.val }
normal_tree.each { |node| puts node.val }
