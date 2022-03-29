## RxSwift, SPM 

https://github.com/ReactiveX/RxSwift

SwiftPackageManager経由でrxswift組み込む際に、添付のものを選択した状態でないとビルドできなかった

<img width="907" alt="スクリーンショット 2022-03-27 15 06 11" src="https://user-images.githubusercontent.com/16571394/160268995-e7b7c3b5-8cf9-4dac-94cc-ee2a1067f5a3.png">

## bundle id, info.plist

```
The bundle identifier of the application could not be determined. Ensure that the application's Info.plist contains a value for CFBundleIdentifier.
```

info.plist の設定がおかしかったのを直したら正しく動いた

<img width="1017" alt="スクリーンショット 2022-03-28 17 19 20" src="https://user-images.githubusercontent.com/16571394/160356316-ea4fbad8-e386-4edf-86a7-77e0127a91d4.png">

## Simulator, Push通知

- 通知を許可しておく（この辺のコード、証明書が設定できている前提）
- 下記のようなtest.apns ファイルをsimualtorにドラックアンドドロップする

```
{
    "Simulator Target Bundle": "jp.co.xxxxxx", // 通知したいアプリのbundle id
    "aps":{
        "alert":"Test",
        "sound":"default",
        "badge":0,
        "content-available": 0,
    },
    "payload": "" // 任意
}
```
