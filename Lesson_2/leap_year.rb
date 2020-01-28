# 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у
# пользователя). Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным. (Запрещено использовать встроенные в
# ruby методы для этого вроде Date#yday или Date#leap?) Алгоритм опредления
# високосного года: www.adm.yar.ru

days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
number_of_date = 0

puts "Число: "
date = gets.chomp.to_i
puts "Месяц: "
month = gets.chomp.to_i
puts "Year: "
year = gets.chomp.chomp.to_i

if (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)
  days_in_months[1] = 29
end

days_in_months[0..month-1].each do |m|
  if month-1 != 0
    number_of_date += m
    month = month - 1
  end
end

number_of_date += date

puts number_of_date
