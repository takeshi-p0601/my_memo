1. main.swiftとして下記のファイルを用意する

```
print("hello")
```

2. 上記のファイルがコンパイルできるか確認する

```
[takeshikomori@MacBook-Pro-2:~/me/takeshi-1000/testSwiftProgram]
$ swiftc main.swift -c

[takeshikomori@MacBook-Pro-2:~/me/takeshi-1000/testSwiftProgram]
$ ls
main.o		main.swift
```

3. main.swiftを下記のように、後ろの括弧をなくするような形で編集する

```
print("hello"
```

4. main.swiftを改めてコンパイルして、コンパイルできるか確認

```
$ swiftc main.swift 
main.swift:2:1: error: expected ')' in expression list

^
main.swift:1:6: note: to match this opening '('
print("hello"
```

5. https://github.com/apple/swift をクローンして、コンパイラのバイナリをセットアップする
　参考 https://github.com/takeshi-1000/my_memo/blob/main/2022/1211_swift_compiler%E3%81%A7%E3%81%A1%E3%82%87%E3%81%A3%E3%81%A8%E8%A9%A6%E3%81%99.md
 
6. ビルドしてできたコンパイラのバイナリを使ってコンパイルしてみる 

```
$  ~/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/bin/swift main.swift -c 
main.swift:2:1: error: expected ')' in expression list

^
main.swift:1:6: note: to match this opening '('
print("hello"
```

7. apple/swiftのソースから `expected ')' in expression list` を調べて、どの辺に実装されていそうか確認。そうすると https://github.com/apple/swift/blob/main/include/swift/AST/DiagnosticsParse.def#L1321 あたりに
あたりがありそうなこと確認。

8. 適当に下記のようにソースコードを修正 

DiagnosticsParse.def
```
ERROR(expected_rparen_expr_list,none,
      "expected ')' in expression list hogehoge!!!!!", ())
```

9. コンパイラのソースを再度ビルド

10. ビルドしたバイナリで、コンパイラを出力してみる

```
$ ~/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/bin/swift main.swift -c
main.swift:2:1: error: expected ')' in expression list hogehoge!!!!!

^
main.swift:1:6: note: to match this opening '('
print("hello"
```


