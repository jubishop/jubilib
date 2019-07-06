# Usage:
# (min..max) { |x| x <=> target } => Integer or nil
class Range
  def binary_search
    left, right = min, max
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
end
