require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    delete(key) if include?(key)
    resize! if @count >= num_buckets
    @count += 1
    bucket(key).insert(key,val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    removal = bucket(key).remove(key)
    @count -= 1 if removal
    removal
  end

  def each

    @store.reverse.each do |bucket|
      bucket.each do |link|
        yield [link.key, link.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set
  alias_method :inspect, :to_s

  private

  def num_buckets
    @store.length
  end

  def resize!
    old = @store
    @store = Array.new(num_buckets*2) { LinkedList.new}
    @count = 0
    old.each do |bucket|
      bucket.each{ |link| set(link.key, link.val) }
    end
  end

  def bucket(key)
    @store[key.hash%num_buckets]
  end
end
