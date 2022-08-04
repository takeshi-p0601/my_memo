require "./minruby"

def evaluate(tree)
    case tree[0]
    when "lit"
        tree[1]
    when "+"
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left + right
    when "-"
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left + right
    when "*"
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left * right
    when "/"
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left / right
    when "%"
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left % right
    else
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left ** right
    end
end

# ユーザー入力
str = gets

# 構文木に相当するもの作成
tree = minruby_parse(str)

# 構文木を解析し、結果を出力
answer = evaluate(tree)

p(answer)
