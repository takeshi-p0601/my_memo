#include <stdio.h>

void test(int ti);
void test2(const int ti);

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello World\n");
    
    int i = 10;
    i = 5;
    test(i);
    
    const int i2 = 10;
    /*
     // 実行できない
     i2 = 5;
     */
    test(i2);
    return 0;
}

void test(int ti) {
    printf("%d\n", ti);
    ti = 3;
    printf("%d\n", ti);
}

void test2(const int ti) {
    printf("%d\n", ti);
    /*
     下のコードが実行できない。
    ti = 3;
    printf("%d\n", ti);
     */
}
