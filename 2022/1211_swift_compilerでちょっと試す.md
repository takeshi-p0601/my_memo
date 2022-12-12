apple/swiftをcloneし、依存ライブラリのセットアップなど済ませ、swiftコンパイラをローカルでビルド

```
$ utils/build-script --skip-build-benchmarks \
  --skip-ios --skip-watchos --skip-tvos --swift-darwin-supported-archs "$(uname -m)" \
  --sccache --release-debuginfo --swift-disable-dead-stripping --bootstrapping=off
```

その後、システムで標準で搭載されているswiftコンパイラドライバで、main.swiftをビルド、mainという名前の実行バイナリが生成されたのを確認した後
上記のローカルでビルドしてできた成果物(コンパイラのバイナリ)でも、実行バイナリを作ろうとしたが、リンク時にエラーが発生する

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

※最初のビルドは1時間以上はかかったが、二回目のビルドは分程度で終わった。

初回 https://github.com/takeshi-1000/my_memo/blob/main/log/swift_compiler_20221211.log#L1402
```
--- Build Script Analyzer ---
Build Script Log: /Users/takeshikomori/me/takeshi-1000/swift-project/build/.build_script_log
Build Percentage 	 Build Duration (sec) 	 Build Phase
================ 	 ==================== 	 ===========
64.9%             	 3559.03               	 Building llvm
30.7%             	 1682.08               	 macosx-arm64-swift-build
2.4%              	 131.65                	 Building earlyswiftdriver
1.9%              	 104.68                	 Building earlyswiftsyntax
0.1%              	 7.21                  	 Building cmark
0.0%              	 0.15                  	 macosx-arm64-swift-test
0.0%              	 0.11                  	 macosx-arm64-swift-install
0.0%              	 0.07                  	 merged-hosts-lipo-core
0.0%              	 0.07                  	 macosx-arm64-extractsymbols
0.0%              	 0.07                  	 macosx-arm64-package
0.0%              	 0.07                  	 merged-hosts-lipo
Total Duration: 5485.19 seconds (1h 31m 25s)
```

2回目
```
--- Build Script Analyzer ---
Build Script Log: /Users/takeshikomori/me/takeshi-1000/swift-project/build/.build_script_log
Build Percentage 	 Build Duration (sec) 	 Build Phase
================ 	 ==================== 	 ===========
92.1%             	 235.77                	 macosx-arm64-swift-build
6.2%              	 15.8                  	 Building earlyswiftsyntax
0.9%              	 2.21                  	 Building earlyswiftdriver
0.6%              	 1.51                  	 Building llvm
0.1%              	 0.28                  	 Building cmark
0.0%              	 0.12                  	 macosx-arm64-swift-test
0.0%              	 0.11                  	 macosx-arm64-swift-install
0.0%              	 0.07                  	 merged-hosts-lipo-core
0.0%              	 0.07                  	 macosx-arm64-extractsymbols
0.0%              	 0.07                  	 macosx-arm64-package
0.0%              	 0.07                  	 merged-hosts-lipo
Total Duration: 256.08 seconds (4m 16s)
```


参考: https://github.com/apple/swift/blob/main/docs/HowToGuides/GettingStarted.md#cloning-the-project
