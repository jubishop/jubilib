require_relative 'linked_list.rb'

class TreeNode
  include Comparable
  def <=>(other)
    @val <=> other.val
  end

  attr_accessor :val, :left, :right
  def initialize(val, left = nil, right = nil)
    @val = val
    @left = TreeNode.new(*left) unless left.nil?
    @right = TreeNode.new(*right) unless right.nil?
  end

  def serialize
    return @val if (@left.nil? and @right.nil?)
    return [@val, @left.nil? ? nil : @left.serialize, @right.nil? ? nil : @right.serialize]
  end
end

class BinaryTree
  include Enumerable
  def each
    return to_enum(:each) unless block_given?

    return if @top.nil?
    queue = LinkedList.new(@top)
    until (queue.empty?)
      node = queue.shift_node.val
      yield node
      queue.push_node(ListNode.new(node.left)) unless node.left.nil?
      queue.push_node(ListNode.new(node.right)) unless node.right.nil?
    end
  end

  attr_accessor :top
  def initialize(*top)
    @top = top.empty? ? nil : TreeNode.new(*top)
  end
end

class SortedBinaryTree < BinaryTree
  def each(&block)
    return to_enum(:each) unless block_given?
    inorder(@top, &block)
  end

  def reverse_each(&block)
    return to_enum(:reverse_each) unless block_given?
    postorder(@top, &block)
  end

  private

  def inorder(node, &block)
    return if node.nil?
    inorder(node.left, &block)
    block.yield(node)
    inorder(node.right, &block)
  end

  def postorder(node, &block)
    return if node.nil?
    postorder(node.right, &block)
    block.yield(node)
    postorder(node.left, &block)
  end
end
