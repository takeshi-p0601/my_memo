(1)gcc ./src/word.c -c -o word.o -I ./include

- ./src/word.c を -c オプションを使用してコンパイル/アセンブルする。
- -o オプションで出力するファイル名を指定
- ./src/word.c がインクルードする word.hのディレクトリを指定するために、-I オプションでword.hが入っているディレクトリを渡す。

(2) ar rcs libhello.a word.o 

- word.o というオブジェクトファイルを使用してlibhello.a という静的ライブラリを作成する（本来複数オブジェクトファイルが渡される想定）
- rcsはlibrary archives を作成するためのarコマンドのオプションである
- r: replace -> ライブラリがすでに存在していて、ライブラリないのファイルが古い場合に更新する
- c: create -> ライブラリが作成されていなければ作成する
- s: sort -> ソートする（インデックスが貼られ、探索するのが早くなるっぽい？）

(3) cd ../useLibrary

(4) gcc main.c -o HelloWorld -I../makeLibrary/include -L../makeLibrary -lhello

- main.c というファイルをコンパイル/リンク(ビルド)する
- -o オプションで出力ファイルを指定
- main.cがインクルードする word.hのディレクトリを指定するために、-I オプションでword.hが入っているディレクトリを渡す。
- リンカが lib library .a ファイルを探せるように -l オプションを使用して -lhello を渡す
- 上記のlibをリンカが探すのに、 -L オプションを使用してlibが入っているライブラリを指定しておく
