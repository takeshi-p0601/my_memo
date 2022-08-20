(1) gcc ./src/word.c -o libhello.dylib -dynamiclib -I ./include

- dynamiclibオプションで動的ライブラリ（共有ライブラリ）を作成（他にも方法あるっぽい？）

(2) cd ../useLibrary

(3) gcc main.c -o HelloWorld -I ../makeLibrary/include -L ../makeLibrary -lhello

- -I　オプションでmain.cがインクルードするファイルのpathを指定
- -L でライブラリのパスを指定
- -l で実際の読み込むライブラリを登録

(4) ./HelloWorld すると下記のようなエラーが出る。

```
$ ./HelloWorld 
dyld[27946]: Library not loaded: libhello.dylib
  Referenced from: /Users/takeshikomori/me/takeshi-1000/makeLib/dynamicLibrary/useLibrary/HelloWorld
  Reason: tried: 'libhello.dylib' (no such file), '/usr/local/lib/libhello.dylib' (no such file), '/usr/lib/libhello.dylib' (no such file), '/Users/takeshikomori/me/takeshi-1000/makeLib/dynamicLibrary/useLibrary/libhello.dylib' (no such file), '/usr/local/lib/libhello.dylib' (no such file), '/usr/lib/libhello.dylib' (no such file)
zsh: abort      ./HelloWorld

※ライブラリのpathを確認する

$ otool -L HelloWorld 
HelloWorld:
	libhello.dylib (compatibility version 0.0.0, current version 0.0.0)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1311.100.3)
```

(5) env DYLD_LIBRARY_PATH=/Users/takeshikomori/me/takeshi-1000/makeLib/dynamicLibrary/makeLibrary ./HelloWorld

- dyldのライブラリパスを指定

参考: https://techbookfest.org/product/5108106740629504 P27あたり

この辺りも参考になりそう https://qiita.com/tasuwo/items/be8188c3645801a00252
