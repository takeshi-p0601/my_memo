//
//  main.c
//  cTest
//
//  Created by Takeshi Komori on 2022/07/23.
//

#include <stdio.h>
#include "second.h"
#include "third.h"

#ifdef __APPLE__
#define KOMORI  "1"
#else
#define KOMORI  "2"
#endif

static void test(void);

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    printf(__FILE__"\n"); // 事前定義済みマクロ
    test();
    
    printf(KOMORI"\n");
    printf(KOMORI2"\n"); // second.hをインクルードして、呼び出せるようにする
    hogeMaru(); // second.hをインクルードしたことにより、呼び出しファイルでプロトタイプ宣言せずとも実行可能
    
    return 0;
}

void test() {
    printf(__FILE_NAME__"\n");
}

void hogeMaru() {
    printf("hogeMaru\n");
    printf("%d\n", hoge);
    
    // 1. third.hをみに行く
    // 2. testThirdがあることを確認し、testThirdの実態が実装されているthird.cに行く
    // 3. third.cに定義してあるtestThirdメソッドを実行
    // ※この時、third.cに定義してあるtestThirdメソッドは、externをつける必要がある
    printf("%c\n", testThird());
    
    // ※おそらくイレギュラーなパターン
    // 
    testFource();
}

void testFource() {
    printf("testFource\n");
}

