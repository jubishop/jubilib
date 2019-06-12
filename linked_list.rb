class ListNode
  attr_accessor :val, :next
  def initialize(val = 0)
    @val = val
  end
end

class LinkedList
  attr_accessor :head
  def initialize(values = [])
    unless (values.empty?)
      @head = ListNode.new(values.shift)
      cur = @head
      until (values.empty?)
        cur.next = ListNode.new(values.shift)
        cur = cur.next
      end
    end
  end

  def remove_node(once = false)
    prev = nil
    cur = @head
    until (cur.nil?)
      if (yield cur.val)
        prev.nil? ? @head = @head.next : prev.next = cur.next
        return if (once)
      end
      prev = cur
      cur = cur.next
    end
  end
end
