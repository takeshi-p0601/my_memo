## bitcodeとか、デバックビルドとか、リリースビルドとか

bitcodeをonにした際のビルド時の成果物の図

- デバックビルドでは、バイナリにデバックシンボルが含まれそう
- リリースビルドでは、バイナリに直接でバックシンボルは埋め込まれず、dSYMファイルとして出力され、バイナリとdSYMとで共通のビルドUUIDを持つことで互換性を保っている。
- bitcode を on にしたリリースビルドの場合、dSYMは難読化されてしまう。難読化を解読するのに、bcsymbolmapが使われる。

<img width="620" alt="スクリーンショット 2022-10-22 10 34 25" src="https://user-images.githubusercontent.com/16571394/197310721-466dd2fc-27e9-4da3-8b49-82cd181a8890.png">

<img width="607" alt="スクリーンショット 2022-10-22 10 34 31" src="https://user-images.githubusercontent.com/16571394/197310723-1adba845-77b7-4742-a126-2c140d0b563c.png">

参考： https://akerun.slack.com/archives/C04EQENK5/p1666311693777759?thread_ts=1666165196.659859&cid=C04EQENK5

## bitcodeを完全に削除するために

- ライブラリ側の設定もoffにすることを忘れない

<img width="670" alt="スクリーンショット 2022-10-21 9 03 13" src="https://user-images.githubusercontent.com/16571394/197310897-86540109-521b-40c7-8ae8-9ecb1c8cff0f.png">

## Crashlytics にアップロードすべき dSYMに関して

[wip]
