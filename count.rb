class Count
  def initialize(count = 0)
    @count = count
  end

  def increment
    @count += 1
  end

  def decrement
    @count -= 1
  end

  def to_i
    return @count
  end
end
