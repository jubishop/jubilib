class ListNode
  attr_accessor :val, :next
  def initialize(val)
    @val = val
  end
end

class LinkedList
  attr_accessor :head, :tail
  def initialize(values = [])
    values.each { |value| add_node(value) }
  end

  def push_new_node(node)
    if (@head.nil?)
      @head = @tail = node
    else
      @tail.next = node
      @tail = node
    end
  end

  def unshift_new_node(node)
    if (@head.nil?)
      @head = @tail = node
    else
      node.next = @head
      @head = node
    end
  end

  def shift_node
    shifted_node = @head
    unless (@head.nil?)
      if (@head == @tail)
        @tail = @head = nil
      else
        @head = head.next
      end
    end
    return shifted_node
  end

  # pop_node will require doubly_linked list

  def remove_node(once = false)
    prev = nil
    cur = @head
    until (cur.nil?)
      if (yield cur)
        if (prev.nil?)
          @head = @head.next
          @tail = @head if (@head.nil? or @head.next.nil?)
        else
          prev.next = cur.next
          @tail = prev if (prev.next.nil?)
        end
        return if (once)
      end
      prev = cur
      cur = cur.next
    end
  end
end
