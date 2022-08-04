require "./minruby"

def sum(tree)
    if tree[0] == "lit"
        tree[1]
    elsif tree[0] == "+"
        left = sum(tree[1])
        right = sum(tree[2])
        left + right
    elsif tree[0] == "*"
        left = sum(tree[1])
        right = sum(tree[2])
        left * right
    else
        left = sum(tree[1])
        right = sum(tree[2])
        left / right
    end
end

tree = minruby_parse("(1 + 2 * 4 + 3 + 4 * 5)/4")
p(tree)

answer = sum(tree)
p(answer)
