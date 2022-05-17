## [Makefile] makeコマンド

- あるCのファイルをコンパイルしたい際に、毎回コマンドを入力するのはめんどくさい
- そこでMakefileにあらかじめコンパイルしたいファイルと出力ファイル名、コマンド等書いておき、 Makefileのあるディレクトリで `make` を打つだけで、ビルド成功する

```
hello: hello.c
  gcc hello.c -o hello
```

※コマンドの前はタブスペースを開けることに注意

<img width="500" alt="スクリーンショット 2022-05-17 13 23 42" src="https://user-images.githubusercontent.com/16571394/168728561-8326fbeb-de7d-4785-9ef2-0b22b099840b.png">

参考： https://www.miraclelinux.com/tech-blog/0icygs

### 複数ファイルのビルド（ヘッダファイル）

上記の例に関して、hello.cから、hello.hを読み込むような、複数ファイルをビルドする場合は、下記のようにMakefileを修正する

hello.c
```
#include <stdio.h>
#include "hello.h"

int main(void)
{
    printf("Hello!!!!\n");
    printf("my name is %s\n", HELLO_HELLO);
    return 0;
}
```

hello.h
```
#define HELLO_HELLO "hello_1234"
```

Makefile
```
hello: hello.c hello.h
  gcc hello.c -o hello
```

### 複数ファイルのビルド（ソースファイル）

- 複数のソースファイルをコンパイルし、リンクさせて実行形式を作成する場合、下記のような感じになる
- 一番上のファイルのコマンドと実行形式が最終的に実行したいもので、その下は最終的に実行したいものを構成するものたち
- hello.o は hello.c と hello.h をコンパイルして、hello.o を作成する
- gcc のオプションである -c はリンクは行わず、コンパイルだけ行う

```
hello: hello.o hello2.o
  gcc hello.o hello2.o -o hello

hello.o: hello.c hello.h
  gcc hello.c -c -o hello.o
  
hello2.o: hello2.c hello.h
  gcc hello2.c -c -o hello2.o

```

### マクロで代用する

- 下記のように、実行するコマンド部分のファイル名をマクロに書き換えられる
- ファイルの名前が変わってもいちいち変えなくて良い

```
hello: hello.c
  gcc hello.c -o hello
```

↓

```
hello: hello.c
  gcc $^ -o $@
```

===

```
hello: hello.o hello2.o
        gcc $^ -o $@

hello.o: hello.c hello.h
        gcc hello.c -c -o hello.o

hello2.o: hello2.c hello.h
        gcc $< -c -o $@
```

### 業務で使用しているファイルをちょっと工夫

- make mov or make mp4 で可能
- ffmpegがないとできない

```
mp4:
	ffmpeg -i test.mp4 -an -r 10 %04d.png
	convert *.png -resize 40% output_%04d.png
	convert output_*.png result.gif
	rm -rf *.png test.mp4

mov:
	ffmpeg -i test.mov -an -r 10 %04d.png
	convert *.png -resize 40% output_%04d.png
	convert output_*.png result.gif
	rm -rf *.png test.mov
```
