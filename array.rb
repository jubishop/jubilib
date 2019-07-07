require_relative 'range.rb'

class Array
  def bsearch_insert(value)
    insertion_index = block_given? ?
        bsearch_index { |x| yield x } :
        bsearch_index { |x| x >= value }
    insert(insertion_index || length, value)
  end

  def each_binary_index(left = 0, right = length - 1)
    (left..right).binary_search { |index| yield index }
  end

  def each_binary_value(left = 0, right = length - 1)
    each_binary_index(left, right) { |x| yield self[x] }
  end
end
