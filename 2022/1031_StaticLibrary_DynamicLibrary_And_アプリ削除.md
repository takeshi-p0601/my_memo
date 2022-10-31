## バイナリに結合するライブラリの種類

忘れそうなので、参照下そのままコピペだが貼っとく

### Static Library

- 拡張子は .a
- 実行可能ファイル内にライブラリ自体がコピーされ含まれる
- アプリサイズが大きくなる
- Static Library の更新にはアプリの更新が必要

### Dynamic Library

- 拡張子は .dylib
- 実行可能ファイル内にライブラリ自体は含まれない
- 外部ツール (ダイナミックリンカ, macOS の場合は dyld) によって、必要に応じてライブラリがロードされる
- アプリサイズが小さくなる
- アプリ側の更新をしなくとも Dynamic Library の更新が可能

参考: https://qiita.com/tasuwo/items/be8188c3645801a00252#static-library-vs-dynamic-library

## アプリ削除

https://help.apple.com/app-store-connect/#/dev28d17ed35 を見ればよさそう
