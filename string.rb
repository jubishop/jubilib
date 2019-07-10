class String
  include Enumerable

  def each
    return to_enum(:each) unless block_given?
    each_char { |char| yield char }
  end

  def sliding_window
    (0...length).each { |reduction|
      reduced_length = length - reduction
      0.upto(reduction) { |left|
        return self[left, reduced_length] if yield self[left, reduced_length]
      }
    }
  end

  def is_palindrome?
    left, right = 0, length - 1
    while (left < right)
      return false if (self[left] != self[right])
      left += 1
      right -=1
    end
    return true
  end
end
