class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
    @next, @prev = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    head.next = tail
    tail.prev = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail && tail.prev == head
  end

  def get(key)
    node = target(key)
    node.val if node
  end

  def include?(key)
    !!target(key)
  end

  def append(key, val)
    node = Node.new(key, val)
    node.next = tail
    node.prev = tail.prev
    node.prev.next = node 
    tail.prev = node
  end

  def update(key, val)
    node = target(key)
    node.val = val if node
  end

  def remove(key)
    target(key).remove
  end

  def each
    node = head.next
    while node.next
      yield node
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end

  private
  attr_reader :head, :tail

  def target(key)
    self.find do |node|
      node.key == key
    end
  end
end
