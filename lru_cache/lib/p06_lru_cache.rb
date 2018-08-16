require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    node = map[key]
    if node
      update_node!(node)
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private
  attr_reader :store, :map, :max, :prc

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = prc.call(key)
    node = store.append(key, val)
    map[key] = node
    eject! if count > max
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    map[node.key] = store.append(node.key, node.val)
  end

  def eject!
    node = store.first
    map.delete(node.key)
    node.remove
  end
end
