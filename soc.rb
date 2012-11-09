
#
# given a text file. treat each line of the file as a string. generate and
# print out all the permutations of each of these strings
#

require 'pry'

def generate_longer_perms(perm, last_let)
  list = []
  perm_size = perm.size
  (0..perm_size).each do |nn|
    new_perm = ''
    new_perm << perm[0..(nn - 1)] if nn > 0
    new_perm << last_let
    new_perm << perm[nn..(perm_size - 1)] if perm_size > nn

    list << new_perm
  end

  list
end

def permute_list(word)
  return [word, word.reverse] if word.size.eql? 2

  prefix_perms    = permute_list word[0..-2]

  last_let        = word[-1]
  perm_list       = prefix_perms.inject([]) { |list, perm| list << generate_longer_perms(perm, last_let) }

  perm_list.flatten.uniq
end

#--- main()
File.open 'data.rb' do |infile|
  while (word = infile.gets)
    puts "word = #{word}"

    word_permutations = permute_list(word.chop).sort

    puts "word_permutations = #{word_permutations.inspect}"

    puts "-------------------------------------------"
    puts

    binding.pry
  end
end