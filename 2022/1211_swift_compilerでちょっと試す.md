apple/swiftをcloneし、依存ライブラリのセットアップなど済ませ、swiftコンパイラをローカルでビルド

```
$ utils/build-script --skip-build-benchmarks \
  --skip-ios --skip-watchos --skip-tvos --swift-darwin-supported-archs "$(uname -m)" \
  --sccache --release-debuginfo --swift-disable-dead-stripping --bootstrapping=off
```

その後、システムで標準で搭載されているswiftコンパイラドライバで、main.swiftをビルド、mainという名前の実行バイナリが生成されたのを確認した後
上記のローカルでビルドしてできた成果物を使用して、実行バイナリ作ろうとしたがエラーが発生する

```
$ /Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/bin/swiftc main.swift -v   
Swift version 5.8-dev (LLVM 3e962dd4df3a4b4, Swift 0b05a1ed2d652e1)
Target: arm64-apple-macosx12.0
/Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/bin/swift-frontend -frontend -c -primary-file main.swift -target arm64-apple-macosx12.0 -Xllvm -aarch64-use-tbi -enable-objc-interop -color-diagnostics -new-driver-path /Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/bin/swift-driver -empty-abi-descriptor -resource-dir /Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/lib/swift -module-name main -o /var/folders/4c/0qwhzzgx3q1_455_mgl56x080000gp/T/TemporaryDirectory.cQQcWf/main-1.o
/Applications/Xcode14.0.1.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang /var/folders/4c/0qwhzzgx3q1_455_mgl56x080000gp/T/TemporaryDirectory.cQQcWf/main-1.o -lSystem --target=arm64-apple-macosx12.0 -force_load /Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/lib/swift/macosx/libswiftCompatibility56.a -L /Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/lib/swift/macosx -o main
error: link command failed with exit code 1 (use -v to see invocation)
ld: library not found for -lSystem
clang: error: linker command failed with exit code 1 (use -v to see invocation)
```

コンパイルはできた

```
$ /Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/bin/swiftc main.swift -c -v
Swift version 5.8-dev (LLVM 3e962dd4df3a4b4, Swift 0b05a1ed2d652e1)
Target: arm64-apple-macosx12.0
/Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/bin/swift-frontend -frontend -c -primary-file main.swift -target arm64-apple-macosx12.0 -Xllvm -aarch64-use-tbi -enable-objc-interop -color-diagnostics -new-driver-path /Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/bin/swift-driver -empty-abi-descriptor -resource-dir /Users/takeshikomori/me/takeshi-1000/swift-project/build/Ninja-RelWithDebInfoAssert/swift-macosx-arm64/lib/swift -module-name main -o main.o
```
