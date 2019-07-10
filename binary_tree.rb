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
  def initialize(top)
    @top = top
  end
end
