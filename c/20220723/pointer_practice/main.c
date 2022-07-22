#include <stdio.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello World\n");
    
    // void型そのものは変数宣言できず、コンパイルエラー
//    void a = NULL;
    
    // void型のpointerは宣言できる
    // void*型は、汎用ポインタと呼ばれ、単にアドレスを格納するもの
    void * b = NULL;
    
    int a = 100000;
    
    printf("a: %d\n", a); // 100000
    printf("&a: %p\n", &a); // 0x16fdff294
    
    int *p;
    p = &a;
    printf("p: %p\n", p); // 0x16fdff294
    printf("&p: %p\n", &p); // 0x16fdff288
    
    printf("p+1: %p\n", p+1); // 0x16fdff298
    
    /*
     |1B|16fdff288|*pポインタが格納されている先頭アドレス
     |1B|16fdff289|
     |1B|16fdff28a|
     |1B|16fdff28b|
     |1B|16fdff28c|
     |1B|16fdff28d|
     |1B|16fdff28e|
     |1B|16fdff28f|
     |1B|16fdff290|
     |1B|16fdff291|
     |1B|16fdff292|
     |1B|16fdff293|42 ↑?
     |1B|16fdff294|40 aが格納されている先頭アドレス
     |1B|16fdff295|42 ↓?
     |1B|16fdff296|
     |1B|16fdff297|
     |1B|16fdff298|pを1足すと、aが格納されているアドレスから4バイト分移動
     
     
     100000 = 0x000F4240
     バイトオーダ的には、格納され方はおそらく
     40 42 0F 00
     である。ただどちらに格納されてるかちょっとわからんが、ポインタの演算的に+すると素直に高アドレスに
     行くところを見ると
     
     |1B|16fdff293|00 ↑?
     |1B|16fdff294|40
     |1B|16fdff295|42
     |1B|16fdff296|0F
     |1B|16fdff297|00
     
     */
    
    
    
    return 0;
}
