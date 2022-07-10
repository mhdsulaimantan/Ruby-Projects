def substrings(sentance, dictionary)
  hash_table = Hash.new(0)
  dictionary.each do |dic_word|
    sentance.downcase.split.each do |word|
      if word.include?(dic_word)
        if hash_table[dic_word]
          hash_table[dic_word] += 1
        else
          hash_table[dic_word] = 1
        end
      end
    end
  end
  p hash_table
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]
substrings('below', dictionary)
