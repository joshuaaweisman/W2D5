class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    target_bucket = self[key]

    unless target_bucket.include?(key)
      @count += 1

      if @count > num_buckets
        resize!
        target_bucket = self[key]
      end
      target_bucket << key
    end

  end

  def include?(key)
    target_bucket = self[key]
    target_bucket.include?(key)
  end

  def remove(key)
    target_bucket = self[key]
    unless target_bucket.empty?
      target_bucket.delete(key)
      @count -= 1
    end
  end

  private

  def [](ele)
    @store[ele.hash % num_buckets]
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
