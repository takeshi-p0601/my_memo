p(100)

i = 1

if i == 1
    p('iは1です')
else
    p('iは1でない')
end

while i < 5
    p(i)
    i = i + 1
end

str = "aaaaa"

case str
when "a"
    p("aは1回")
when "aa"
    p("aは2回")
when "aaa"
    p("aは3回")
when "aaaa"
    p("aは4回")
when "aaaaa"
    p("aは5回")
when "aaaaaa"
    p("aは6回")
when "aaaaaaa"
    p("aは7回")
end

# フィボナッチ数列のx番目を出力
def fib(x)
    if x <= 1
        x
    else 
        fib(x - 1) + fib(x - 2)
    end
end

i = 0 
while i < 20
    p(fib(i))
    i = i + 1
end
