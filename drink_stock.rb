class DrinkStock
  attr_reader :error_message

  def initialize
    # @stocks = [["コーラ", 120, 5], ["水", 150, 5], ["レッドブル", 200, 5]]
    @stocks = {"コーラ": { price: 120, stock: 5}, "水": { price: 150, stock: 5}, ["レッドブル", 200, 5]}
  end

  def add_scotck
    @stocks
  end

  def buy(name)

  end

  def fetch_stock(name)
    # @stocks.find { |stock| stock[0] == name }
    @stocks.finds[name]
  end

  def byable?
    if 在庫がない
      error_message << '在在庫がありません'
      return false
    end
  end
end
