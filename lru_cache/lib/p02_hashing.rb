class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.map.with_index do |el, i|
      el.hash * i
    end.reduce(0, :+)
  end
end

class String
  def hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
