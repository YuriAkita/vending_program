
require './function.rb'
require './interface.rb'
require './vending.rb'

class User < Interface
  include Function
  def index
    puts "何か用ですか？(数字を入力してください)"
    puts @user_menu.values
    puts "【投入金額：#{@@vending.slot_money}円】"
    check_int
    number = @int
    case number.to_i
    when 1 then
      slot_money
    when 2 then
      buy
    when 0 then
      return_money
      return puts "さようなら"
    else
      puts "その番号はありません"
      return index
    end
    enter
    index
  end
end

class Admin < Interface
  include Function
  def admin_index
    puts '管理者メニュー(*)'
    puts @admin_menu.values
    check_int
    number = @int
    case number
    when 1 then
      add_drink
    when 2 then
      new_drink
    when 3 then
      remove_drink
    when 4 then
      drink_menu
    when 5 then
      sales
    when 0 then
      return puts "さようなら"
    else
      puts "その番号はありません"
      return admin_index
    end
    enter
    admin_index
  end
end
