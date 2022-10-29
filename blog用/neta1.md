## 話すこと

- 実行バイナリが生成されるプロセスや、そこで生成されるものを少し深掘りする

## 背景

1年前まで、iOSアプリ開発において、バイナリレベルまで気にしたことや、どういうふうにアプリが実行されるかまで気にしたことはなく
単純にXcode上で、Swiftファイルを編集して、storyboardでデザイン整えて、Runボタンを押してアプリ起動して、処理的に良さそう、はいOK的なことしか分かってなかった。
例えば、arm64, x86_64とかを気にすることもなかったし、Compilerというものがどのあたりの、何のことを指しているのかわからなかった。

https://www.amazon.co.jp/%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%81%AE%E7%90%86%E8%AB%96%E3%81%A8%E5%AE%9F%E8%A3%85-%E2%80%95%E3%83%A2%E3%83%80%E3%83%B3%E3%81%AA%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF%E3%81%AE%E4%BD%9C%E3%82%8A%E6%96%B9-Noam-Nisan/dp/4873117127 

上記の本に出会い、そこから派生して色々本や記事を読んでいくにあたって、普段見えている部分とはまた違ったレイヤのを知ることになり、
その副産物として、上記のarm64やコンパイラとかの話がなんとなくわかるようになった。
この前のbitcodeの話でもそうだが、上記の知識をベースとして、理屈付きで判断できる事態が増えたので、そういった知識があると役に立つこともあるかなと考え
この記事を書いてみる。

### 参考書籍

基本的には完全読破した本は一冊もないが、かいつまんで読んだ本が多数あるので、その辺りを紹介してみる

- https://www.amazon.co.jp/%E3%81%AF%E3%81%98%E3%82%81%E3%81%A6%E8%AA%AD%E3%82%808086%E2%80%9516%E3%83%93%E3%83%83%E3%83%88%E3%83%BB%E3%82%B3%E3%83%B3%E3%83%94%E3%83%A5%E3%83%BC%E3%82%BF%E3%82%92%E3%82%84%E3%81%95%E3%81%97%E3%81%8F%E8%AA%9E%E3%82%8B-%E3%82%A2%E3%82%B9%E3%82%AD%E3%83%BC%E3%83%96%E3%83%83%E3%82%AF%E3%82%B9-%E8%92%B2%E5%9C%B0-%E8%BC%9D%E5%B0%9A/dp/4871482456

- https://www.amazon.co.jp/%EF%BC%BB%E8%A9%A6%E3%81%97%E3%81%A6%E7%90%86%E8%A7%A3%EF%BC%BDLinux%E3%81%AE%E3%81%97%E3%81%8F%E3%81%BF-%EF%BD%9E%E5%AE%9F%E9%A8%93%E3%81%A8%E5%9B%B3%E8%A7%A3%E3%81%A7%E5%AD%A6%E3%81%B6OS%E3%81%A8%E3%83%8F%E3%83%BC%E3%83%89%E3%82%A6%E3%82%A7%E3%82%A2%E3%81%AE%E5%9F%BA%E7%A4%8E%E7%9F%A5%E8%AD%98-%E6%AD%A6%E5%86%85-%E8%A6%9A-ebook/dp/B079YJS1J1/ref=sr_1_4?keywords=linux%E3%81%AE%E3%81%97%E3%81%8F%E3%81%BF&qid=1667010269&qu=eyJxc2MiOiIyLjg5IiwicXNhIjoiMi4xOCIsInFzcCI6IjIuMjUifQ%3D%3D&s=books&sprefix=linux%2Cstripbooks%2C252&sr=1-4

- https://www.amazon.co.jp/%E3%83%AA%E3%83%B3%E3%82%AB%E3%83%BB%E3%83%AD%E3%83%BC%E3%83%80%E5%AE%9F%E8%B7%B5%E9%96%8B%E7%99%BA%E3%83%86%E3%82%AF%E3%83%8B%E3%83%83%E3%82%AF%E2%80%95%E5%AE%9F%E8%A1%8C%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81%E3%81%AB%E5%BF%85%E9%A0%88%E3%81%AE%E6%8A%80%E8%A1%93-COMPUTER-TECHNOLOGY-%E5%9D%82%E4%BA%95-%E5%BC%98%E4%BA%AE/dp/4789838072/ref=sr_1_1?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&crid=28MEZTKHG6U8K&keywords=%E3%83%AA%E3%83%B3%E3%82%AB+%E3%83%AD%E3%83%BC%E3%83%80&qid=1667010290&qu=eyJxc2MiOiIwLjAwIiwicXNhIjoiMC4wMCIsInFzcCI6IjAuMDAifQ%3D%3D&s=books&sprefix=%E3%83%AA%E3%83%B3%E3%82%AB+%E3%83%AD%E3%83%BC%E3%83%80%2Cstripbooks%2C378&sr=1-1

