require "./minruby"

def evaluate(tree)
    case tree[0]
    when "lit"
        tree[1]
    when "+"
        evaluate(tree[1]) + evaluate(tree[2])
    when "-"
        evaluate(tree[1]) - evaluate(tree[2])
    when "*"
        evaluate(tree[1]) * evaluate(tree[2])
    when "/"
        evaluate(tree[1]) / evaluate(tree[2])
    when "%"
        evaluate(tree[1]) % evaluate(tree[2])
    when "**"
        evaluate(tree[1]) ** evaluate(tree[2])
    when "<"
        evaluate(tree[1]) < evaluate(tree[2])
    when ">"
        evaluate(tree[1]) > evaluate(tree[2])
    when "=="
        evaluate(tree[1]) == evaluate(tree[2])
    when "func_call" # 仮
        p(evaluate(tree[2]))
    when "stmts"
        i = 1
        last = nil
        while tree[i] != nil
            last = evaluate(tree[i])
            i = i + 1
        end
        last
    end
end

# ファイルから読み込む
str = minruby_load()

# 構文木に相当するもの作成
tree = minruby_parse(str)

# 構文木を解析し、結果を出力
answer = evaluate(tree)
