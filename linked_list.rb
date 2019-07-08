class ListNode
  include Comparable
  def <=>(other)
    @val <=> other.val
  end

  attr_accessor :val, :prev, :next
  def initialize(val)
    @val = val
  end
end

class LinkedList
  include Enumerable
  def each
    cur = @head
    until (cur.nil?)
      yield cur
      cur = cur.next
    end
  end

  attr_accessor :head, :tail
  def initialize(*values)
    values.each { |value| push_new_node(ListNode.new(value)) }
  end

  def push_new_node(node)
    if (@head.nil?)
      @head = @tail = node
    else
      @tail.next = node
      node.prev = @tail
      @tail = node
    end
  end

  def unshift_new_node(node)
    if (@head.nil?)
      @head = @tail = node
    else
      node.next = @head
      @head.prev = node
      @head = node
    end
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
    end
    return popped_node
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
    end
    return shifted_node
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
        return if (once)
      end
      cur = cur.next
    end
  end

  def values
    to_a.map{ |node| node.val }
  end
end

# Helpers for using just ListNode's
def make_list(*array)
  return nil if array.nil? or array.empty?
  head = ListNode.new(array.shift)
  cur = head
  array.each { |elem|
    cur.next = ListNode.new(elem)
    cur = cur.next
  }
  return head
end

def print_list(head)
  return if head.nil?
  until (head.nil?)
    print "#{head.val}"
    print "," unless head.next.nil?
    head = head.next
  end
  puts ""
end
