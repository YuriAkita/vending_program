# modelを意識したクラス。自動販売機の読み書きを行う中枢。
class Vending
  attr_reader :slot_money, :sales_money, :stock, :stock_money, :random_stock

  def initialize
    @slot_money = 0
    @sales_money = 0
    @stock_money = { m10: 10, m50: 10, m100: 10, m500: 10, m1000: 10}
    @stock = [["コーラ", 120, 5], ["水", 150, 5], ["レッドブル", 200, 5]]
    @random_stock = [["コーラ", 120, 0], ["ダイエットコーラ", 120, 0], ["お茶", 120, 5]]
  end

  # m01（お金を入れる）
  def slot_money_push(money)
    @slot_money += money
    money = :"m#{money}"
    @stock_money[money] += 1
  end

  # m02（商品を買う）
  def buy_push(number)
    @stock[number - 1][2] -= 1
    @slot_money -= @stock[number - 1][1]
    @sales_money += @stock[number - 1][1]
  end

  # m03（ランダムで商品を買う）
  def random_buy_push(drink)
    @random_stock[drink - 1][2] -= 1
    @slot_money -= @random_stock[drink - 1][1]
    @sales_money += @random_stock[drink - 1][1]
  end

  # （お金を返す）
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
