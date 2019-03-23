require "byebug"
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

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
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_node = @head
    while current_node != @tail
      return current_node.val if current_node.key == key
      current_node = current_node.next
    end
    return nil
  end

  def include?(key)
    !get(key).nil?
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    current_node = @head
    while current_node != @tail
      current_node.val = val if current_node.key == key
      current_node = current_node.next
    end
    return nil
  end

  def remove(key)
    current_node = @head
    while current_node != @tail
      if current_node.key == key
        prev_node, next_node = current_node.prev, current_node.next
        next_node.prev = prev_node
        prev_node.next = next_node
        return nil
      end
      current_node = current_node.next
    end
    return nil
  end

  def each
    current_node = first
    while current_node != @tail
      yield(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
     inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
