def caesar_cipher(sentance, _shift_num, shifted_sentence = '')
  rev_alpha_list = ('a'..'z').to_a.reverse

  sentance.each_char do |ch|
    shifted_sentence << if rev_alpha_list.include?(ch.downcase)
      if ch == ch.upcase
        rev_alpha_list[rev_alpha_list.index(ch.downcase) - 5].upcase
      else
        rev_alpha_list[rev_alpha_list.index(ch.downcase) - 5]
      end

    else
      ch
    end
  end
  shifted_sentence
end

puts "Enter a sentance to encrypt: "
str = gets.chomp
puts "result: #{caesar_cipher(str, 5)}"