- https://www.sigbus.info/compilerbook

## 実行バイナリが生成されるまで

### そもそもバイナリとは何か

```
$ file /bin/ls
/bin/ls: Mach-O universal binary with 2 architectures: [x86_64:Mach-O 64-bit executable x86_64
- Mach-O 64-bit executable x86_64] [arm64e:Mach-O 64-bit executable arm64e
- Mach-O 64-bit executable arm64e]
/bin/ls (for architecture x86_64):	Mach-O 64-bit executable x86_64
/bin/ls (for architecture arm64e):	Mach-O 64-bit executable arm64e
```

上記のようなものです。

### 最終的にCPUが命令を読む

### バイナリの生成過程

CPUが実行するために、開発者側でバイナリの形にしなくてもスクリプト言語のような、スクリプト言語を読み出して実行時にCPUの命令に変換するようなプロセスを踏むものもありますが、
iOS開発においては、実行時にではなくあらかじめ機械語命令が記載されたバイナリというものを作っておいて、そのバイナリを読み込ませる。

ざっくり下記のようなフローです

- プリコンパイル
- コンパイル
- アセンブル
- リンク
- 実行バイナリ出来上がり

iOS開発においては、実行時にではなくあらかじめ機械語命令が記載されたバイナリというものを作っておいて、そのバイナリを読み込ませる

# バイナリがロードされること

