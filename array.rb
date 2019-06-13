class Array
  def bsearch_insert(value)
    insertion_index = bsearch_index { |x| x >= value } || length
    insert(insertion_index, value)
  end

  def each_binary_index(left = 0, right = length - 1)
    while (left <= right)
      middle = left + ((right - left) / 2)
      result = yield middle
      if (result == 0)
        return middle
      elsif (result == -1)
        left = middle + 1
      else
        right = middle - 1
      end
    end
    return nil
  end

  def each_binary_value(left = 0, right = length - 1)
    each_binary_index(left, right) { |x| yield self[x] }
  end
end
