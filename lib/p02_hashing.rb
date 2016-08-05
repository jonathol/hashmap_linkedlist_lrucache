class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    each_with_index do |el, i|
      sum += (el.hash * i.hash)
    end
    sum
  end
end

class String
  def hash
    sum = 0
    chars.each_with_index do |char, i|
      sum += char.ord*i.hash
    end
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    to_a.each do |arr|
      sum += arr.hash
    end
    sum
  end
end
