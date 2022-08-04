# 参考: Rubyで作るRuby3章あたり

# 帰りがけ順
def postorder(tree)
    if tree[0].start_with?("節")
        postorder(tree[1])
        postorder(tree[2])
    end

    p(tree[0])
end

# 行きがけ順
def preorder(tree)
    p(tree[0])

    if tree[0].start_with?("節")
        preorder(tree[1])
        preorder(tree[2])
    end
end

practice_node = ["節 1", ["節 2", ["葉 A"], ["葉 B"]], ["節 3", ["葉 C"], ["葉 D"]]]

preorder(practice_node)

# "節 1"
# "節 2"
# "葉 A"
# "葉 B"
# "節 3"
# "葉 C"
# "葉 D"

postorder(practice_node)

# "葉 A"
# "葉 B"
# "節 2"
# "葉 C"
# "葉 D"
# "節 3"
# "節 1"
