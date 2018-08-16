require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  map = HashMap.new
  
  string.chars.each do |char|
    map[char] ? map[char] += 1 : map[char] = 1
  end
  
  odd_chars = 0

  map.each do |char, count|
    odd_chars += 1 if count.odd?
  end

  odd_chars < 2
end
