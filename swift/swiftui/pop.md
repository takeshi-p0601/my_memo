## NavigationControllerの戻る処理

### UIKit, SwiftUI混合プロジェクトの注意点

- NavigationViewを使っているときは、navigationViewStyle(.stack) を使う
  - これを使わないと正しくstackにvcが追加されてない
- 上記が難しい場合は、SwiftUIの中でNavigationViewを生成するのではなく、UINavigationController(rootViewController: UIHostingControoler(rootView: SwiftUIView())) にすると良い

### 戻る処理

#### (1) SwiftUI(A)からSwiftUI(B)と遷移した時に、SwiftUI(A)画面に戻る
- 環境変数(presentationMode)を(B)から使用

#### (2) SwiftUI(A) -> SwiftUI(B) -> SwiftUI(C)と遷移した時に、SwiftUI(A)画面に戻る
- AからBinding を C まで送り、CでBindingをfalseにする

#### (3) UIKit(A) -> SwiftUI(B) に遷移し、UIKit(A)画面に戻る
- 環境変数(presentationMode)を(B)から使用

#### (4) UIKit(A) -> SwiftUI(B) -> SwiftUI(C)と遷移した時に、UIKit(A)画面に戻る
- AからコールバックをCまで送り、Cでコールバック実行

#### (5) SwiftUI(A) -> UIKit(B) と遷移した時に、SwiftUI(A)画面に戻る
- UIKitでpop処理
