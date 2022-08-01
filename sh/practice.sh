#!/bin/sh

test()
{
 actual="a"
 # どっちでも良い
 echo $actual
 echo ${actual}

 # 渡された引数を${先頭から何番目}で取り出せる
 hikisuu1=$1
 # どっちでも良い
 echo $hikisuu1
 echo ${hikisuu1}

 # バイナリ実行
 ./a.out
 # 実行したバイナリの最後の出力を渡す
 hoge="$?"
 echo $hoge
}

# test関数を10を渡して実行する
test 10
