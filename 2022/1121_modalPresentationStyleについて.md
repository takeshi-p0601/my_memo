## modalPresentationStyleについて

https://developer.apple.com/documentation/uikit/uimodalpresentationstyle

### 背景

uimodalpresentationstyle.fullScreen と uimodalpresentationstyle.overCurrentContext の違いを理解していなかったことにより
SwiftUIとUIKit混合のプロジェクトで、予期せぬ不具合を出した。理解をメモするためにここで書いておく

==

あるA画面から、ある画面Bを全画面モーダルで表示したい場合、下記のような形にすることがある

```
let hoge3 = HogeViewController3()
hoge3.modalPresentationStyle = .fullScreen // or .overFullScreenModal
present(hoge3, animated: true)
```

上記の、fullScreenとoverFullScreenどういう違いがあるのか

下記の実験では、HogeViewController2 → HogeViewController3へモーダル遷移した後のViewDebuggingの画面キャプチャを載せておく

- overFullScreenの場合、下記の添付のように遷移元画面(HogeViewController2)にあたる画面がViewの階層に残ったまま

<img width="1060" alt="スクリーンショット 2022-11-21 14 38 22" src="https://user-images.githubusercontent.com/16571394/202974993-f0c6bd3a-ce8e-42cc-a58d-355f6cb74f76.png">


- fullScreenの場合、下記の添付のように遷移元画面(HogeViewController2)にあたる画面がViewの階層から消えてしまう

<img width="931" alt="スクリーンショット 2022-11-21 14 40 15" src="https://user-images.githubusercontent.com/16571394/202974912-1c69a55f-1794-4fcd-b7b1-5bbe0c5fcac6.png">

`present(hoge3, animated: true)` したタイミング（presentが完了する前）で、viewDidDissapearが走る感じだった。

==

SwiftUIでは、上記の影響を受けることがある。

大事なことは、下記

- onAppear: Viewの階層にViewが追加された時、通知されてしまう
- onDisAppear: Viewの階層にViewが追加された時、通知されてしまう

```
struct TestView: View {
  var body: some View {
     VStack {
     
     }
     .onAppear {
       // Viewの階層に本Viewが追加された時、通知されてしまう
       // TestViewが.fullScreenである画面Bを表示するための親画面であった場合、ある画面Bを閉じるAPI(dismiss)をコールした時、Viewの階層に追加されて、onAppearが通知される
     }
     .onDisAppear {
       // Viewの階層から消えた時、通知されてしまう
       // TestViewが.fullScreenである画面Bを表示するための親画面であった場合、ある画面Bを表示するAPI(present)をコールした時、Viewの階層から削除されて、onDisAppearが通知される
     }
  }
}
```

> When presenting a view controller using the UIModalPresentationFullScreen style, UIKit normally removes the views of the underlying view controller after the transition animations finish. You can prevent the removal of those views by specifying the UIModalPresentationOverFullScreen style instead. You might use that style when the presented view controller has transparent areas that let underlying content show through.

> UIModalPresentationFullScreen スタイルを使用してビューコントローラを表示する場合、UIKit は通常、遷移アニメーションが終了した後に、基盤となるビューコントローラのビューを削除します。代わりに UIModalPresentationOverFullScreen スタイルを指定すると、これらのビューが削除されるのを防ぐことができます。このスタイルは、表示されるビューコントローラに透明な領域があり、その下にあるコンテンツが透けて見える場合に使用されるかもしれません。

参考: https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/PresentingaViewController.html#:~:text=NOTE-,When%20presenting%20a%20view%20controller%20using%20the%20UIModalPresentationFullScreen%20style%2C%20UIKit%20normally,view%20controller%20has%20transparent%20areas%20that%20let%20underlying%20content%20show%20through.,-When%20using%20one

