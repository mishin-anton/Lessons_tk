# 1. Сделать хеш, содержащий месяцы и количество дней в месяце.
# В цикле выводить те месяцы, у которых количество дней ровно 30
months = { 'january' => 31, 'febrary' => 29, 'march' => 31, 'april' => 30,
           'may' => 31, 'june' => 30,  'july' => 31, 'august' => 31,
           'september' => 30, 'october' => 31, 'november' => 30,
           'december' => 31 }
months.each do |month_name, days|
  if days == 30
    puts month_name
  end
end

# 2. Заполнить массив числами от 10 до 100 с шагом 5
arr = []
index = 10
while index <= 100 do
  arr << index
  index += 5
end

# 3. Заполнить массив числами фибоначчи до 100
arr2 = [0, 1]
loop do
  nextvalue = arr2[-1] + arr2[-2]
  break if nextvalue >= 100
  arr2 << nextvalue
end

# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый
# номер буквы в алфавите (a - 1).
hash_alphabet = {}
alphabet = "abcdefghijklmnopqrstuvwxyz"
vowels = "aeiouy"

vowels.each_char do |v|
  hash_alphabet[v] = alphabet.index(v) + 1
end
