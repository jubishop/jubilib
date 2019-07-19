require_relative 'linked_list.rb'

module Enumerable
  def to_ll
    list = LinkedList.new
    each { |value|
      list.push(value)
    }
    return list
  end
end
