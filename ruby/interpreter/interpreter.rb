require "./minruby"

# サンプル組み込み関数
def sample_add(x, y)
    x + y
end

def evaluate(tree, genv, lenv)
    # p(tree)
    case tree[0]
    when "lit"
        tree[1]
    when "+"
        evaluate(tree[1], genv, lenv) + evaluate(tree[2], genv, lenv)
    when "-"
        evaluate(tree[1], genv, lenv) - evaluate(tree[2], genv, lenv)
    when "*"
        evaluate(tree[1], genv, lenv) * evaluate(tree[2], genv, lenv)
    when "/"
        evaluate(tree[1], genv, lenv) / evaluate(tree[2], genv, lenv)
    when "%"
        evaluate(tree[1], genv, lenv) % evaluate(tree[2], genv, lenv)
    when "**"
        evaluate(tree[1], genv, lenv) ** evaluate(tree[2], genv, lenv)
    when "<"
        evaluate(tree[1], genv, lenv) < evaluate(tree[2], genv, lenv)
    when "<="
        evaluate(tree[1], genv, lenv) <= evaluate(tree[2], genv, lenv)
    when ">"
        evaluate(tree[1], genv, lenv) > evaluate(tree[2], genv, lenv)
    when ">="
        evaluate(tree[1], genv, lenv) >= evaluate(tree[2], genv, lenv)
    when "=="
        evaluate(tree[1], genv, lenv) == evaluate(tree[2], genv, lenv)
    when "!="
        evaluate(tree[1], genv, lenv) != evaluate(tree[2], genv, lenv)
    when "func_call"
        args = []
        i = 0
        while tree[2 + i] != nil
            args[i] = evaluate(tree[2 + i], genv, lenv)
            i = i + 1
        end

        method = genv[tree[1]]
        if method[0] == "buildin"
            # 組み込み関数
            minruby_call(method[1], args)
        else
            # プログラム側で自作した関数
            t = 0
            new_lenv = {}
            while method[1][t] != nil
                new_lenv[method[1][t]] = args[t] 
                t = t + 1
            end
            evaluate(method[2], genv, new_lenv)
        end
    when "func_def"
        # tree[1] -> 関数ラベル
        # tree[2] -> 関数の引数
        # tree[3] -> 関数本体
        genv[tree[1]] = ["not_buildin", tree[2], tree[3]]
    when "var_assign"
        lenv[tree[1]] = evaluate(tree[2], genv, lenv)
    when "var_ref"
        lenv[tree[1]]
    when "ary_new"
        array = []
        j = 0
        while tree[1 + j] != nil
            array[j] = evaluate(tree[1 + j], genv, lenv)
            j = j + 1
        end

        array
    when "ary_assign"
        ary = evaluate(tree[1], genv, lenv)
        index = evaluate(tree[2], genv, lenv)
        value = evaluate(tree[3], genv, lenv)
        ary[index] = value
    when "ary_ref" # これはあくまで、添字付きの参照。array本体の参照は、var_refに入る
        ary = evaluate(tree[1], genv, lenv)
        index = evaluate(tree[2], genv, lenv)
        ary[index]
    when "hash_new"
        hash = {}
        k = 0
        while tree[k + 1] != nil
            hash[evaluate(tree[k + 1], genv, lenv)] = evaluate(tree[k + 2], genv, lenv)
            k = k + 2
        end
        hash
    when "if"
        if evaluate(tree[1], genv, lenv)
            evaluate(tree[2], genv, lenv)
        else
            evaluate(tree[3], genv, lenv)
        end
    when "while"
        while evaluate(tree[1], genv, lenv)
            evaluate(tree[2], genv, lenv)
        end
    when "while2" # begin end while
        while evaluate(tree[1], genv, lenv)
            evaluate(tree[2], genv, lenv)
        end
    when "stmts"
        i = 1
        last = nil
        while tree[i] != nil
            last = evaluate(tree[i], genv, lenv)
            i = i + 1
        end
        last
    end
end

# ファイルから読み込む
str = minruby_load()

# 構文木に相当するもの作成
tree = minruby_parse(str)

# 関数の環境変数
genv = {
    "p" => ["buildin", "p"],
    "pp" => ["buildin", "pp"],
    "require" => ["buildin", "require"],
    "minruby_load" => ["buildin", "minruby_load"],
    "minruby_parse" => ["buildin", "minruby_parse"],
    "minruby_call" => ["buildin", "minruby_call"]
}

# 変数の環境変数
lenv = {}

# 構文木を解析し、結果を出力
answer = evaluate(tree, genv, lenv)
