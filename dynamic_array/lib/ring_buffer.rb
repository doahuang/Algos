require_relative 'static_array'

class RingBuffer
  attr_reader :length 

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  def [](index)
    validate_index(index)
    store[(index + start_idx) % capacity]
  end

  def []=(index, value)  
    store[(index + start_idx) % capacity] = value
  end

  def push(val)
    resize! if length == capacity
    self[length] = val
    @length += 1
  end

  def pop
    validate_empty
    el = self[length - 1]
    self[length - 1] = nil
    @length -= 1
    el
  end

  def shift
    validate_empty
    el = self[0]
    self[0] = nil
    @start_idx += 1
    @length -= 1
    el
  end 

  def unshift(val)
    resize! if length == capacity
    @start_idx -= 1
    self[0] = val
    @length += 1
  end

  protected
  attr_accessor :store, :capacity, :start_idx
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
      new_store[i] = self[i]
    end
    @store = new_store
    @capacity *= 2
    @start_idx = 0
  end
end