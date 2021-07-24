
class Vending
  attr_reader :slot_money,:sales_money,:stock

  def initialize
    @slot_money = 150
    @sales_money = 0
    @stock = [["コーラ",120,0],["水",150,1],["レッドブル",200,7]]
  end

  def slot_money_push(money) #m01
    @slot_money += money
  end

  def buy_push(number) #m02
    @stock[number-1][2] -= 1
    @slot_money -= @stock[number-1][1]
    @sales_money += @stock[number-1][1]
  end

  def return_push #m03
    @slot_money = 0
  end

  def add_push(drink,stock) #m11
    @stock[drink-1][2] += stock
  end

  def new_push(name,price,stock) #m12
    @stock << [name,price,stock]
  end

  def remove_push(drink) #m13
    @stock.delete_at(drink-1)
  end
end