```
$ otool -l /bin/ls

$ otool -l /bin/ls
/bin/ls:
Load command 0
      cmd LC_SEGMENT_64
  cmdsize 72
  segname __PAGEZERO
   vmaddr 0x0000000000000000
   vmsize 0x0000000100000000
  fileoff 0
 filesize 0
  maxprot 0x00000000
 initprot 0x00000000
   nsects 0
    flags 0x0
Load command 1
      cmd LC_SEGMENT_64
  cmdsize 472
  segname __TEXT
   vmaddr 0x0000000100000000
   vmsize 0x0000000000008000
  fileoff 0
 filesize 32768
  maxprot 0x00000005
 initprot 0x00000005
   nsects 5
    flags 0x0
Section
  sectname __text
   segname __TEXT
      addr 0x0000000100003830
      size 0x0000000000003c10
    offset 14384
     align 2^2 (4)
    reloff 0
    nreloc 0
     flags 0x80000400
 reserved1 0
 reserved2 0
Section
  sectname __auth_stubs
   segname __TEXT
      addr 0x0000000100007440
      size 0x0000000000000520
    offset 29760
     align 2^2 (4)
    reloff 0
    nreloc 0
     flags 0x80000408
 reserved1 0 (index into indirect symbol table)
 reserved2 16 (size of stubs)
Section
  sectname __const
   segname __TEXT
      addr 0x0000000100007960
      size 0x00000000000000dc
    offset 31072
     align 2^3 (8)
    reloff 0
    nreloc 0
     flags 0x00000000
 reserved1 0
 reserved2 0
Section
  sectname __cstring
   segname __TEXT
      addr 0x0000000100007a3c
      size 0x00000000000004e9
    offset 31292
     align 2^0 (1)
    reloff 0
    nreloc 0
     flags 0x00000002
 reserved1 0
 reserved2 0
Section
  sectname __unwind_info
   segname __TEXT
      addr 0x0000000100007f28
      size 0x00000000000000d8
    offset 32552
     align 2^2 (4)
    reloff 0
    nreloc 0
     flags 0x00000000
 reserved1 0
 reserved2 0
Load command 2
      cmd LC_SEGMENT_64
  cmdsize 312
  segname __DATA_CONST
   vmaddr 0x0000000100008000
   vmsize 0x0000000000004000
  fileoff 32768
 filesize 16384
  maxprot 0x00000003
 initprot 0x00000003
   nsects 3
    flags 0x10
Section
  sectname __auth_got
   segname __DATA_CONST
      addr 0x0000000100008000
      size 0x0000000000000290
    offset 32768
     align 2^3 (8)
    reloff 0
    nreloc 0
     flags 0x00000006
 reserved1 82 (index into indirect symbol table)
 reserved2 0
Section
  sectname __got
   segname __DATA_CONST
      addr 0x0000000100008290
      size 0x0000000000000030
    offset 33424
     align 2^3 (8)
    reloff 0
    nreloc 0
     flags 0x00000006
 reserved1 164 (index into indirect symbol table)
 reserved2 0
Section
  sectname __const
   segname __DATA_CONST
      addr 0x00000001000082c0
      size 0x0000000000000268
    offset 33472
     align 2^3 (8)
    reloff 0
    nreloc 0
     flags 0x00000000
 reserved1 0
 reserved2 0
Load command 3
      cmd LC_SEGMENT_64
  cmdsize 312
  segname __DATA
   vmaddr 0x000000010000c000
   vmsize 0x0000000000004000
  fileoff 49152
 filesize 16384
  maxprot 0x00000003
 initprot 0x00000003
   nsects 3
    flags 0x0
Section
  sectname __data
   segname __DATA
      addr 0x000000010000c000
      size 0x0000000000000020
    offset 49152
     align 2^3 (8)
    reloff 0
    nreloc 0
     flags 0x00000000
 reserved1 0
 reserved2 0
Section
  sectname __common
   segname __DATA
      addr 0x000000010000c020
      size 0x00000000000000b0
    offset 0
     align 2^3 (8)
    reloff 0
    nreloc 0
     flags 0x00000001
 reserved1 0
 reserved2 0
Section
  sectname __bss
   segname __DATA
      addr 0x000000010000c0d0
      size 0x0000000000000150
    offset 0
     align 2^3 (8)
    reloff 0
    nreloc 0
     flags 0x00000001
 reserved1 0
 reserved2 0
Load command 4
      cmd LC_SEGMENT_64
  cmdsize 72
  segname __LINKEDIT
   vmaddr 0x0000000100010000
   vmsize 0x0000000000008000
  fileoff 65536
 filesize 23200
  maxprot 0x00000001
 initprot 0x00000001
   nsects 0
    flags 0x0
Load command 5
            cmd LC_DYLD_INFO_ONLY
        cmdsize 48
     rebase_off 0
    rebase_size 0
       bind_off 65536
      bind_size 1128
  weak_bind_off 0
 weak_bind_size 0
  lazy_bind_off 0
 lazy_bind_size 0
     export_off 66664
    export_size 32
Load command 6
     cmd LC_SYMTAB
 cmdsize 24
  symoff 66776
   nsyms 90
  stroff 68896
 strsize 984
Load command 7
            cmd LC_DYSYMTAB
        cmdsize 80
      ilocalsym 0
      nlocalsym 1
     iextdefsym 1
     nextdefsym 1
      iundefsym 2
      nundefsym 88
         tocoff 0
           ntoc 0
      modtaboff 0
        nmodtab 0
   extrefsymoff 0
    nextrefsyms 0
 indirectsymoff 68216
  nindirectsyms 170
      extreloff 0
        nextrel 0
      locreloff 0
        nlocrel 0
Load command 8
          cmd LC_LOAD_DYLINKER
      cmdsize 32
         name /usr/lib/dyld (offset 12)
Load command 9
     cmd LC_UUID
 cmdsize 24
    uuid AB297189-4948-396B-9B89-565F705100BD
Load command 10
      cmd LC_BUILD_VERSION
  cmdsize 32
 platform 1
    minos 11.0
      sdk 12.6
   ntools 1
     tool 3
  version 760.0
Load command 11
      cmd LC_SOURCE_VERSION
  cmdsize 16
  version 353.100.22
Load command 12
       cmd LC_MAIN
   cmdsize 24
  entryoff 14992
 stacksize 0
Load command 13
          cmd LC_LOAD_DYLIB
      cmdsize 48
         name /usr/lib/libutil.dylib (offset 24)
   time stamp 2 Thu Jan  1 09:00:02 1970
      current version 1.0.0
compatibility version 1.0.0
Load command 14
          cmd LC_LOAD_DYLIB
      cmdsize 56
         name /usr/lib/libncurses.5.4.dylib (offset 24)
   time stamp 2 Thu Jan  1 09:00:02 1970
      current version 5.4.0
compatibility version 5.4.0
Load command 15
          cmd LC_LOAD_DYLIB
      cmdsize 56
         name /usr/lib/libSystem.B.dylib (offset 24)
   time stamp 2 Thu Jan  1 09:00:02 1970
      current version 1311.120.1
compatibility version 1.0.0
Load command 16
      cmd LC_FUNCTION_STARTS
  cmdsize 16
  dataoff 66696
 datasize 80
Load command 17
      cmd LC_DATA_IN_CODE
  cmdsize 16
  dataoff 66776
 datasize 0
Load command 18
      cmd LC_CODE_SIGNATURE
  cmdsize 16
  dataoff 69888
 datasize 18848

```
