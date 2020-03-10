require_relative 'modules/enumerable.rb'

class LinkedList
  include Enumerable
  def each
    return to_enum(:each) unless block_given?

    cur = @head
    until (cur.nil?)
      yield cur
      cur = cur.next
    end
  end

  def each_value
    return to_enum(:each_value) unless block_given?

    cur = @head
    until (cur.nil?)
      yield cur.value
      cur = cur.next
    end
  end

  def is_palindrome?
    left, right = @head, @tail
    (@size/2).times {
      return false unless left == right
      left = left.next
      right = right.prev
    }
    return true
  end

  attr_accessor :head, :tail, :size
  def initialize(*values)
    @size = 0
    values.compact.each { |value| push(value) }
  end

  def empty?
    return @head.nil?
  end

  def push_node(node)
    if (@head.nil?)
      @head = @tail = node
    else
      @tail.next = node
      node.prev = @tail
      @tail = node
    end
    @size += 1
    return node
  end

  def push(value)
    return push_node(ListNode.new(value))
  end

  def unshift_node(node)
    if (@head.nil?)
      @head = @tail = node
    else
      node.next = @head
      @head.prev = node
      @head = node
    end
    @size += 1
    return node
  end

  def unshift(value)
    return unshift_node(ListNode.new(value))
  end

  def pop_node
    popped_node = @tail
    unless (@tail.nil?)
      if (@head.equal?(@tail))
        @tail = @head = nil
      else
        @tail = tail.prev
        @tail.next = nil
      end
      @size -= 1
    end
    return popped_node
  end

  def pop
    return empty? ? nil : pop_node.value
  end

  def shift_node
    shifted_node = @head
    unless (@head.nil?)
      if (@head.equal?(@tail))
        @tail = @head = nil
      else
        @head = head.next
        @head.prev = nil
      end
      @size -= 1
    end
    return shifted_node
  end

  def shift
    return empty? ? nil : shift_node.value
  end

  def remove_node(once = false)
    cur = @head
    until (cur.nil?)
      if (yield cur)
        if (cur.prev.nil?)
          @head = cur.next
          @head.prev = nil
        end
        if (cur.next.nil?)
          @tail = cur.prev
          @tail.next = nil
        end
        unless (cur.prev.nil? or cur.next.nil?)
          cur.prev.next = cur.next
          cur.next.prev = cur.prev
        end
        @size -= 1
        return if (once)
      end
      cur = cur.next
    end
  end

  def values
    to_a.map{ |node| node.value }
  end

  private

  class ListNode
    include Comparable
    def <=>(other)
      @value <=> other.value
    end

    attr_accessor :value, :prev, :next
    def initialize(value)
      @value = value
    end
    def val; return @value; end
  end
end
