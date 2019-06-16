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

  def to_s
    "#{@value}{#{@level}}"
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
    prev_node, next_node = dive_to_nearest_nodes(node.value, node.level, @head, @head.level)
    node[max_level].next = next_node
    node[max_level].prev = prev_node
    next_node[max_level].prev = node unless next_node.nil?
    prev_node[max_level].next = node unless prev_node.nil?

    # now find prev/next for all lower levels
    (max_level-1).downto(0) { |search_level|
      prev_node, next_node = dive_to_nearest_nodes(node.value, node.level, prev_node || next_node, search_level)
      node[search_level].next = next_node
      node[search_level].prev = prev_node
      next_node[search_level].prev = node unless next_node.nil?
      prev_node[search_level].next = node unless prev_node.nil?
    }

    @head = node if (node.level > @head.level or (node.level == @head.level and node[node.level].next == @head))
  end

  def to_a
    array = Array.new
    cur = @head
    cur = cur[0].prev until cur[0].prev.nil?
    until (cur.nil?)
      array.push(cur.value)
      cur = cur[0].next
    end
    return array
  end

  def debug_print
    puts "Head is #{@head}"
    0.upto(@head.level) { |level|
      list = Array.new
      cur = @head
      cur = cur[level].prev until (cur[level].prev.nil?)
      until (cur.nil?)
        list.push(cur.to_s)
        cur = cur[level].next
      end
      puts "Level #{level}: #{list.join(",")}"
    }
  end

  private

  def dive_to_nearest_nodes(value, level, search_node, search_level)
    return [search_node, search_node[[level, search_level].min].next] if (value == search_node.value)

    return (search_node.value < value) ?
      dive_forward_to_nearest_nodes(value, level, search_node, search_level) :
      dive_backward_to_nearest_nodes(value, level, search_node, search_level)
  end

  def dive_forward_to_nearest_nodes(value, level, search_node, search_level)
    search_node, next_node = find_nearest_forward_node(value, level, search_node, search_level)
    return (level >= search_level) ? [search_node, next_node] :
      dive_to_nearest_nodes(value, level, search_node, search_level - 1)
  end

  def dive_backward_to_nearest_nodes(value, level, search_node, search_level)
    prev_node, search_node = find_nearest_backward_node(value, level, search_node, search_level)
    return (level >= search_level) ? [prev_node, search_node] :
      dive_to_nearest_nodes(value, level, search_node, search_level - 1)
  end

  def find_nearest_forward_node(value, level, search_node, search_level)
    while (not search_node[search_level].next.nil? and search_node[search_level].next.value < value)
      search_node = search_node[search_level].next
    end
    return search_node, search_node[search_level].next
  end

  def find_nearest_backward_node(value, level, search_node, search_level)
    while (not search_node[search_level].prev.nil? and search_node[search_level].prev.value > value)
      search_node = search_node[search_level].prev
    end
    return search_node[search_level].prev, search_node
  end
end
