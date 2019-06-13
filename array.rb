require_relative 'range.rb'

class Array
  def bsearch_insert(value)
    insertion_index = bsearch_index { |x| x >= value } || length
    insert(insertion_index, value)
  end

  def each_binary_index(left = 0, right = length - 1)
    (0...length).binary_search { |index| yield index }
  end

  def each_binary_value(left = 0, right = length - 1)
    each_binary_index(left, right) { |x| yield self[x] }
  end
end
