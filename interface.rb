
class Interface
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
      @@vending ||= Vending.new
      admin_menu
      user_menu
  end

  def admin_menu
    @admin_menu = { m00:'0.やめる', m11: '1.商品補充', m12: '2.商品追加', m13: '3.商品撤去', m14: '4.在庫確認', m15: '5.売上確認' }
  end

  def user_menu
    @user_menu = { m00: '0.やめる', m01: '1.お金を入れる', m02: '2.商品を買う' }
  end

  def get_int
    @int = gets
    waiting
    unless @int =~ /^[0-9]+$/ then
      puts "不正な値が入力されました。もう一度入力してください"
      return get_int
    end
    @int = @int.to_i
  end

  def get_name
    @name = gets.chomp
    if @name.strip.empty?
      puts "何も入力されていません"
      return get_name
    end
    @name
  end

  def drink_menu_select
    puts "番号を入力してください。0で戻る"
    stock_status
    get_int
    @drink = @int
    if @@vending.stock.length < @int
      puts "選択した位置に商品がありません"
      return drink_menu_select
    end
    @int
  end

  def stock_status
    @@vending.stock.each_with_index do |(name, price, stock), i|
      puts "商品#{i+1}:#{name}, 値段:#{price}円, 在庫数:#{stock}本"
    end
  end

  def slot_money #m01
    puts @user_menu[:m01]
    puts "お金を入れてください(10,50,100,500,1000)"
    money = get_int
    if MONEY.include?(money)
      puts "#{money}円入れました"
      @@vending.slot_money_push(money)
    else
      puts "使用できません"
      return slot_money
    end
  end

  def buy #m02
    puts @user_menu[:m02]
    puts "所持金#{@@vending.slot_money}"
    return puts "商品がありません" if @@vending.stock.length.zero?
    drink_menu_select
    return puts "キャンセルしました" if @drink.zero?
      if @@vending.stock[@drink-1][2] == 0 || @@vending.stock[@drink-1][1] > @@vending.slot_money
        puts "購入できません"
        return buy
      end
    @@vending.buy_push(@drink)
    puts "#{@@vending.stock[@drink-1][0]}を買いました"
  end

  def return_money #m03
    puts "おつりです#{@@vending.slot_money}円"
    @@vending.return_push
    puts "さようなら、また会いましょう"
  end

  def add_drink #m11
    puts @admin_menu[:m11]
    drink_menu_select
    return puts "キャンセルしました" if @drink.zero?
    puts "本数入力"
    stock = get_int
    @@vending.add_push(@drink,stock)
    puts "在庫を追加しました。#{@@vending.stock[@drink-1][0]}の在庫数：#{@@vending.stock[@drink-1][2]}本"
  end

  def new_drink #m12
    puts @admin_menu[:m12]
    puts "商品名を追加してください"
    name = get_name
    puts "値段を入力してください"
    price = get_int
    puts "個数を入力してください"
    stock = get_int
    @@vending.new_push(name,price,stock)
    puts "『#{name}』を『#{price}円』で『#{stock}本』追加しました。"
  end

  def remove_drink #m13
    puts @admin_menu[:m13]
    return puts "商品がありません" if @@vending.stock.length.zero?
    drink_menu_select
    @drink = @int
    return puts "キャンセルしました" if @drink.zero?
    drink_name = @@vending.stock[@drink-1][0]
    @@vending.remove_push(@drink)
    puts "#{drink_name}を撤去しました"
  end

  def drink_menu #m14
    puts @admin_menu[:m14]
    stock_status
  end

  def sales #m15
    puts @admin_menu[:m15]
    puts "残金：#{@@vending.slot_money}円"
    puts "売上：#{@@vending.sales_money}円"
  end
end
