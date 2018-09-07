require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |x, y| y <=> x }

    (1...length).each do |i|
      BinaryMinHeap.heapify_up(self, i, &prc)
    end

    (length - 1).downto(1) do |i|
      self[0], self[i] = self[i], self[0]
      BinaryMinHeap.heapify_down(self, 0, i, &prc)
    end

    self
  end
end
