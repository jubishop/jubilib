class TreeNode
  attr_accessor :value, :left, :right
  def initialize(*values)
    @value = values.shift
    @left = TreeNode.new(values.shift) unless values.empty?
    @right = TreeNode.new(values.shift) unless values.empty?
  end

  def to_a
    [@value, @left.nil? ? nil : @left.to_a, @right.nil? ? nil : @right.to_a]
  end
end

data = [1, [2, nil, nil], [3, [4, nil, nil], [5, nil, nil]]]
puts data.flatten.length
node = TreeNode.new(data)
puts node.to_a.flatten.length
