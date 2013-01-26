
#
# given a text file. treat each line of the file as a string. generate and
# print out all the permutations of each of these strings
#

require 'pry'

def generate_longer_perms(perm, last_let)
  list = []
  perm_size = perm.size
  (0..perm_size).each do |nn|
    new_perm  = if (nn <= 0)
                  ''
                else
                  perm[0..(nn - 1)]
                end

    new_perm << last_let
    new_perm << perm[nn..(perm_size - 1)] if (perm_size > nn)

    list << new_perm
  end

  list
end

def permute_list(word)
  return [word, word.reverse] if (word.size.eql? 2)

  prefix_perms    = permute_list(word[0..-2])

  prefix_perms.map { |perm| generate_longer_perms(perm, word[-1]) }.flatten.uniq
end

#--- main()
File.readlines('data.txt').each do |word|
  word_permutations = permute_list(word.chop).sort

  puts "word = #{word}"
  puts "word_permutations = #{word_permutations.inspect}"
  puts "-------------------------------------------"
  puts

  binding.pry
end
