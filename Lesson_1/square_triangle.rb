# ПЛОЩАДЬ ТРЕУГОЛЬНИКА#
# Площадь треугольника можно вычислить,
# зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
# Программа должна запрашивать основание и высоту треугольника и
# возвращать его площадь.

puts "Введите основание треугольника"
a = gets.chomp.to_f

puts "Введите высоту треугольника"
h = gets.chomp.to_f

square = a * h / 2

print "Площадь треугольника = #{square}\n"
