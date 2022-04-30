# 小技

## finder

finder 隠しファイル表示非表示

`command + shift + .（コマンド + シフト ＋ ピリオド）`

# git

## ssh 接続テスト

```
ssh -T git@github.com
```

## merge 取り消し

```
git merge --abort
```

## 一時的に過去のcommitに戻す

```
git checkout <コミットid>
```

# xcode

## UIKit

collectionViewのセルを左寄せにする https://github.com/takeshi-1000/my_memo/issues/60#issuecomment-1101255004


## storyboard

### scrollView storyboard 設定

#### 1. viewController に ScrollViewを配置し、上下左右のmarginを全て0にする

<img width="415" alt="スクリーンショット 2022-04-04 19 31 53" src="https://user-images.githubusercontent.com/16571394/161526681-eba939a6-9af6-4761-839d-6f625a04a47c.png">

#### 2. 右のサイドバーから `Content Layout Guides` のチェックを外す

<img width="674" alt="スクリーンショット 2022-04-04 19 32 12" src="https://user-images.githubusercontent.com/16571394/161526687-31a15209-2b39-4a4a-a478-46edc360aa5a.png">

#### 3. 適当にViewをScrollViewの上に置く

<img width="682" alt="スクリーンショット 2022-04-04 19 32 38" src="https://user-images.githubusercontent.com/16571394/161526693-e61a909b-81df-4081-9e23-d78590040792.png">

#### 4. 下以外のmarginを0にし、高さを設定する

<img width="800" alt="スクリーンショット 2022-04-04 19 33 06" src="https://user-images.githubusercontent.com/16571394/161526695-bb7f0655-5aa0-4663-8faa-319532cfbd8c.png">

#### 5. 3で置いたViewのwidthとscrollViewのwidthを1:1となるように、Equal width を設定する

<img width="709" alt="スクリーンショット 2022-04-04 19 33 23" src="https://user-images.githubusercontent.com/16571394/161526700-6d21e13d-daae-4b8c-9f03-3ef0588217bc.png">

#### 5. の続き

<img width="652" alt="スクリーンショット 2022-04-04 19 33 38" src="https://user-images.githubusercontent.com/16571394/161526702-fd9b9233-3943-42d6-b96d-40809c9d915d.png">

#### 6. 4で設定していなかった下のmarginを設定する。この時のmarginはViewの高さまでスクロールした後に、どのくらいそのほかスクロールされたいかを設定する。ViewギリギリまでスクロールすればOKであれば、0で良い

<img width="498" alt="スクリーンショット 2022-04-04 19 33 58" src="https://user-images.githubusercontent.com/16571394/161526705-28c78372-5ec9-462f-ba1d-efd07a1473e0.png">

## rxswift

### withLatestFrom

<img width="855" alt="スクリーンショット 2022-04-26 15 52 20" src="https://user-images.githubusercontent.com/16571394/165239558-60c96869-a240-4807-8b3a-be151c05a888.png">

https://rxmarbles.com/#withLatestFrom

