require "byebug"

class MaxIntSet
  attr_accessor :store

  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" if !is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num > 0 && num <= @store.length
  end

  def validate!(num)
  end
end








class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    target_bucket = self[num]
    target_bucket << num
  end

  def remove(num)
    target_bucket = self[num]
    target_bucket.delete(num)
  end

  def include?(num)
    #####? How do I do this without include?
    target_bucket = self[num]
    target_bucket.include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end







class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    target_bucket = self[num]

    unless target_bucket.include?(num)
      @count += 1

      if @count > num_buckets
        resize!
        target_bucket = self[num]
      end
      target_bucket << num
    end

  end

  def remove(num)
    target_bucket = self[num]
    unless target_bucket.empty?
      target_bucket.delete(num)
      @count -= 1
    end
  end

  def include?(num)
    target_bucket = self[num]
    target_bucket.include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = my_flatten(@store.dup)
    @store = Array.new(num_buckets*2) {Array.new}
    temp.each do |ele|
      self.insert(ele)
      @count -= 1
    end
  end

  def my_flatten(arr)
    new_arr = []
    arr.each do |subarr|
      new_arr += subarr
    end
    new_arr
  end
end
