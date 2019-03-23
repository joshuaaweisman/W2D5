require_relative 'p04_linked_list'
require "byebug"

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    target_bucket = @store[key.hash % num_buckets]

    unless target_bucket.include?(key)
      @count += 1

      if @count > num_buckets
        resize!
        target_bucket = @store[key.hash % num_buckets]
      end
      target_bucket.append(key, val)
    end
  end

  def get(key)
  end

  def delete(key)
    @store[key.hash % num_buckets].remove(key)
    @count -= 1
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  # alias_method :[], :get
  def [](key)
    @store[key.hash % num_buckets].get(key)
  end

  # alias_method :[]=, :set
  def []=(key, val)
    bucket = @store[key.hash % num_buckets] 
    if bucket.include?(key)
      bucket.update(key, val)
    else
      bucket.append(key, val)
      @count += 1
      if @count > num_buckets
        resize!
        target_bucket = @store[key.hash % num_buckets]
      end
    end
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store.dup
    @store = Array.new(num_buckets * 2) {LinkedList.new}
    temp.each do |linked|
      linked.each do |node|
        self.set(node.key, node.val)
        @count -= 1
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
