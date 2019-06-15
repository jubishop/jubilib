class String
  def each
    each_char { |char| yield char }
  end
end

class Trie
  class TrieNode
    attr_accessor :exists
    def initialize
      @children = Hash.new
      @exists = false
    end

    def has_child?(value)
      return @children.has_key? value
    end

    def [](value)
      return @children[value]
    end

    def []=(value, node)
      @children[value] = node
    end
  end

  def initialize(list_of_values = [])
    @head = TrieNode.new
    list_of_values.each { |values| add_path(values) }
  end

  def has_path(values)
    cur = @head
    values.each { |value|
      cur = cur[value]
      return false if cur.nil?
    }
    return true
  end

  def add_leaf(values)
    cur = @head
    values.each { |value|
      cur[value] = TrieNode.new unless (cur.has_child? value)
      cur = cur[value]
    }
    cur.exists = true
  end

  def has_leaf(values)
    cur = @head
    values.each { |value|
      cur = cur[value]
      return false if cur.nil?
    }
    return cur.exists ? cur : false
  end
end
