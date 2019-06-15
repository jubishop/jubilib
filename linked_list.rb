class ListNode
  attr_accessor :val, :next, :prev
  def initialize(val)
    @val = val
  end
end

class LinkedList
  attr_accessor :head, :tail
  def initialize(values = [])
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
      if (@head == @tail)
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
      if (@head == @tail)
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

  def to_a
    array = Array.new
    cur = @head
    until (cur.nil?)
      array.push(cur.val)
      cur = cur.next
    end
    return array
  end
end
