# 1. Сделать хеш, содержащий месяцы и количество дней в месяце.
# В цикле выводить те месяцы, у которых количество дней ровно 30
months = { :january => 31, :febrary => 29, :march => 31, :april => 30,
           :may => 31, :june => 30,  :july => 31, :august => 31,
           :september => 30, :october => 31, :november => 30,
           :december => 31 }
months.each do |month_name, days|
  puts month_name if days == 30
end

# 2. Заполнить массив числами от 10 до 100 с шагом 5
arr = (5..100).step(5).to_a

# 3. Заполнить массив числами фибоначчи до 100
arr2 = [0, 1]

while (nextvalue = arr2[-1] + arr2[-2]) <= 100
  arr2 << nextvalue
end

# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый
# номер буквы в алфавите (a - 1).
alphabet = "abcdefghijklmnopqrstuvwxyz"
vowels = "aeiouy"
# vowels.each_char do |v|
#   hash_alphabet[v] = alphabet.index(v) + 1
# end
hash_alphabet = vowels.each_char.with_object({}) do |v, hash|
  hash[v] = alphabet.index(v) +1
end
