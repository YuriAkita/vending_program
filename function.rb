module Function
  def waiting
    sleep 0.2
    puts ".."
    sleep 0.2
    puts "..."
    sleep 0.1
  end

  def enter
    puts "Enterを押してください"
    gets
  end
end
