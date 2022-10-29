## frameworkの場所はどこか

アプリを作成して、実行バイナリにリンクされているライブラリを確認してみる

```
$ otool -L ~/Library/Developer/Xcode/DerivedData/testNavi-ewiibuofioktglftgafsywfetynw/Build/Products/Debug-iphonesimulator/testNavi.app/testNavi 
/Users/takeshikomori/Library/Developer/Xcode/DerivedData/testNavi-ewiibuofioktglftgafsywfetynw/Build/Products/Debug-iphonesimulator/testNavi.app/testNavi:
	/System/Library/Frameworks/Foundation.framework/Foundation (compatibility version 300.0.0, current version 1946.102.0)
	/usr/lib/libobjc.A.dylib (compatibility version 1.0.0, current version 228.0.0)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1319.0.0)
	/System/Library/Frameworks/UIKit.framework/UIKit (compatibility version 1.0.0, current version 6092.1.111)
	/usr/lib/swift/libswiftCore.dylib (compatibility version 1.0.0, current version 5.7.0)
	/usr/lib/swift/libswiftCoreFoundation.dylib (compatibility version 1.0.0, current version 120.100.0, weak)
	/usr/lib/swift/libswiftCoreGraphics.dylib (compatibility version 1.0.0, current version 15.0.0, weak)
	/usr/lib/swift/libswiftCoreImage.dylib (compatibility version 1.0.0, current version 2.0.0, weak)
	/usr/lib/swift/libswiftDarwin.dylib (compatibility version 1.0.0, current version 0.0.0, weak)
	/usr/lib/swift/libswiftDataDetection.dylib (compatibility version 1.0.0, current version 723.0.0, weak)
	/usr/lib/swift/libswiftDispatch.dylib (compatibility version 1.0.0, current version 17.0.0, weak)
	/usr/lib/swift/libswiftFileProvider.dylib (compatibility version 1.0.0, current version 730.0.125, weak)
	/usr/lib/swift/libswiftMetal.dylib (compatibility version 1.0.0, current version 306.1.19, weak)
	/usr/lib/swift/libswiftObjectiveC.dylib (compatibility version 1.0.0, current version 6.0.0)
	/usr/lib/swift/libswiftQuartzCore.dylib (compatibility version 1.0.0, current version 3.0.0, weak)
	/usr/lib/swift/libswiftUIKit.dylib (compatibility version 1.0.0, current version 6092.1.111)
	/usr/lib/swift/libswiftFoundation.dylib (compatibility version 1.0.0, current version 1.0.0)
```

`/System/Library/Frameworks/UIKit.framework/UIKit (compatibility version 1.0.0, current version 6092.1.111)` はどこにあるんだろうか

Xcode14.0.1の環境で下記

Xcode14.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profile/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/UIKit.framework/UIKit

`Xcode14.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profile/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot` 

上記が省略されている?

参考: https://stackoverflow.com/questions/24544916/cannot-find-uikit-framework


下記も時間がるとき見てみる

https://qiita.com/usagimaru/items/82cf2a1fb8399c5a1be1

