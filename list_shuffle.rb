
require 'pry'

require 'json'

require 'minitest/unit'
require 'minitest/spec'
require 'minitest/autorun'

require 'benchmark'

# [1,2,3,4,5]
# [5,3,4,1,2]

def get_shuffle(list)
  split_list = -> in_list, insert_position do
    case insert_position
      when 0
        [[], in_list]

      when insert_position.eql?(in_list.length)
        [in_list, []]

      else
        prefix = in_list[0..(insert_position - 1)]
        suffix = in_list[insert_position..-1]

        [prefix, suffix]
    end
  end

  # handle exit conditions
  return list if list.empty? or list.length.eql?(1)

  small_shuffle = get_shuffle(list[0..-2])
  insert_location = rand(0..small_shuffle.length)

  prefix, suffix = split_list.call(small_shuffle, insert_location)

  prefix + [list.last] + suffix
end


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
