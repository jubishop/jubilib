class ListNode
  attr_accessor :val, :next
  def initialize(val = 0)
    @val = val
  end
end

class LinkedList
  attr_accessor :head, :tail
  def initialize(values = [])
    unless (values.empty?)
      @head = ListNode.new(values.shift)
      cur = @head
      until (values.empty?)
        cur.next = ListNode.new(values.shift)
        cur = cur.next
      end
      @tail = cur
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
