require_relative 'enumerable.rb'

class TreeNode
  include Comparable
  def <=>(other)
    @value <=> other.value
  end

  attr_accessor :value, :left, :right
  def initialize(value, left = nil, right = nil)
    @value = value
    @left = TreeNode.new(*left) unless left.nil?
    @right = TreeNode.new(*right) unless right.nil?
  end

  def serialize
    return @value if (@left.nil? and @right.nil?)
    return [@value, @left.nil? ? nil : @left.serialize, @right.nil? ? nil : @right.serialize]
  end
end

class BinaryTree
  include Enumerable
  def each
    return to_enum(:each) unless block_given?

    return if @top.nil?
    queue = [@top]
    until (queue.empty?)
      node = queue.shift
      yield node
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
    end
  end

  attr_accessor :top
  def initialize(*top)
    @top = top.empty? ? nil : TreeNode.new(*top)
  end

  def values
    to_a.map{ |node| node.value }
  end
end

class BinarySearchTree < BinaryTree
  def each(&block)
    return to_enum(:each) unless block_given?
    inorder(@top, &block)
  end

  def reverse_each(&block)
    return to_enum(:reverse_each) unless block_given?
    postorder(@top, &block)
  end

  def add(value)
    return (@top = TreeNode.new(value)) if @top.nil?
    return _insert(value, @top)
  end

  def delete(value)
    return (@top = _delete(value))
  end

  def include?(value, node = @top)
    return false if node.nil?
    return true if node.value == value
    if (value < node.value)
      return include?(value, node.left)
    else
      return include?(value, node.right)
    end
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

  def _insert(value, node)
    return node if (value == node.value)
    if (value < node.value)
      return node.left.nil? ? (node.left = TreeNode.new(value)) : _insert(value, node.left)
    else
      return node.right.nil? ? (node.right = TreeNode.new(value)) : _insert(value, node.right)
    end
  end

  def _delete(value, node = @top)
    return nil if node.nil?

    if (value < node.value)
      node.left =_delete(value, node.left)
    elsif (value > node.value)
      node.right = _delete(value, node.right)
    else
      if (node.left.nil?)
        return node.right
      elsif (node.right.nil?)
        return node.left
      end

      min_right = node.right
      min_right = min_right.left until min_right.left.nil?
      node.value = min_right.value
      node.right = _delete(min_right.value, node.right)
    end

    return node
  end
end
