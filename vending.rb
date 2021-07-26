# modelを意識したクラス。自動販売機の読み書きを行う中枢。
class Vending
  attr_reader :slot_money, :sales_money, :stock

  def initialize
    @slot_money = 150
    @sales_money = 0
    @stock = [["コーラ", 120, 0], ["水", 150, 1], ["レッドブル", 200, 7]]
  end

  # m01（お金を入れる）
  def slot_money_push(money)
    @slot_money += money
  end

  # m02（商品を買う）
  def buy_push(number)
    @stock[number - 1][2] -= 1
    @slot_money -= @stock[number - 1][1]
    @sales_money += @stock[number - 1][1]
  end

  # m03（お金を返す）
  def return_push
    @slot_money = 0
  end

  # m011（商品補充）
  def add_push(drink, stock)
    @stock[drink - 1][2] += stock
  end

  # m12（商品追加）
  def new_push(name, price, stock)
    @stock << [name, price, stock]
  end

  # m13（商品撤去）
  def remove_push(drink)
    @stock.delete_at(drink - 1)
  end
end
