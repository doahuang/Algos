class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.map.with_index{ |el, i| el.hash * i }
        .reduce(0, :+)
  end
end

class String
  def hash
    self.chars
        .map(&:ord)
        .hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.map{ |k, v| k.to_s.hash + v.to_s.hash }
        .hash
  end
end
