# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  def initialize
    @store = RingBuffer.new
    @maxs = RingBuffer.new
  end

  def enqueue(val)
    store.push(val)
    while maxs.length > 0 && val > maxs[maxs.length - 1]
      maxs.pop
    end
    maxs.push(val)
  end

  def dequeue
    el = store.shift
    maxs.shift if el == maxs[0]
    el
  end

  def max 
    maxs[0]
  end

  def length 
    store.length
  end

  protected
  attr_reader :store, :maxs
end