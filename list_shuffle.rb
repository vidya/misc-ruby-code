
require 'pry'

require 'json'

require 'minitest/unit'
require 'minitest/spec'
require 'minitest/autorun'

require 'benchmark'

#--------------- shuffle { ----------------------------
# [1,2,3,4,5]
# [5,3,4,1,2]

def get_shuffle(list)
  # handle exit conditions
  return list if list.empty?

  return list if list.length.eql?(1)

  last_num = list.last

  # slice away the last number
  small_shuffle = get_shuffle(list.slice 0..-2)

  #put last_num at a random place in small_shuffle
  last_num_place = rand(0..small_shuffle.length)

  return ([last_num] + small_shuffle) if last_num_place.eql?(0)

  return (small_shuffle << last_num) if last_num_place.eql?(small_shuffle.length)

  shuffle = []

  small_shuffle_ind = 0

  loop do
    #binding.pry
    if small_shuffle_ind < last_num_place
      shuffle << small_shuffle[small_shuffle_ind]
      small_shuffle_ind += 1
    else
      return (shuffle << last_num) +  small_shuffle[small_shuffle_ind..-1]
    end
  end
end
#-------------- } shuffle -----------------------------


class Fibonacci
  attr_accessor :fib_num

  def initialize
    @fib_num = [0, 1]
  end

  #                     1  2  3  4  5  6  7   8
  # fibonacci sequence: 0, 1, 1, 2, 3, 5, 8, 13, ...
  #
  def fib(n)
    return fib_num[n] if fib_num[n]

    fib_num[n - 2] = fib(n - 2) unless fib_num[n - 2]
    fib_num[n - 1] = fib(n - 1) unless fib_num[n - 1]

    return (fib_num[n - 2] + fib_num[n - 1])
  end
end

compute_seq = -> do
  fib_obj = Fibonacci.new

  (1..20).each { |n| fib_obj.fib n }
end

print_seq = -> do
  fib_obj = Fibonacci.new

  (1..20).each { |n| puts "#{n}: #{fib_obj.fib(n)}" }
end

#--- test
describe Fibonacci, "Test Fibonacci sequence class" do
  before do
    @fib_obj = Fibonacci.new
  end

  it "should say (8th fibonacci_number == 21)" do
    @fib_obj.fib(8).must_equal 21
  end
end

#--- benchmark
def benchmark(lambda_func, iterations = 1)
  puts "benchmark: iterations = #{iterations}"

  Benchmark.bm do |x|
    x.report { iterations.times do  ; lambda_func.call; end }
  end
end

#--- main
#data = JSON.parse(DATA.gets nil)
#
#puts "run mode: #{data['mode']}"
#
#case data['mode']
#  when 'print_seq'
#    benchmark print_seq
#
#  when 'compute_seq'
#    benchmark compute_seq, data['iterations']
#end

l1 = [1, 2, 3, 4, 5]

l2 = get_shuffle(l1)

binding.pry

#--- DATA
__END__
{
  "mode":         "compute_seq",
  "iterations":   1000
}
