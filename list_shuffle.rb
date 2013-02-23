#
# input:    a list like [1,2,3,4,5]
# output:   a random rearrangement of input, e.g. [5,3,4,1,2]
#
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

#--- main
(1..10).each { |n| puts "#{n}: #{get_shuffle([1, 2, 3, 4, 5])}" }
