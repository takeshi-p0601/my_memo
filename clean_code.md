# 概要

- 安全に変更するための設計や、可読性を高めるための綺麗なコードを書くためのtips等気づいたらメモするために用意
- オブジェクト指向前提
- 経験に基づいている部分がある


## テスタブルにする

- オブジェクト同士の関連性を除却し、それぞれのオブジェクトごとでテストできるようにする
- テストを書くと、将来起こりうる変更に対して、書いてない場合に比べてより安全な変更が望める

## 名前をわかりやすくする

```
// 消費税率
❌ let a: Float = 0.1
🙆‍♀️ let taxRate: Float = 0.1

// ポップアップを表示する
❌ func show() { ... }
🙆‍♀️ func showPopup() { ... }
```

## メソッド着目点

- 何行あるか
- 別メソッドで切り出せないか
- 別クラスで切り出せないか
- メソッド名と処理の内容一致しているか
- 引数多くないか

## スコープ

- スコープは曖昧にしない（privateでいいのに、publicにしたり）

## 意味を複数持たせない

(例)count
```
class HogeViewConroller: UIViewController {

var count: Int = 0

func viewDidLoad() {
  super.viewDidLoad()
  count = 10
}
```
- 読み取り以外に、変更することもできてしまう

```
class HogeViewConroller: UIViewController {

public let count: Int = { updatableCount }
private var _count: Int = 0

func viewDidLoad() {
  super.viewDidLoad()
  _count = 5
}
```

- count自身を変更するには、 _count を使う
- countが読み取り / _countが更新のための変数として役割が分けられる




