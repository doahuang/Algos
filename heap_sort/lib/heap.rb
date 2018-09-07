class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    store.length
  end

  def extract
    out = peek
    @store[0] = store.pop
    self.class.heapify_down(store, 0, &prc)
    out
  end

  def peek
    store[0]
  end

  def push(val)
    store << val
    self.class.heapify_up(store, count - 1, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    left = parent_index * 2 + 1
    right = parent_index * 2 + 2
    return [] if left >= len
    right < len ? [left, right] : [left]
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    childs = child_indices(len, parent_idx)
    return array if childs == []

    prc ||= Proc.new { |x, y| x <=> y }

    left, right = childs
    child_idx = left
    child_idx = right if right && prc.call(array[right], array[left]) == -1

    parent = array[parent_idx]
    child = array[child_idx]

    return array if prc.call(parent, child) == -1

    array[child_idx], array[parent_idx] = parent, child
    heapify_down(array, child_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0

    parent_idx = parent_index(child_idx)
    parent = array[parent_idx]
    child = array[child_idx]

    prc ||= Proc.new { |x, y| x <=> y }

    return array if prc.call(child, parent) == 1

    array[child_idx], array[parent_idx] = parent, child
    heapify_up(array, parent_idx, &prc)
  end
end
