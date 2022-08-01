answer = 1 + 3
guess = gets.to_i

while answer != guess
 p("ハズレ")
 guess = gets.to_i
end

p("終了")
