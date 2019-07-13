# Includers must implement:
#   length
#   [index]
#   [index, length]
module JubiList
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
    (length/2).times {
      return false unless self[left] == self[right]
      left += 1
      right -=1
    }
    return true
  end
end
