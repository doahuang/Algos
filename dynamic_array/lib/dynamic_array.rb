require_relative 'static_array'

class DynamicArray
  attr_reader :length 

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  def [](index)
    validate_index(index)
    store[index]
  end

  def []=(index, value)
    store[index] = value
  end

  def push(val)
    resize! if length == capacity
    store[length - 1] = val
    @length += 1
  end

  def pop
    validate_empty
    store[length - 1] = nil
    @length -= 1
  end

  def shift
    validate_empty
    el = store[0]
    store[0] = nil
    (0...length).each do |i|
      store[i] = store[i + 1]
    end
    @length -= 1
    el
  end 

  def unshift(val)
    resize! if length == capacity
    length.downto(1).each do |i|
      store[i] = store[i - 1]
    end
    store[0] = val
    @length += 1
  end

  protected
  attr_accessor :store, :capacity
  attr_writer :length

  def validate_empty
    raise 'index out of bounds' if length == 0
  end

  def validate_index(index)
    raise 'index out of bounds' if index >= length
  end

  def resize!
    new_store = StaticArray.new(capacity * 2)
    length.times do |i|
      new_store[i] = store[i]
    end
    @store = new_store
    @capacity *= 2
  end
end