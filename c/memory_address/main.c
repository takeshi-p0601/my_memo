#include <stdio.h>
#include "stdlib.h"

static int a = 2;
int b = 3;

void test(void) {
    int i = 10;
    static int i2 = 12;
    
    printf("\n ==== func1 ====\n");
    printf("\n@@@ local 変数\n");
    printf("i      -> %p\n", &i);
    
    printf("\n@@@ local 変数(static)\n");
    printf("i2     -> %p\n", &i2);
}

void test2(void) {
    int i3 = 10;
    
    printf("\n ==== func2 ====\n ");
    printf("\n@@@ local 変数\n");
    printf("i3      -> %p\n", &i3);
}

int main(void)
{
    printf("\n@@@ 文字列リテラル\n");
    printf("abc    -> %p\n", &"abc");
    
    printf("\n@@@ ファイル内定数\n");
    printf("a      -> %p\n", &a);
    
    printf("\n@@@ グローバル変数\n");
    printf("b      -> %p\n", &b);
    
    printf("\n@@@ 関数へのポインタ\n");
    
    /*
     関数へのポインタは書き方として、下記がありそう
     test
     &test
     (void*)test （汎用ポインタへのキャスト）
     
     関数は、呼び出し演算子の()を使うことで、呼び出しが行われる
     */
    printf("func1  -> %p\n", &test);
    printf("func2  -> %p\n", &test2);
    
    test();
    test2();
    
    printf("\n@@@ mallocで確保\n");
    int *p = malloc(sizeof(int));
    printf("malloc -> %p\n", &p);
    
    return 0;
}

/*
 m1で実行
 
 @@@ 文字列リテラル
 abc    -> 0x100003efe

 @@@ ファイル内定数
 a      -> 0x100008008

 @@@ グローバル変数
 b      -> 0x100008000

 @@@ 関数へのポインタ
 func1  -> 0x100003c48
 func2  -> 0x100003cc8

  ==== func1 ====

 @@@ local 変数
 i      -> 0x16fdff27c

 @@@ local 変数(static)
 i2     -> 0x100008004

  ==== func2 ====
  
 @@@ local 変数
 i3      -> 0x16fdff27c

 @@@ mallocで確保
 malloc -> 0x16fdff2a0
 
 アドレスを8byteで表記
 |メモリサイズ|アドレス|
 |1B|0x0000000000000000|
 |1B|0x0000000000000001|
 |1B|0x0000000000000002|
 |1B|0x0000000000000003|
 ...
 |1B|0x0000000100000000|
 |1B|0x0000000100000001|
 |1B|0x0000000100000002|
 |1B|0x0000000100000003|
 ...
 |1B|0x0000000100003c48|関数へのポインタ test
 ...
 |1B|0x0000000100003cc8|関数へのポインタ test2
 ...
 |1B|0x0000000100003efe|文字列リテラル "abc"
 ...
 |1B|0x0000000100008000|グローバル変数 b
 |1B|0x0000000100008004|staticなローカル変数 c
 |1B|0x0000000100008008|ファイル内定数 a
 ...
 ...
 |1B|0x000000016fdff27c|ローカル変数 i, i3
 ...
 |1B|0x000000016fdff2a0|mallocで確保
 ...
 
 */
