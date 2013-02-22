
require 'pry'

require 'json'

require 'minitest/unit'
require 'minitest/spec'
require 'minitest/autorun'

require 'benchmark'

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
data = JSON.parse(DATA.gets nil)

puts "run mode: #{data['mode']}"

case data['mode']
  when 'print_seq'
    benchmark print_seq

  when 'compute_seq'
    benchmark compute_seq, data['iterations']
end

#--- DATA
__END__
{
  "mode":         "compute_seq",
  "iterations":   1000
}
