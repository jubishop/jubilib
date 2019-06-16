class SkipNode
  attr_accessor :value, :level
  def initialize(value)
    @value = value
    @level = generate_pointer_level
    @pointers = Array.new(@level + 1) { SkipPointer.new }
  end

  def [](level)
    return @pointers[level]
  end

  def inspect
    "Level: #{@level}, Value: #{@value}"
  end

  private

  def generate_pointer_level
    Math.log2(2**32 / (rand(2**32) + 1)).to_i
  end

  class SkipPointer
    attr_accessor :prev, :next
  end
end

class SkipList
  def initialize(values = Array.new)
    values.each { |value| add_new_node(SkipNode.new(value)) }
  end

  def add_new_node(node)
    @head = node and return if (@head.nil?)

    # find top level prev/next for this node
    max_level = [node.level, @head.level].min
    prev_node, next_node = dive_to_nearest_nodes(node)
    node[max_level].next = next_node
    node[max_level].prev = prev_node

    (max_level-1).downto(0) { |search_level|
      prev_node, next_node = find_nearest_nodes(node, prev_node || next_node, search_level)
      node[search_level].next = next_node
      node[search_level].prev = prev_node
    }

    @head = node if (node.level > @head.level or (node.level == @head.level and node[node.level].next == @head))
  end

  private

  def dive_to_nearest_nodes(node, search_node = @head, search_level = @head.level)
    return (search_node.value < node.value) ?
      dive_forward_to_nearest_nodes(node, search_node, search_level) :
      dive_backward_to_nearest_nodes(node, search_node, search_level)
  end

  def dive_forward_to_nearest_nodes(node, search_node, search_level)
    search_node, next_node = find_nearest_forward_node(node, search_node, search_level)
    return (node.level >= search_level) ?
      [search_node, next_node] :
      dive_to_nearest_nodes(node, search_node, search_level - 1)
  end

  def dive_backward_to_nearest_nodes(node, search_node, search_level)
    prev_node, search_node = find_nearest_backward_node(node, search_node, search_level)
    return (node.level >= search_level) ?
      [prev_node, search_node] :
      dive_to_nearest_nodes(node, search_node, search_level - 1)
  end

  def find_nearest_nodes(node, search_node, search_level)
    return (search_node.value < node.value) ?
      find_nearest_forward_node(node, search_node, search_level) :
      find_nearest_backward_node(node, search_node, search_level)
  end

  def find_nearest_forward_node(node, search_node, search_level)
    while (not search_node[search_level].next.nil? and search_node[search_level].next.value < node.value)
      search_node = search_node[search_level].next
    end
    return search_node, search_node[search_level].next
  end

  def find_nearest_backward_node(node, search_node, search_level)
    while (not search_node[search_level].prev.nil? and search_node[search_level].prev.value > node.value)
      search_node = search_node[search_level].prev
    end
    return search_node[search_level].prev, search_node
  end

  def debug_print
    cur = @head
    cur = cur[0].prev until (cur[0].prev.nil?)
    until (cur.nil?)
      puts cur.inspect
      cur = cur[0].next
    end
  end
end

input = Array.new(10) { rand(100) }
puts input.join(",")
SkipList.new(input)
