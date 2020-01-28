# Сумма покупок. Пользователь вводит поочередно название товара,
# цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не
# введет "стоп" в качестве названия товара. На основе введенных данных
# требуетеся:Заполнить и вывести на экран хеш, ключами которого являются
# названия товаров, а значением - вложенный хеш, содержащий цену за единицу
# товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

basket = {}
total = 0.0

loop do
  puts "Для остановки покупок введите 'стоп'"
  puts "Название товара: "
  name_of_product = gets.chomp
  break if name_of_product == "стоп"

  puts "Цена за единицу: "
  price = gets.chomp.to_f
  puts "Количество: "
  quantity = gets.chomp.to_f

  basket[name_of_product] = { "price" => price, "quantity" => quantity }
end

basket.each {|name, data| total += data["price"] * data["quantity"]}

puts "Basket: #{basket}"
puts "TOTAL: #{total}"