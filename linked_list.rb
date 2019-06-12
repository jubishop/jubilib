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

  def add_node(value)
    new_node = ListNode.new(value)
    if (@head.nil?)
      @head = @tail = new_node
    else
      @tail.next = new_node
      @tail = new_node
    end
  end

  def remove_node(once = false)
    prev = nil
    cur = @head
    until (cur.nil?)
      if (yield cur.val)
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
