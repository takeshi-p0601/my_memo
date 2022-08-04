require "./minruby"

# 項の中で一番大きいもの
def max(tree)
    if tree[0] == "lit"
        tree[1]
    else
        left = max(tree[1])
        right = max(tree[2])
        left > right ? left : right
    end
end

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
    when "**"
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left ** right
    when "<"
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left < right
    when ">"
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left > right
    when "=="
        left = evaluate(tree[1])
        right = evaluate(tree[2])
        left == right
    end
end

# ユーザー入力
str = gets

# 構文木に相当するもの作成
tree = minruby_parse(str)
p(tree)

# 構文木を解析し、結果を出力
answer = evaluate(tree)
answer2 = max(tree)

p(answer)
p(answer2)
