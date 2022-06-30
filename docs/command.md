※環境m1

- otool -f /bin/ls ファットバイナリの詳細を見る

```
Fat headers
fat_magic 0xcafebabe
nfat_arch 2
architecture 0
    cputype 16777223
    cpusubtype 3
    capabilities 0x0
    offset 16384
    size 72800
    align 2^14 (16384)
architecture 1
    cputype 16777228
    cpusubtype 2
    capabilities 0x80
    offset 98304
    size 88736
    align 2^14 (16384)
```

- hexdump -n 40 /bin/ls ファイルの中身を16進数表示。 -n　でバイト数指定

```
$ hexdump -n 20 /bin/ls
0000000 ca fe ba be 00 00 00 02 01 00 00 07 00 00 00 03
0000010 00 00 40 00                                    
0000014
```

- lipo -archs /Applications/Xcode.app/Contents/MacOS/Xcode 実行バイナリに対応するcpuアーキテクチャの出力

```
$ lipo -archs /Applications/Xcode.app/Contents/MacOS/Xcode  
x86_64 arm64

[takeshikomori@MacBook-Pro-2:~/me/private]
$ lipo -archs /bin/ls
x86_64 arm64e
```
