require_relative '../linked_list.rb'
require_relative '../skiplist.rb'

module Enumerable
  def to_linked_list
    return LinkedList.new(*self)
  end

  def to_skiplist
    return SkipList.new(*self)
  end
end
