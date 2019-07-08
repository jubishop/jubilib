require_relative 'range.rb'

class Array
  def bsearch_insert(value)
    insertion_index = block_given? ?
        bsearch_index { |x| yield x } :
        bsearch_index { |x| x >= value }
    insertion_index ||= length
    insert(insertion_index, value)
    return insertion_index
  end

  def bsearch_remove(value)
    removal_index = block_given? ?
      bsearch_index { |x| yield x } :
      bsearch_index { |x| x >= value }
    if (removal_index.nil? or self[removal_index] != value)
      return nil
    else
      delete_at(removal_index)
      return removal_index
    end
  end

  def bsearch_include?(value)
    found = self.bsearch { |x| x >= value }
    return (found == value)
  end

  def each_binary_index(left = 0, right = length - 1)
    (left..right).binary_search { |index| yield index }
  end

  def each_binary_value(left = 0, right = length - 1)
    each_binary_index(left, right) { |x| yield self[x] }
  end
end
