#include <stdio.h>

void test(int *i1, int *i2) {
    
    printf("@@ test(int *i1, int *i2)\n");
    
    printf("i1: %p\n", i1);
    printf("i2: %p\n", i2);
    
    printf("&i1: %p\n", &i1);
    printf("&i2: %p\n", &i2);
    
    *i1 = 10;
    *i2 = 5;
}

int main(void)
{
    int i1;
    int i2;
    
    printf("@@ main before test\n");
    
    printf("i1: %p\n", &i1);
    printf("i2: %p\n", &i2);
    
    test(&i1, &i2);
    
    printf("@@ main after test\n");
    
    printf("&i1: %p\n", &i1);
    printf("&i2: %p\n", &i2);
    
    return 0;
}

/*
 出力結果
 
 @@ main before test
 i1: 0x16fdff2a8
 i2: 0x16fdff2a4
 @@ test(int *i1, int *i2)
 i1: 0x16fdff2a8
 i2: 0x16fdff2a4
 &i1: 0x16fdff268
 &i2: 0x16fdff260
 @@ main after test
 &i1: 0x16fdff2a8
 &i2: 0x16fdff2a4

*/

/*
 
 // 本当は、アドレスは8byteあるが、記載の便宜上5byteにしている
 
 
 |メモリサイズ|アドレス|
 |1B|0x0000000000|
 |1B|0x0000000001|
 |1B|0x0000000002|
 |1B|0x0000000003|
 ...
 ...
 |1B|0x016fdff260|a4 test関数内のi2(先頭アドレス)
 |1B|0x016fdff261|f2 ポインタ(8byte)が、0x016fdff260 ~ 0x016fdff267 で格納されている
 |1B|0x016fdff262|df
 |1B|0x016fdff263|6f
 |1B|0x016fdff264|01
 |1B|0x016fdff265|00
 |1B|0x016fdff266|00
 |1B|0x016fdff267|00
 |1B|0x016fdff268|a8 test関数内のi1(先頭アドレス)
 |1B|0x016fdff269|f2 ポインタ(8byte)が、0x016fdff260 ~ 0x016fdff267 で格納されている
 |1B|0x016fdff26a|df
 |1B|0x016fdff26b|6f
 |1B|0x016fdff26c|01
 |1B|0x016fdff26d|00
 |1B|0x016fdff26e|00
 |1B|0x016fdff26f|00
 |1B|0x016fdff270|
 ...
 ...
 |1B|0x016fdff2a4|05 main関数内のi2(先頭アドレス)
 |1B|0x016fdff2a5|00 int(4byte)が、0x016fdff2a4 ~ 0x016fdff2a7 で格納されている
 |1B|0x016fdff2a6|00
 |1B|0x016fdff2a7|00
 |1B|0x016fdff2a8|0a main関数内のi1(先頭アドレス)
 |1B|0x016fdff2a9|00 int(4byte)が、0x016fdff2a4 ~ 0x016fdff2a7 で格納されている
 |1B|0x016fdff2aa|00
 |1B|0x016fdff2ab|00
 |1B|0x016fdff2ac|
 |1B|0x016fdff2ad|
 |1B|0x016fdff2ae|
 |1B|0x016fdff2af|
 
 スタックのルール上、高いアドレスから低いアドレスに向かって格納されるのが理由で
 呼び出された関数の早い方から、アドレスが高くなっている
 
 [低アドレス]
 ↑
 0x16fdff260 test関数内i2
 0x16fdff268 test関数内i1
 0x16fdff2a4 main関数内i2
 0x16fdff2a8 main関数内i1
 ↓
 [高アドレス]
 
 */
