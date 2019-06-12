class Array
  def bsearch_insert(value)
    insertion_index = bsearch_index { |x| x >= value } || length
    insert(insertion_index, value)
  end
end
