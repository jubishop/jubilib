class Count
  include Comparable
  def <=>(other)
    if (other.is_a? Numeric)
      return @count <=> other
    elsif (other.is_a? Count)
      return @count <=> other.count
    else
      raise "Can't compare #{other.class} with a Count"
    end
  end

  attr_accessor :count
  def initialize(count = 0)
    @count = count
  end

  def add(num)
    @count += num
  end

  def subtract(num)
    @count -= num
  end

  def set(num)
    @count = num
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
