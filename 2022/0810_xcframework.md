## Carthageでビルドに失敗していた件 Xcode Swift

参考: https://techlife.cookpad.com/entry/2021/03/10/110000

### 前提

Carthageを使用すると、Xcodeのツールチェイン(lipoコマンド)経由で
複数のCPUアーキテクチャ向けのバイナリ（ファットバイナリ / ユニバーサルバイナリ）を
XXXX.frameworkという形で引っ張ってこれる。

実際に作成してみた

環境: Xcode11.3

![スクリーンショット 2022-08-10 12 15 07](https://user-images.githubusercontent.com/16571394/183803390-09c280d6-a1a5-4ceb-b1cc-3f77e52fd0de.png)

```
$ file Carthage/Build/iOS/SVProgressHUD.framework/SVProgressHUD
Carthage/Build/iOS/SVProgressHUD.framework/SVProgressHUD: Mach-O universal binary with 4 architectures: [i386:Mach-O dynamically linked shared library i386] [x86_64:Mach-O 64-bit dynamically linked shared library x86_64] [arm_v7:Mach-O dynamically linked shared library arm_v7] [arm64:Mach-O 64-bit dynamically linked shared library arm64]
Carthage/Build/iOS/SVProgressHUD.framework/SVProgressHUD (for architecture i386):	Mach-O dynamically linked shared library i386
Carthage/Build/iOS/SVProgressHUD.framework/SVProgressHUD (for architecture x86_64):	Mach-O 64-bit dynamically linked shared library x86_64
Carthage/Build/iOS/SVProgressHUD.framework/SVProgressHUD (for architecture armv7):	Mach-O dynamically linked shared library arm_v7
Carthage/Build/iOS/SVProgressHUD.framework/SVProgressHUD (for architecture arm64):	Mach-O 64-bit dynamically linked shared library arm64
```

### Xcode12以前

※関係ありそうなところだけ

|デバイス|cpuアーキテクチャ|
|---|---|
|iOS実機|arm64|
|iOSシミュレータ|x86_64|

上記のアーキテクチャに対して、ファットバイナリ(ユニバーサルバイナリ)を生成

### Xcode12から

iOSシミュレータ用のバイナリに、x86_64(intel cpu)に加えて、arm64が対応アーキテクチャとして加わる。
m1が使用しているcpuのアーキテクチャがarm64のため、m1で実行バイナリ生成するときにarm64向けのバイナリが必要なので。

※関係ありそうなところだけ

|デバイス|cpuアーキテクチャ|
|---|---|
|iOS実機|arm64|
|iOSシミュレータ|x86_64, <b>arm64</b>|

### 問題

- iOS実機のcpuアーキテクチャと、iOSシミュレータのcpuアーキテクチャが同一
- Xcodeツールチェインの制約により、上記のパターンでファットバイナリ化できない

### Xcframeworkでの解決

- Xcode11から、Xcframeworkというバンドルが出た
- "Apple platform × シミュレータor実機"の組み合わせのバイナリを吐き出すバンドル(=ある一定のルールに沿ったディレクトリ)
- Carthageを使用して、Lottieをxcframeworkバンドルで落としてきて内容確認 ↓

<img width="1000" alt="スクリーンショット 2022-08-10 9 24 28" src="https://user-images.githubusercontent.com/16571394/183784083-501e1a21-2a8c-469b-951c-d2022dfa3c9e.png">

- おそらく問題が発生していた時のCarthageでは、xxx.frameworkバンドルないで、上の画像で言うところの「ios_arm64, ios-arm64_x86_64-simulator」 を一つのバイナリにしようとしていたんだろう。
- 問題が起こる前（Xcode12より前）は、シミュレータ向けにarm64を含めなくてよかったので、上記をファットバイナリ化できた。

#### 実機iPhone(arm64)

<img width="758" alt="スクリーンショット 2022-08-10 9 23 30" src="https://user-images.githubusercontent.com/16571394/183784033-99ff4057-2f18-4f9a-83c3-67d4b3e9bcc5.png">

#### シミュレータiPhone(x86_64, arm64)

<img width="765" alt="スクリーンショット 2022-08-10 9 23 40" src="https://user-images.githubusercontent.com/16571394/183784038-35a2906f-07f1-401c-8e4a-1ae92c9fffde.png">

- xcframeworkを使用すると、実機とシミュレータ別でバイナリが生成されつつ、シミュレータバイナリはユニバーサルバイナリになっている。

```
[takeshikomori@MacBook-Pro-2:~/me/takeshi-1000/testCarthage]
$ file Carthage/Build/Lottie.xcframework/ios-arm64/Lottie.framework/Lottie 
Carthage/Build/Lottie.xcframework/ios-arm64/Lottie.framework/Lottie: Mach-O 64-bit dynamically linked shared library arm64

[takeshikomori@MacBook-Pro-2:~/me/takeshi-1000/testCarthage]
$ file Carthage/Build/Lottie.xcframework/ios-arm64_x86_64-simulator/Lottie.framework/Lottie 
Carthage/Build/Lottie.xcframework/ios-arm64_x86_64-simulator/Lottie.framework/Lottie: Mach-O universal binary with 2 architectures: [x86_64:Mach-O 64-bit dynamically linked shared library x86_64] [arm64]
Carthage/Build/Lottie.xcframework/ios-arm64_x86_64-simulator/Lottie.framework/Lottie (for architecture x86_64):	Mach-O 64-bit dynamically linked shared library x86_64
Carthage/Build/Lottie.xcframework/ios-arm64_x86_64-simulator/Lottie.framework/Lottie (for architecture arm64):	Mach-O 64-bit dynamically linked shared library arm64
```

[wip]
##　まとめ

