## import Module 周りのメモ

- ソースコードをコンパイルする時点では、headerさえあればよさそう
- ソースコードをリンクする時点では、実態があれば良さそう

<img width="700" alt="スクリーンショット 2022-11-10 9 56 01" src="https://user-images.githubusercontent.com/16571394/200974184-ae46265d-141d-4d9a-a7de-43e874754799.png">

添付のような依存が発生しており、main.swiftがメイン関数を呼ぶ方のファイルだとした場合、
swiftcコンパイラドライバにmain.swift / hoge.swift両方渡せば特にモジュールかする必要ないが、
それぞれでコンパイルする必要がある場合、main.swift側はhoge.swiftのヘッダーを持つ必要があり、
その仕組みとして、依存側のコードをモジュールとして生成し、モジュールを参照するように、メイン側で明示する必要がありそう。

<img width="335" alt="スクリーンショット 2022-11-10 9 58 43" src="https://user-images.githubusercontent.com/16571394/200974448-bfab1cb8-3f0d-4245-950f-ff2ca1425de0.png">

モジュールはC言語ファミリのヘッダと似ている。

