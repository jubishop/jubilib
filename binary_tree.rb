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
