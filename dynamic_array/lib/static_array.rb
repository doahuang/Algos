# This class just dumbs down a regular Array to be statically sized.

class StaticArray
  def initialize(length)
    @store = Array.new(length)
  end

  def [](index)
    store[index]
  end

  def []=(index, value)
    store[index] = value
  end

  protected
  attr_accessor :store
end