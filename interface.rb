# ユーザーの操作とVending機能をつなぐ箇所
class Interface
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @@vending ||= Vending.new
    admin_menu
    user_menu
  end

  def admin_menu
    @admin_menu = { m00: "0.やめる", m11: "1.商品補充", m12: "2.商品追加", m13: "3.商品撤去", m14: "4.在庫確認", m15: "5.売上確認" }
  end

  def user_menu
    @user_menu = { m00: "0.やめる", m01: "1.お金を入れる", m02: "2.商品を買う", m03: "3.ランダムで飲み物を買う" }
  end

  def check_int
    @int = gets
    waiting
    unless @int =~ /^[0-9]+$/
      puts "不正な値が入力されました。もう一度入力してください"
      return check_int
    end
    @int = @int.to_i
  end

  def check_name
    @name = gets.chomp
    if @name.strip.empty?
      puts "何も入力されていません"
      return check_name
    end
    @name
  end

  def drink_menu_select
    puts "番号を入力してください。0で戻る"
    stock_status
    @drink = check_int
    if @@vending.stock.length < @drink
      puts "選択した位置に商品がありません"
      return drink_menu_select
    end
  end

  def stock_status
    @@vending.stock.each_with_index do |(name, price, stock), i|
      puts "商品#{i + 1}:#{name}, 値段:#{price}円, 在庫数:#{stock}本"
    end
  end

  def slot_money
    puts @user_menu[:m01]
    puts "お金を入れてください(10, 50, 100, 500, 1000)"
    money = check_int
    if MONEY.include?(money)
      puts "#{money}円入れました"
      @@vending.slot_money_push(money)
    else
      puts "使用できません"
      slot_money
    end
  end

  def buy
    puts @user_menu[:m02]
    puts "所持金#{@@vending.slot_money}"
    return puts "商品がありません" if @@vending.stock.length.zero?

    drink_menu_select
    return puts "キャンセルしました" if @drink.zero?

    if @@vending.stock[@drink - 1][2].zero? || @@vending.stock[@drink - 1][1] > @@vending.slot_money
      puts "購入できません"
      return buy
    end
    @drink_price = @@vending.stock[@drink - 1][1]
    stock_money_check
    return puts "ごめんなさい、釣り銭切れです" if @check_money != 0
    @@vending.buy_push(@drink)
    puts "#{@@vending.stock[@drink - 1][0]}を買いました"
  end

  def stock_money_check
    @check_money = @@vending.slot_money - @drink_price
    MONEY.reverse_each do |money|
      count = [@check_money / money, @@vending.stock_money[:"m#{money}"]].min
      @check_money -= money * count
    end
  end

  def random_buy
    puts @user_menu[:m03]
    return puts "ランダムで飲み物を買う場合は120円必要です。" if @@vending.slot_money < 120

    @drink = (1..@@vending.random_stock.size).to_a.sample
    if @@vending.random_stock[@drink - 1][2].zero?
      puts "#{@@vending.random_stock[@drink - 1][0]}の在庫がありません。"
    else
      @@vending.random_buy_push(@drink)
      puts "#{@@vending.random_stock[@drink - 1][0]}を購入しました。"
    end
  end

  def return_money
    puts "おつりです#{@@vending.slot_money}円"
    @@vending.return_push
    puts "さようなら、また会いましょう"
  end

  def add_drink
    puts @admin_menu[:m11]
    drink_menu_select
    return puts "キャンセルしました" if @drink.zero?

    puts "本数入力"
    stock = check_int
    @@vending.add_push(@drink, stock)
    puts "在庫を追加しました。#{@@vending.stock[@drink - 1][0]}の在庫数：#{@@vending.stock[@drink - 1][2]}本"
  end

  def new_drink
    puts @admin_menu[:m12]
    puts "商品名を追加してください"
    name = check_name
    puts "値段を入力してください"
    price = check_int
    puts "個数を入力してください"
    stock = check_int
    @@vending.new_push(name, price, stock)
    puts "『#{name}』を『#{price}円』で『#{stock}本』追加しました。"
  end

  def remove_drink
    puts @admin_menu[:m13]
    return puts "商品がありません" if @@vending.stock.length.zero?

    drink_menu_select
    return puts "キャンセルしました" if @drink.zero?

    drink_name = @@vending.stock[@drink - 1][0]
    @@vending.remove_push(@drink)
    puts "#{drink_name}を撤去しました"
  end

  def drink_menu
    puts @admin_menu[:m14]
    stock_status
  end

  def sales
    puts @admin_menu[:m15]
    puts "残金：#{@@vending.slot_money}円"
    puts "売上：#{@@vending.sales_money}円"
  end

  def check_stock_money
    puts @admin_menu[:m16]
    puts "1000円：#{@@vending.stock_money[:m1000]}枚"
    puts "500円：#{@@vending.stock_money[:m500]}枚"
    puts "100円：#{@@vending.stock_money[:m100]}枚"
    puts "50円：#{@@vending.stock_money[:m50]}枚"
    puts "10円：#{@@vending.stock_money[:m10]}枚"
  end
end
