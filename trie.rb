class Trie
  class TrieNode
    attr_accessor :exists
    def initialize
      @children = Hash.new
      @exists = false
    end

    def has_child?(char)
      return @children.has_key? char
    end

    def [](char)
      return @children[char]
    end

    def []=(char, node)
      @children[char] = node
    end
  end

  def initialize(words = [])
    @head = TrieNode.new
    words.each { |word| add_word(word) }
  end

  def add_word(word)
    cur = @head
    word.each_char { |char|
      cur[char] = TrieNode.new unless (cur.has_child? char)
      cur = cur[char]
    }
    cur.exists = true
  end

  def find_word(word)
    cur = @head
    word.each_char { |char|
      cur = cur[char]
      return false if cur.nil?
    }
    return cur.exists ? cur : false
  end
end
