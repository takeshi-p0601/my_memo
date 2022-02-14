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

## 多態

ラベルと料金情報をもつような下記の概念があったとする
- 大人料金
- 子供料金

単純にこれらをクラス化すると、下記のようになる

```
class SeneorFee {

func label() -> String {
 "シニア"
}

func fee() -> Int {
 1500
}

}

class ChildFee {

func label() -> String {
 "シニア"
}

func fee() -> Int {
 800
}
}

```

大人料金と子供料金の合計を算出するクラスを作るとき
下記のように、子供と大人で、それぞれ配列の中身を計算する必要がある。。

```

class CalculatorFee {
  var childFeeList: [ChildFee] = []
  var seneorFeeList: [SeneorFee] = []

  func calculate() -> Int {
     for childFeeList in fee {
       // 合計算出
     }
     for seneorFeeList in fee {
     　　　// 合計算出
     }
}


```

上記の処理では子供と大人とで、型の違いがあるため
それぞれで合計の算出をしなくてはいけない

そこで多態という考え方を使って、修正を試みると

```
protocol Fee {
 func label() -> String
 func fee() -> Int
}

class ChildFee: Fee {

}

class SeneorFee: Fee {

}

class CalculatorFee {
  var feeList: [Fee] = []

  func calculate() -> Int {
     for feeList in fee {
     
     }
   }
}

```
この場合だと型の違いで処理を分けなくて良い

## クラス

- クラス設計で重要なことは、クラスを使う側のコードがシンプルになることである。（現場で役立つシステム設計の原則p77）
- 使う側のクラスに業務ロジックを書き始めたら見直す

### メソッドは必ずインスタンス変数を使う

- インスタンス変数を使わないメソッドは、そのクラスである必要がなく、そのデータを持っているクラスにロジックを書けば良い


