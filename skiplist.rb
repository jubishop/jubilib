require_relative 'modules/enumerable.rb'

class SkipList
  include Enumerable
  def each
    return to_enum(:each) unless block_given?

    cur = @head
    cur = cur[0].prev until (cur.nil? or cur[0].prev.nil?)
    until (cur.nil?)
      yield cur
      cur = cur[0].next
    end
  end

  def each_value
    return to_enum(:each_value) unless block_given?

    cur = @head
    cur = cur[0].prev until (cur.nil? or cur[0].prev.nil?)
    until (cur.nil?)
      yield cur.value
      cur = cur[0].next
    end
  end

  attr_accessor :size
  def initialize(*values)
    @size = 0
    values.compact.each { |value| add(value) }
  end

  def add(value)
    node = SkipNode.new(value)
    @head = node and return if (@head.nil?)

    # find top level prev/next for this node
    max_level = [node.level, @head.level].min
    prev_node, next_node = dive_to_nearest_nodes(node.value, node.level)
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

    @head = node if (node.level > @head.level or (node.level == @head.level and node[node.level].next.equal?(@head)))

    @size += 1
    return node
  end

  def delete(value)
    found_node = find(value)
    return delete_node(found_node) if (found_node)
    return false
  end

  def include?(value)
    return (find(value) != false)
  end

  def find(value)
    prev_node, next_node = dive_to_nearest_nodes(value, 0)
    return prev_node if (not prev_node.nil? and prev_node.value == value)
    return next_node if (not next_node.nil? and next_node.value == value)
    return false
  end

  def delete_node(node)
    if (node.equal?(@head))
      @head.level.downto(0) { |level|
        if (not @head[level].prev.nil?)
          @head = @head[level].prev
          break
        elsif (not @head[level].next.nil?)
          @head = @head[level].next
          break
        end
      }
    end
    @head = nil if (node.equal?(@head))

    node.level.downto(0) { |level|
      prev_node = node[level].prev
      next_node = node[level].next
      prev_node[level].next = next_node unless (prev_node.nil?)
      next_node[level].prev = prev_node unless (next_node.nil?)
      node[level].prev = node[level].next = nil
    }

    @size -= 1
    return node
  end

  def values
    to_a.map { |node| node.value }
  end

  private

  # workhorse recursive function that works with the others below to find the nodes surrounding a value
  def dive_to_nearest_nodes(value, level, search_node = @head, search_level = @head.level)
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

  class SkipNode
    include Comparable
    def <=>(other)
      @value <=> other.value
    end

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
end
